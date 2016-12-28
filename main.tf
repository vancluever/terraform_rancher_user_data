/**
 * # terraform_rancher_user_data
 * 
 * Module `terraform_rancher_user_data` is a companion module to
 * [`terraform_rancher_service`][1]. Together, they allow one to generate the
 * full `cloud-config` file used to bootstrap the launch of a [RancherOS][2]
 * instance with initial configuration data and the Docker containers that it
 * should be running. In addition to initial services from the
 * `terraform_rancher_service` module, this module should be used to configure
 * any base-level configuration, such as the system hostname.
 *
 * [1]: https://github.com/vancluever/terraform_rancher_service
 * [2]: http://rancher.com/rancher-os/
 *
 * 
 * Usage Example (in AWS):
 * 
 *     // example_service provides our sample service.
 *     module "example_service" {
 *       source       = "github.com/vancluever/terraform_rancher_service"
 *       service_name = "nginx"
 *     
 *       dockerfile_data = <<EOS
 *     FROM nginx:latest
 *     EOS
 *     
 *       image_name = "nginx"
 *     }
 *     
 *     // example_user_data provides our rendered user data.
 *     module "example_user_data" {
 *       source                  = "github.com/vancluever/terraform_rancher_user_data"
 *       write_files_entries     = ["${module.example_service.write_files_entry}"]
 *       rancher_service_entries = ["${module.example_service.rancher_service_data}"]
 *     }
 *     
 *     output "rendered" {
 *       value = "${module.example_user_data.rendered}"
 *     }
 *     
 *     resource "aws_instance" "web" {
 *       ami           = "ami-1234567"
 *       instance_type = "t2.micro"
 *       user_data     = "${module.example_user_data.rendered}"
 *     }
 *
 */

