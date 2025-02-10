resource "aws_vpc_peering_connection" "peering" {
 count=var.is_peering_required ? 0 : 1
  peer_vpc_id   = local.default_vpc_id #requester
  vpc_id        = aws_vpc.main.id #accepter
  auto_accept   = true
  tags =merge(var.common_tags, 
  var.vpc_peering_tags,
  {
    Name =local.resource
  })

}
resource "aws_route" "public-peering" {
    count =var.is_peering_required ?0 :1
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}
resource "aws_route" "private-peering" {
    count =var.is_peering_required ?0 :1
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}
resource "aws_route" "database-peering" {
    count =var.is_peering_required ?0 :1
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = local.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}
resource "aws_route" "default-peering" {
    count =var.is_peering_required ?0 :1
  route_table_id            = data.aws_route_table.default.route_table_id
  destination_cidr_block    =var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}