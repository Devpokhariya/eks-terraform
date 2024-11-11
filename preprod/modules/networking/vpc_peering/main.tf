
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.source_vpc_id
  peer_vpc_id   = var.destination_vpc_id
  auto_accept   = true
  tags = {
    Name = "vpc-peering-${var.cluster_name}-to-destination"
  }
}

# Route for Source VPC to Destination VPC
resource "aws_route" "source_to_destination" {
  route_table_id            = aws_vpc.main.route_table.id # Adjust as needed
  destination_cidr_block    = var.destination_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route for Destination VPC to Source VPC
resource "aws_route" "destination_to_source" {
  route_table_id            = aws_vpc_peer.route_table.id 
  destination_cidr_block    = var.source_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
