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

variable "bastion_allowed_cidrs" {
  description = "Bastion Host Allowed CIDRs"
  type        = list(string)
}

variable "db_default_schema" {
    description = "Database Default Schema Name"
    type        = string
}

variable "db_root_password" {
    description = "Database Root Password"
    type        = string
}

variable "db_user_id" {
    description = "Database Normal User ID"
    type        = string
}

variable "db_user_password" {
    description = "Database Normal User Password"
    type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = [
    "10.1.1.0/24"
  ]
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = [
    "10.2.1.0/24",
    "10.2.2.0/24",
    "10.2.3.0/24",
    "10.2.4.0/24"
  ]
}

variable "server_root_pass" {
  description = "Server Root Password"
  type        = string
}