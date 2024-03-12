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

resource "local_sensitive_file" "kube_config" {
  content_base64 = linode_lke_cluster.lke-cluster.kubeconfig
  filename = var.kube_config_filepath
}

output "lke_dashboard_url" {
  value = linode_lke_cluster.lke-cluster.dashboard_url
}
