module "vpc" {
        source = "https://github.com/YamunaRavooru/practice-tf-modules/tree/main/module"
        project_name = var.project
        environment= var.environment
        cidr_block =var.cidr_block_vpc

}