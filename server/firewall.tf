resource "linode_firewall" "server_firewall" {
  label = "${var.environment}-${var.project}-server"

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"
  
  inbound {
    label    = "allow-private-subnet"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4 = var.private_subnet_cidr
  }

  inbound {
    label    = "allow-public-subnet"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4 = var.public_subnet_cidr
  }

  inbound {
    label = "allow-linode-region-ip"
    action = "ACCEPT"
    protocol = "TCP"
    ports = "80"
    ipv4 = ["192.168.255.0/24"]
  }

  depends_on = [linode_vpc_subnet.public_subnet, linode_vpc_subnet.private_subnet]
}

resource "linode_firewall" "database_firewall" {
  label = "${var.environment}-${var.project}-database"

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-private-subnet"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4 = var.private_subnet_cidr
  }

  inbound {
    label    = "allow-public-subnet"
    action   = "ACCEPT"
    protocol = "TCP"
    ipv4 = var.public_subnet_cidr
  }

  depends_on = [linode_vpc_subnet.public_subnet, linode_vpc_subnet.private_subnet]
}

resource "linode_firewall" "bastion_host_firewall" {
  label = "${var.environment}-${var.project}-bastion"

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allowed-access-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = var.bastion_allowed_cidrs
  }
}

resource "linode_firewall" "nodebalancer_firewall" {
  label = "${var.environment}-${var.project}-nb-fw"

  inbound_policy = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allowed-access-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allowed-access-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
}