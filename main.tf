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
   map_public_ip_on_launch = true
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
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags =merge(var.common_tags,
   {
    Name = "${local.resource}-public"
  })
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags =merge(var.common_tags,
   {
    Name = "${local.resource}-private"
  })
}
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags =merge(var.common_tags,
   {
    Name = "${local.resource}-database"
  })
}
resource "aws_eip" "nat" {
  domain       = "vpc"
}
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags =merge(var.common_tags,
   {
    Name =local.resource
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
  
}
resource "aws_route" "private" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.example.id
  
}
resource "aws_route" "database" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.example.id
  
}