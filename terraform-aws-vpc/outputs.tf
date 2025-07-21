output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "public_subnets" {
  description = "Map of public subnets with custom keys"
  value = {
    for i, subnet in aws_subnet.public : "sub${i + 1}" => subnet
  }
}

output "private_subnets" {
  description = "Map of private subnets with custom keys"
  value = {
    for i, subnet in aws_subnet.private : "sub${i + 3}" => subnet
  }
}

# Agregado: Outputs para route tables
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}