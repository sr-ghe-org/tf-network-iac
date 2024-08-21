iam_configs = {
  iam_role_bindings = {
    tfc_ws_sa_binding = {
      project_id            = "cap-prod-network-3a4b"
      service_account_email = "cap-dep-prod-prod-sa-network@cap-prod-network-3a4b.iam.gserviceaccount.com"
      roles = [
        # "roles/compute.networkAdmin",
        # "roles/compute.securityAdmin"
      ]
    }
  }
}
