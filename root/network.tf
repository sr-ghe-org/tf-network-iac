locals {
  routers = merge([
    for vpc_name, vpc_details in var.network_configs.vpc :
    {
      for router_name, router_config in vpc_details.routers :
      "${vpc_name}_${router_name}" => merge(
        router_config,
        { "project_id" = vpc_details.project_id },
        { "vpc_name" = vpc_name }
      )
    }
  ]...)
}

module "nat" {
  source                              = "terraform-google-modules/cloud-nat/google"
  version                             = "5.0.0"
  for_each                            = var.network_configs.cloud_nat
  project_id                          = each.value.project_id
  region                              = each.value.region
  router                              = each.value.router
  name                                = each.value.name
  enable_dynamic_port_allocation      = each.value.enable_dynamic_port_allocation
  enable_endpoint_independent_mapping = each.value.enable_endpoint_independent_mapping
  min_ports_per_vm                    = each.value.min_ports_per_vm
  max_ports_per_vm                    = each.value.max_ports_per_vm
  log_config_enable                   = each.value.log_config_enable
  log_config_filter                   = each.value.log_config_filter
  depends_on                          = [module.router]
}

module "router" {
  source   = "terraform-google-modules/cloud-router/google"
  version  = "6.0"
  for_each = local.routers
  name     = each.value.name
  project  = each.value.project_id
  region   = each.value.region
  network  = module.vpc[each.value.vpc_name].network_name
}

module "vpc" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "9.1"
  for_each                               = var.network_configs.vpc
  project_id                             = each.value.project_id
  network_name                           = each.value.name
  routing_mode                           = each.value.routing_mode
  delete_default_internet_gateway_routes = each.value.delete_default_internet_gateway_routes
  subnets                                = each.value.subnets
  secondary_ranges                       = each.value.secondary_ranges
}

module "routes" {
  source       = "terraform-google-modules/network/google//modules/routes"
  version      = "9.1.0"
  for_each     = var.network_configs.vpc
  project_id   = each.value.project_id
  network_name = module.vpc[each.key].network_name
  routes       = each.value.routes
}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "9.1.0"
  for_each     = var.network_configs.vpc
  project_id   = each.value.project_id
  network_name = module.vpc[each.key].network_name
  rules        = each.value.firewall_rules
}