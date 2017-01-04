// module terraform_rancher_user_data

// A list of `write_files` entries to assemble into a complete `write_files`
// section.
variable "write_files_entries" {
  type    = "list"
  default = []
}

// A list of Rancher/Docker Compose services entries to assemble into the final
// `rancher` section in the config.
variable "rancher_service_entries" {
  type = "list"
}

// Use ECR. This downloads the [AWS ECR Credential
// Helper](https://github.com/awslabs/amazon-ecr-credential-helper), and adds
// it as a credential store in `/home/rancher/.docker/config.json`. This will
// allow the use of ECR without the need to ship ECR credentials.
variable "use_ecr" {
  type    = "string"
  default = "false"
}
