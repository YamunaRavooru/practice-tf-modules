module "vpc" {
        sourse = "terraform-vpc-module/moule"
        project_name = var.project
        environment= var.environment
        cidr_block =var.cidr_block_vpc

}