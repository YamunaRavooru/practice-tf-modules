resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = true
  enable_dns_support =var.enable_dns_support
  tags =merge(var.common_tags, 
  {
    Name = local.resource
  })
}