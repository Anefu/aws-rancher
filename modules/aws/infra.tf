resource "aws_vpc" "rancher_vpc" {
    cidr_block = var.cidr_block
    tags = merge({
        Name = "${var.cluster_name}-VPC"
    }, var.common_tags)
}
# Fetch availability zones
data "aws_availability_zones" "available" {
    state = "available"
}

#Create subnets
resource "aws_subnet" "rancher_master_subnets" {
    vpc_id = aws_vpc.rancher_vpc.id
    count = var.master_subnets_count
    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block = cidrsubnet(var.cidr_block, 4, count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.cluster_name}-master-${count.index}"
    }
}

resource "aws_subnet" "rancher_worker_subnets" {
    vpc_id = aws_vpc.rancher_vpc.id
    count = var.worker_subnets_count
    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block = cidrsubnet(var.cidr_block, 4, count.index+2)
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.cluster_name}-worker-${count.index}"
    }
}

#Create IGW
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.rancher_vpc.id
  tags   = {
      Name = "${var.cluster_name}-IGW"
  }
}

resource "aws_route_table" "master_rtb" {
  vpc_id = aws_vpc.rancher_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "${var.cluster_name}-rtb"
  }
}

resource "aws_route_table" "worker_rtb" {
  vpc_id = aws_vpc.rancher_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "${var.cluster_name}-rtb"
  }
}