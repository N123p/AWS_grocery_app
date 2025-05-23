output "public_subnet_ids" {
  value = aws_subnet.public[*].id # Make sure public subnets are defined with `count`
}

output "private_subnet_ids" {
  description = "The list of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.default.name
}