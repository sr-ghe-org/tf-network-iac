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

output "iam_roles" {
  value = google_project_iam_member.sa_role_binding
}


