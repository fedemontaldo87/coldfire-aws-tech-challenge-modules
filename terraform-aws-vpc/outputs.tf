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
