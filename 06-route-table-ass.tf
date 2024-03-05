resource "aws_route_table_association" "peppa-pig-association-1" {
  subnet_id      = aws_subnet.node-1.id
  route_table_id = aws_route_table.nodes.id
}

resource "aws_route_table_association" "pappa-pig-association-2" {
  subnet_id      = aws_subnet.node-2.id
  route_table_id = aws_route_table.nodes.id
}

resource "aws_route_table_association" "peppa-pig-association-3" {
  subnet_id      = aws_subnet.monitoring.id
  route_table_id = aws_route_table.nodes.id
}













