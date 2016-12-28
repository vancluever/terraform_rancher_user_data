// The name of the service.
variable "service_name" {
  type    = "string"
  default = "example_service"
}

// The Dockerfile data.
variable "dockerfile_data" {
  type = "string"

  default = <<EOS
FROM ubuntu:16.04
EOS
}

// The image name.
variable "image_name" {
  type    = "string"
  default = ""
}

// example_service provides our sample service.
module "example_service" {
  source          = "github.com/vancluever/terraform_rancher_service"
  service_name    = "${var.service_name}"
  dockerfile_data = "${var.dockerfile_data}"
  image_name      = "${var.image_name}"
}

// example_user_data provides our rendered user data.
module "example_user_data" {
  source                  = "../"
  write_files_entries     = ["${module.example_service.write_files_entry}"]
  rancher_service_entries = ["${module.example_service.rancher_service_data}"]
}

// The fully assembled cloud-config YAML file to be used as user data.
//
// Note that in real-world use, you do not want to include the leading line
// break. It is only present to make the human-readable output in TF render on
// a unindented newline.
output "rendered" {
  value = "\n${module.example_user_data.rendered}"
}
