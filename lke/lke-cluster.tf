resource "linode_lke_cluster" "lke-cluster" {
    label       = format(module.naming.result, "lke-cluster")
    k8s_version = "1.28"
    region      = var.region
    tags        = [var.project, var.environment]

    pool {
        type  = "g6-standard-1"
        count = 3
    }
}