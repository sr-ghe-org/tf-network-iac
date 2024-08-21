<!-- BEGIN_TF_DOCS -->
## Usage

```hcl 
module "mgz" {
  source = "../../root"
  network_configs = {
    cloud_nat = {
      devops-nonprod-uc1 = {
        project_id = "nonprod-network-prjct"
        router     = "router-devops-nonprod-uc1"
        name       = "nat-devops-nonprod-uc1"
        region     = "us-central1"
      }
    }
    vpc = {
      devops-nonprod = {
        project_id                             = "cap-nonprod-network-0fd3"
        name                                   = "vpc-devops-nonprod"
        routing_mode                           = "GLOBAL"
        delete_default_internet_gateway_routes = true
        shared_vpc_host                        = true
        subnets = [
          {
            subnet_name               = "subnet-devops-nonprod-uc1",
            subnet_ip                 = "10.4.4.0/24",
            subnet_region             = "us-central1",
            subnet_private_access     = "true"
            subnet_flow_logs          = "true"
            subnet_flow_logs_interval = "INTERVAL_30_SEC"
            subnet_flow_logs_sampling = 0.1
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
          }
        ]
        secondary_ranges = {
          subnet-devops-nonprod-uc1 = [
            {
              range_name    = "secrange-devops-nonprod-pods-uc1"
              ip_cidr_range = "100.94.0.0/16"
            },
            {
              range_name    = "secrange-devops-nonprod-svc-uc1"
              ip_cidr_range = "100.95.0.0/16"
            }
          ]
        }
        routers = {
          uc1 = {
            name   = "router-devops-nonprod-uc1"
            region = "us-central1"
          }
        }
        routes = [
          {
            name              = "route-devops-nonprod-intgwy"
            description       = ""
            destination_range = "0.0.0.0/0"
            tags              = ""
            next_hop_internet = "true"
          }
        ]
        firewall_rules = [
          {
            name               = "fwr-devops-nonprod-egr-allow-default"
            description        = "default egress allow"
            direction          = "EGRESS"
            priority           = 65534
            destination_ranges = ["0.0.0.0/0"]
            allow = [{
              protocol = "all"
              ports    = []
            }]
            deny = []
          }
        ]
      }
    }
  }
  /* IAM Permissions are added to the network deployment SA will onbarding the network EPM code through platform onboarding module. Adding example */
  iam_configs = {
    iam_role_bindings = {
      tfc_ws_sa_binding = {
        project_id            = "cap-nonprod-wif-bee9"
        service_account_email = "cap-dep-nonprod-nonprod-sa-wif@cap-nonprod-wif-bee9.iam.gserviceaccount.com"
        roles = [
          # "roles/compute.networkAdmin",
          # "roles/compute.securityAdmin"
        ]
      }
    }
  }
}
```
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall_rules"></a> [firewall\_rules](#module\_firewall\_rules) | terraform-google-modules/network/google//modules/firewall-rules | 9.1.0 |
| <a name="module_nat"></a> [nat](#module\_nat) | terraform-google-modules/cloud-nat/google | 5.0.0 |
| <a name="module_router"></a> [router](#module\_router) | terraform-google-modules/cloud-router/google | 6.0 |
| <a name="module_routes"></a> [routes](#module\_routes) | terraform-google-modules/network/google//modules/routes | 9.1.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | 9.1 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.sa_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_configs"></a> [iam\_configs](#input\_iam\_configs) | IAM Configurations | <pre>object({<br>    iam_role_bindings = map(object({<br>      project_id            = string<br>      service_account_email = string<br>      roles                 = list(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_network_configs"></a> [network\_configs](#input\_network\_configs) | Management zone config | <pre>object({<br>    cloud_nat = map(object({<br>      project_id                          = string<br>      region                              = string<br>      name                                = string<br>      router                              = string<br>      enable_dynamic_port_allocation      = optional(bool)<br>      enable_endpoint_independent_mapping = optional(bool)<br>      min_ports_per_vm                    = optional(number)<br>      max_ports_per_vm                    = optional(number)<br>      log_config_enable                   = optional(bool)<br>      log_config_filter                   = optional(string)<br>    }))<br>    vpc = optional(map(object({<br>      project_id                             = string<br>      name                                   = string<br>      routing_mode                           = string<br>      delete_default_internet_gateway_routes = bool<br>      subnets = list(object(<br>        {<br>          subnet_name               = string,<br>          subnet_ip                 = string,<br>          subnet_region             = string,<br>          subnet_private_access     = string,<br>          subnet_flow_logs          = optional(string)<br>          subnet_flow_logs_interval = optional(string)<br>          subnet_flow_logs_sampling = optional(number)<br>          subnet_flow_logs_metadata = optional(string)<br>          purpose                   = optional(string)<br>          role                      = optional(string)<br>        })<br>      )<br>      secondary_ranges = map(list(object({ range_name = string, ip_cidr_range = string })))<br>      routers = optional(map(object({<br>        name   = string<br>        region = string<br><br>      })), {})<br>      routes = optional(list(map(string)), [])<br>      firewall_rules = list(object({<br>        name                    = string<br>        description             = optional(string, null)<br>        direction               = optional(string, "INGRESS")<br>        disabled                = optional(bool, null)<br>        priority                = optional(number, null)<br>        ranges                  = optional(list(string), [])<br>        source_tags             = optional(list(string))<br>        source_service_accounts = optional(list(string))<br>        target_tags             = optional(list(string))<br>        target_service_accounts = optional(list(string))<br><br>        allow = optional(list(object({<br>          protocol = string<br>          ports    = optional(list(string))<br>        })), [])<br>        deny = optional(list(object({<br>          protocol = string<br>          ports    = optional(list(string))<br>        })), [])<br>        log_config = optional(object({<br>          metadata = string<br>        }))<br>      }))<br>    })), {})<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_rules"></a> [firewall\_rules](#output\_firewall\_rules) | n/a |
| <a name="output_iam_roles"></a> [iam\_roles](#output\_iam\_roles) | n/a |
| <a name="output_nat"></a> [nat](#output\_nat) | n/a |
| <a name="output_router"></a> [router](#output\_router) | n/a |
| <a name="output_routes"></a> [routes](#output\_routes) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
<!-- END_TF_DOCS -->