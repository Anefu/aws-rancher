resource "rancher2_auth_config_openldap" "openldap" {
  servers = ["${var.ldap_server}"]
  service_account_distinguished_name = "${var.service_account_dn}"
  service_account_password = "${var.service_account_password}"
  user_search_base = "${var.user_search_base}"
  port = var.ldap_port
  test_username = "${var.ldap_test_username}"
  test_password = "${var.ldap_test_password}"
  access_mode = var.access_mode
}