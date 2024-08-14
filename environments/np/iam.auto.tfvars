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
