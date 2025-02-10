variable "project_name"{
    
}
variable "environment"{

}
variable "common_tags"{
    default={
        project_name ="expense"
        environment= "dev"
        terraform="true"
    }
}
variable "cidr_block"{
    
}
variable enable_dns_support{
    default= true
}
variable "public_subnet_cidr"{

}
variable "public_subnet_tags"{
    default={}
}