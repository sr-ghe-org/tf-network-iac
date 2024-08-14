output "vpc" {
  value = module.vpc
}

output "nat" {
  value = module.nat
}

output "router" {
  value = module.router
}

output "routes" {
  value = module.routes
}

output "firewall_rules" {
  value = module.firewall_rules
}