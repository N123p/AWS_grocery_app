output "instance_profile_name" {
  description = "EC2 instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "role_name" {
  description = "IAM Role name"
  value       = aws_iam_role.ec2_role.name
}
