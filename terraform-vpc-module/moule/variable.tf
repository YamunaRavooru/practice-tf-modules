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
