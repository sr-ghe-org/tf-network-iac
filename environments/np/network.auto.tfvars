network_configs = {
  cloud_nat = {
    devops-nonprod-uc1 = {
      project_id = "cap-nonprod-network-0fd3"
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

