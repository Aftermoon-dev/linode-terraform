resource "linode_nodebalancer" "server_nb" {
    label  = "${var.environment}-${var.project}-server-nb"
    region = var.region
}

resource "linode_nodebalancer_config" "http-nb-config" {
    nodebalancer_id = linode_nodebalancer.server_nb.id
    port = 80
    protocol = "http"
    check = "none"
    stickiness = "none"
    algorithm = "roundrobin"

    lifecycle {
        replace_triggered_by = [linode_instance.server.id]
    }
}

resource "linode_nodebalancer_node" "server_nb_node_http" {
    nodebalancer_id = linode_nodebalancer.server_nb.id
    config_id       = linode_nodebalancer_config.http-nb-config.id
    address         = "${linode_instance.server.private_ip_address}:8080"
    label           = "${var.environment}-${var.project}-node"
    weight          = "100"
    mode = "accept"

    lifecycle {
        replace_triggered_by = [linode_instance.server.id]
    }
}
