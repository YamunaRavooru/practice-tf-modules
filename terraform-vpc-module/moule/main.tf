resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags =merge(var.common_tags, 
  {
    Name = local.resource
  })
}