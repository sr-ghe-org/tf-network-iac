iam_configs = {
  iam_role_bindings = {
    tfc_ws_sa_binding = {
      project_id            = "cap-nonprod-network-0fd3"
      service_account_email = "cap-dep-nonprod-np-sa-network@cap-nonprod-network-0fd3.iam.gserviceaccount.com"
      roles = [
        # "roles/compute.networkAdmin",
        # "roles/compute.securityAdmin"
      ]
    }
  }
}
