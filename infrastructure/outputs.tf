output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_ids[0]  # Get the first public subnet
}

output "ec2_instance_id" {
  value = module.ec2_launch_template.instance_id
}

output "security_group_id" {
  value = module.security_groups.ec2_security_group_id
}
output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = module.rds.rds_id
}

output "bucket_name" {
  value       = module.s3_bucket.bucket_name
  description = "The name of the S3 bucket"
}

output "bucket_id" {
  value       = module.s3_bucket.bucket_id
  description = "The ID of the created S3 bucket."
}

output "bucket_arn" {
  value       = module.s3_bucket.bucket_arn
  description = "The ARN of the created S3 bucket."
}

output "alb_security_group_id" {
  value       = module.security_groups.alb_security_group_id
  description = "The ID of the ALB security group."
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The DNS name of the Application Load Balancer."
}

output "ec2_iam_instance_profile" {
  description = "The IAM instance profile name to be attached to EC2"
  value       = module.iam_roles_ec2.instance_profile_name
}

output "ec2_iam_role" {
  description = "The IAM Role name created for EC2"
  value       = module.iam_roles_ec2.role_name
}




