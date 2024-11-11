output "vpc_peering_id" {
  value = aws_vpc_peering_connection.peer.id
}

output "source_to_destination_route" {
  value = aws_route.source_to_destination.id
}

output "destination_to_source_route" {
  value = aws_route.destination_to_source.id
}
