/*
  us-central1 - IOWA
  nane1 - northamerica-northeast1
  nane2 - northamerica-northeast2

  Please note : subnet_flow_logs_sampling is set to 0.1 sec.
*/

network_configs = {
  cloud_nat = {
    devops-nonprod-uc1 = {
      project_id = "cap-nonprod-network-0fd3"
      router     = "router-devops-nonprod-uc1"
      name       = "nat-devops-nonprod-uc1"
      region     = "us-central1"
    },
    devops-prod-nane1 = {
      project_id = "cap-nonprod-network-0fd3"
      router     = "router-devops-nonprod-nane1"
      name       = "nat-devops-nonprod-nane1"
      region     = "northamerica-northeast1"
    },
    devops-prod-nane2 = {
      project_id = "cap-nonprod-network-0fd3"
      router     = "router-devops-nonprod-nane2"
      name       = "nat-devops-nonprod-nane2"
      region     = "northamerica-northeast2"
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
        },
        {
          subnet_name               = "subnet-devops-nonprod-nane1",
          subnet_ip                 = "10.7.7.0/24",
          subnet_region             = "northamerica-northeast1",
          subnet_private_access     = "true"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_30_SEC"
          subnet_flow_logs_sampling = 0.1
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        },
        {
          subnet_name               = "subnet-devops-nonprod-nane2",
          subnet_ip                 = "10.8.8.0/24",
          subnet_region             = "northamerica-northeast2",
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
        ],
        subnet-devops-nonprod-nane1 = [
          {
            range_name    = "secrange-devops-nonprod-pods-nane1"
            ip_cidr_range = "100.98.0.0/16"
          },
          {
            range_name    = "secrange-devops-nonprod-svc-nane1"
            ip_cidr_range = "100.99.0.0/16"
          }
        ],
        subnet-devops-nonprod-nane2 = [
          {
            range_name    = "secrange-devops-nonprod-pods-nane2"
            ip_cidr_range = "100.81.0.0/16"
          },
          {
            range_name    = "secrange-devops-nonprod-svc-nane2"
            ip_cidr_range = "100.82.0.0/16"
          }
        ]
      }
      routers = {
        uc1 = {
          name   = "router-devops-nonprod-uc1"
          region = "us-central1"
        },
        nane1 = {
          name   = "router-devops-nonprod-nane1"
          region = "northamerica-northeast1"
        },
        nane2 = {
          name   = "router-devops-nonprod-nane2"
          region = "northamerica-northeast2"
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
      firewall_rules = {
        egress = [
          {
            name               = "fwr-devops-nonprod-egr-allow-default"
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

