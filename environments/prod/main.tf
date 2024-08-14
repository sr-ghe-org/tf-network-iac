module "mgz" {
  source          = "../../root"
  network_configs = var.network_configs
  iam_configs     = var.iam_configs
}