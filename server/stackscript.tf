resource "linode_stackscript" "mysql_server" {
    images = ["linode/ubuntu20.04"]
    label = "mysql_server"
    description = "Install MySQL on Linode"
    script = file("./stackscript/install_mysql.sh")
}