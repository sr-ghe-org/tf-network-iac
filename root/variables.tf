variable "iam_configs" {
  description = "IAM Configurations"
  type = object({
    iam_role_bindings = map(object({
      project_id            = string
      service_account_email = string
      roles                 = list(string)
    }))
  })
}

variable "network_configs" {
  description = "Management zone config"
  type = object({
    cloud_nat = map(object({
      project_id                          = string
      region                              = string
      name                                = string
      router                              = string
      enable_dynamic_port_allocation      = optional(bool)
      enable_endpoint_independent_mapping = optional(bool)
      min_ports_per_vm                    = optional(number)
      max_ports_per_vm                    = optional(number)
      log_config_enable                   = optional(bool)
      log_config_filter                   = optional(string)
    }))
    vpc = optional(map(object({
      project_id                             = string
      name                                   = string
      routing_mode                           = string
      delete_default_internet_gateway_routes = bool
      subnets = list(object(
        {
          subnet_name               = string,
          subnet_ip                 = string,
          subnet_region             = string,
          subnet_private_access     = string,
          subnet_flow_logs          = optional(string)
          subnet_flow_logs_interval = optional(string)
          subnet_flow_logs_sampling = optional(number)
          subnet_flow_logs_metadata = optional(string)
          purpose                   = optional(string)
          role                      = optional(string)
        })
      )
      secondary_ranges = map(list(object({ range_name = string, ip_cidr_range = string })))
      routers = optional(map(object({
        name   = string
        region = string

      })), {})
      routes = optional(list(map(string)), [])
      firewall_rules = list(object({
        name                    = string
        description             = optional(string, null)
        direction               = optional(string, "INGRESS")
        disabled                = optional(bool, null)
        priority                = optional(number, null)
        ranges                  = optional(list(string), [])
        source_tags             = optional(list(string))
        source_service_accounts = optional(list(string))
        target_tags             = optional(list(string))
        target_service_accounts = optional(list(string))

        allow = optional(list(object({
          protocol = string
          ports    = optional(list(string))
        })), [])
        deny = optional(list(object({
          protocol = string
          ports    = optional(list(string))
        })), [])
        log_config = optional(object({
          metadata = string
        }))
      }))
    })), {})
  })
}

