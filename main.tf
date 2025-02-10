resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy ="default"
  enable_dns_support =var.enable_dns_support
  tags =merge(var.common_tags, 
  {
    Name = local.resource
  })
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags =merge(var.common_tags,
   {
    Name =local.resource
  })
}

resource "aws_subnet" "public"{
  count=length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone=local.az_names[count.index]
  tags =merge(var.common_tags, 
          var.public_subnet_tags,
  {
    Name = "${local.resource}-public-${local.az_names[count.index]}"
  })
}
resource "aws_subnet" "private"{
  count=length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone=local.az_names[count.index]
  tags =merge(var.common_tags, 
          var.private_subnet_tags,
  {
    Name = "${local.resource}-private-${local.az_names[count.index]}"
  })
}
resource "aws_subnet" "database"{
  count=length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone=local.az_names[count.index]
  tags =merge(var.common_tags, 
          var.database_subnet_tags,
  {
    Name = "${local.resource}-database-${local.az_names[count.index]}"
  })
}