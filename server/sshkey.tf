resource "linode_sshkey" "server_key" {
  label = "${var.environment}-${var.project}-server-key"
  ssh_key = chomp(file("./sshkey/id_rsa.pub"))
}

resource "linode_sshkey" "bastion_host_key" {
  label = "${var.environment}-${var.project}-bastion-host-key"
  ssh_key = chomp(file("./sshkey/id_rsa_bastion_host.pub"))
}
