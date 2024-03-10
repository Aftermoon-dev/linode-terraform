module "naming" {
  source = "./modules/naming"

  environment  = var.environment
  project = var.project
}