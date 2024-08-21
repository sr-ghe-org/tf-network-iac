/*
  us-central1 - IOWA
  nane1 - northamerica-northeast1
  nane2 - northamerica-northeast2

  Please note : subnet_flow_logs_sampling is set to 0.1 sec.
*/


network_configs = {
  cloud_nat = {
    devops-prod-uc1 = {
      project_id = "cap-prod-network-3a4b"
      router     = "router-devops-prod-uc1"
      name       = "nat-devops-prod-uc1"
      region     = "us-central1"
    },
    devops-prod-nane1 = {
      project_id = "cap-prod-network-3a4b"
      router     = "router-devops-prod-nane1"
      name       = "nat-devops-prod-nane1"
      region     = "northamerica-northeast1"
    },
    devops-prod-nane2 = {
      project_id = "cap-prod-network-3a4b"
      router     = "router-devops-prod-nane2"
      name       = "nat-devops-prod-nane2"
      region     = "northamerica-northeast2"
    }
  }
  vpc = {
    devops-prod = {
      project_id                             = "cap-prod-network-3a4b"
      name                                   = "vpc-devops-prod"
      routing_mode                           = "GLOBAL"
      delete_default_internet_gateway_routes = true
      shared_vpc_host                        = true
      subnets = [
        {
          subnet_name               = "subnet-devops-prod-uc1",
          subnet_ip                 = "10.2.2.0/24",
          subnet_region             = "us-central1",
          subnet_private_access     = "true"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_30_SEC"
          subnet_flow_logs_sampling = 0.1
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        },
        {
          subnet_name               = "subnet-devops-prod-nane1",
          subnet_ip                 = "10.5.5.0/24",
          subnet_region             = "northamerica-northeast1",
          subnet_private_access     = "true"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_30_SEC"
          subnet_flow_logs_sampling = 0.1
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        },
        {
          subnet_name               = "subnet-devops-prod-nane2",
          subnet_ip                 = "10.6.6.0/24",
          subnet_region             = "northamerica-northeast2",
          subnet_private_access     = "true"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_30_SEC"
          subnet_flow_logs_sampling = 0.1
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        },
      ]
      secondary_ranges = {
        subnet-devops-prod-uc1 = [
          {
            range_name    = "secrange-devops-prod-pods-uc1"
            ip_cidr_range = "100.90.0.0/16"
          },
          {
            range_name    = "secrange-devops-prod-svc-uc1"
            ip_cidr_range = "100.91.0.0/16"
          }
        ],
        subnet-devops-prod-nane1 = [
          {
            range_name    = "secrange-devops-prod-pods-nane1"
            ip_cidr_range = "100.92.0.0/16"
          },
          {
            range_name    = "secrange-devops-prod-svc-nane1"
            ip_cidr_range = "100.93.0.0/16"
          }
        ],
        subnet-devops-prod-nane2 = [
          {
            range_name    = "secrange-devops-prod-pods-nane2"
            ip_cidr_range = "100.96.0.0/16"
          },
          {
            range_name    = "secrange-devops-prod-svc-nane2"
            ip_cidr_range = "100.97.0.0/16"
          }
        ]
      }
      routers = {
        uc1 = {
          name   = "router-devops-prod-uc1"
          region = "us-central1"
        },
        nane1 = {
          name   = "router-devops-prod-nane1"
          region = "northamerica-northeast1"
        },
        nane2 = {
          name   = "router-devops-prod-nane2"
          region = "northamerica-northeast2"
        }
      }
      routes = [
        {
          name              = "route-devops-prod-intgwy"
          description       = ""
          destination_range = "0.0.0.0/0"
          tags              = ""
          next_hop_internet = "true"
        }
      ]
      firewall_rules = {
        egress = [
          {
            name               = "fwr-devops-prod-egr-allow-default"
            description        = "default egress allow"
            priority           = 65534
            destination_ranges = ["0.0.0.0/0"]
            allow = [{
              protocol = "all"
              ports    = []
            }]
            deny = []
          }
      ] }
    }
  }
}

