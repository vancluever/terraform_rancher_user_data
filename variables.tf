// module terraform_user_data

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
