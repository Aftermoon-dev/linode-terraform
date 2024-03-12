terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "linode" {
  token = var.linode_access_token
}