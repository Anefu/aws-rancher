# Fetch availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "rancher_vpc" {
  cidr_block = var.cidr_block
  tags = merge({
    Name                                        = "${var.cluster_name}-VPC"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }, var.common_tags)
}

#Create subnets
resource "aws_subnet" "rancher_subnets" {
  vpc_id                  = aws_vpc.rancher_vpc.id
  count                   = var.subnets_count
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name                                        = "${var.cluster_name}-master-${count.index}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

#Create IGW
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.rancher_vpc.id
  tags = {
    Name = "${var.cluster_name}-IGW"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.rancher_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "${var.cluster_name}-rtb"
  }
}