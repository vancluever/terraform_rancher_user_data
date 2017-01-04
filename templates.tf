// module terraform_rancher_user_data

// ecr_creds_store_data provides the write_files entries for the ECR credential
// store helper.
data "template_file" "ecr_creds_store_data" {
  template = <<EOS
  - path: /home/rancher/.docker/config.json
    permissions: "0644"
    owner: rancher
    content: |
      {
        "credsStore": "ecr-login"
      }
EOS
}

// ecr_creds_store_wget_runcmd adds a runcmd entry that will wget the ECR credential
// store helper and save it to /usr/local/bin.
data "template_file" "ecr_creds_store_wget_runcmd" {
  template = <<EOS
  - ["wget", "-O", "/usr/local/bin/ecr-login", "https://github.com/vancluever/amazon-ecr-credential-helper/releases/download/v0.1.0/ecr-credential-helper"]
  - ["chmod", "+x", "/usr/local/bin/ecr-login"]
EOS
}

// rancher_user_data_template provides a template to render the full,
// near-final user data.
//
// Empty strings are replaced with "~~" - these are trimmed from the final
// content, along with any leading whitespace.
data "template_file" "rancher_user_data_template" {
  template = <<EOS
rancher:
  services:
${join("", var.rancher_service_entries)}
write_files:
${length(var.write_files_entries) > 0 ? join("", var.write_files_entries) : "~~" }
${var.use_ecr == "true" ? data.template_file.ecr_creds_store_data.rendered : "~~" }
runcmd:
${var.use_ecr == "true" ? data.template_file.ecr_creds_store_wget_runcmd.rendered : "~~" }
EOS
}
