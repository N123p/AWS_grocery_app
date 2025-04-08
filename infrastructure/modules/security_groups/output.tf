output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.rds_sg.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.rds_sg.name
}

output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}
output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}