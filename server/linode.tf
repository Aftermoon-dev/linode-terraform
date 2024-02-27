resource "linode_instance" "server" {
  label           = "${var.environment}-${var.project}-private-server"
  image           = "linode/ubuntu22.04"
  region          = var.region
  type            = "g6-nanode-1"
  authorized_keys = [linode_sshkey.server_key.ssh_key]
  firewall_id     = linode_firewall.server_firewall.id
  
  interface {
    purpose   = "vpc"
    subnet_id = linode_vpc_subnet.private_subnet[0].id
    primary = true
    ipv4 {
      nat_1_1 = "any"
    }
  }

  tags       = [var.project, var.environment]
  depends_on = [linode_vpc_subnet.private_subnet, linode_sshkey.server_key, linode_firewall.server_firewall]
}

resource "linode_instance" "database" {
    label           = "${var.environment}-${var.project}-database"
    image           = "linode/ubuntu20.04"
    region          = var.region
    type            = "g6-nanode-1"
    firewall_id     = linode_firewall.database_firewall.id

    interface {
      purpose   = "vpc"
      subnet_id = linode_vpc_subnet.private_subnet[1].id
      primary = true
      ipv4 {
        nat_1_1 = "any"
      }
    }

    stackscript_id = 607026
    stackscript_data = {
        "database" = "MySQL"
        "database_name" = var.db_default_schema
        "dbroot_password" = var.db_root_password
        "dbuser" = var.db_user_id
        "dbuser_password" = var.db_user_password
    }

    tags       = [var.project, var.environment]
    depends_on = [linode_vpc_subnet.private_subnet, linode_firewall.database_firewall]
}

resource "linode_instance" "bastion_host" {
  label           = "${var.environment}-${var.project}-public-bastion-host"
  image           = "linode/ubuntu22.04"
  region          = var.region
  type            = "g6-nanode-1"
  authorized_keys = [linode_sshkey.bastion_host_key.ssh_key]
  firewall_id     = linode_firewall.bastion_host_firewall.id

  interface {
    purpose   = "vpc"
    subnet_id = linode_vpc_subnet.public_subnet[0].id
    ipv4 {
      nat_1_1 = "any"
    }
    primary = true
  }

  tags       = [var.project, var.environment]
  depends_on = [linode_vpc_subnet.public_subnet, linode_sshkey.bastion_host_key, linode_firewall.bastion_host_firewall]
}