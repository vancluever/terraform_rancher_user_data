// module terraform_rancher_user_data

// The fully assembled cloud-config YAML file to be used as user data.
output "rendered" {
  value = <<EOS
#cloud-config
write_files:
${join("", var.write_files_entries)}
rancher:
  services:
${join("", var.rancher_service_entries)}
EOS
}
