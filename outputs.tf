output "vpc_id"{
    value =aws_vpc.main.id
}
output "az_name"{
    value =data.aws_availability_zones.available
}