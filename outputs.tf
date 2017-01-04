// module terraform_rancher_user_data

// The fully assembled cloud-config YAML file to be used as user data.
output "rendered" {
  value = "${replace(data.template_file.rancher_user_data_template.rendered, "/\n\\s*~~/", "")}"
}
