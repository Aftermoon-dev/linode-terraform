variable "linode_access_token" {
  description = "Linode Access Token"
  type        = string
}

variable "project" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Infra Target Environment"
  type        = string
}

variable "region" {
  description = "Infra Region"
  type        = string
}

variable "kube_config_filepath" {
  description = "Kubernetes kubeconfig File Path"
  type = string
  default = "./config"
}