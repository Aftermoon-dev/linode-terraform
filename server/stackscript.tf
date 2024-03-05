resource "linode_stackscript" "mysql_server" {
    images = ["linode/ubuntu22.04", "linode/ubuntu20.04"]
    label = "mysql_server"
    description = "Install MySQL on Linode"
    script = file("./stackscript/install_mysql.sh")
}

resource "linode_stackscript" "cicd_server" {
    images = ["linode/ubuntu22.04", "linode/ubuntu20.04"]
    label = "cicd_server"
    description = "Set CI/CD Server"
    script = file("./stackscript/set_cicd_server.sh")
}