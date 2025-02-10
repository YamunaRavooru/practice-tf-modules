output "vpc_id"{
    value =aws_vpc.main.id
}
output "az_name"{
    value =data.aws_availability_zones.available
}
output "public_subnet_id"{
    value = aws_subnet.public[*].id
}
output "private_subnet_id"{
    value = aws_subnet.private[*].id
}
output "database_subnet_id"{
    value = aws_subnet.database[*].id
}