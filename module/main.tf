resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block

  tags =merge(var.common_tags, 
  {
    Name = local.resource
  })
}