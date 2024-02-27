resource "linode_vpc" "vpc" {
    label = "${var.environment}-${var.project}-vpc"
    region = var.region
    description = "${var.project} ${var.environment} VPC"
}

locals {
  public_vpc_cidrs = {for s in var.public_subnet_cidr: index(var.public_subnet_cidr, s) => s}
  private_vpc_cidrs = {for s in var.private_subnet_cidr: index(var.private_subnet_cidr, s) => s}
}

resource "linode_vpc_subnet" "public_subnet" {
    vpc_id = linode_vpc.vpc.id
    for_each = local.public_vpc_cidrs
    label = "${var.environment}-public-subnet-${each.key + 1}"
    ipv4 = each.value
    depends_on = [linode_vpc.vpc]
}

resource "linode_vpc_subnet" "private_subnet" {
    vpc_id = linode_vpc.vpc.id
    for_each = local.private_vpc_cidrs
    label = "${var.environment}-private-subnet-${each.key + 1}"
    ipv4 = each.value
    depends_on = [linode_vpc.vpc]
}
