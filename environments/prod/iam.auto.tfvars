iam_configs = {
  iam_role_bindings = {
    tfc_ws_sa_binding = {
      project_id            = "cap-prod-wif-7092"
      service_account_email = "cap-dep-prod-prod-sa-wif@cap-prod-wif-7092.iam.gserviceaccount.com"
      roles = [
        "roles/compute.networkAdmin",
        "roles/compute.securityAdmin"
      ]
    }
  }
}
