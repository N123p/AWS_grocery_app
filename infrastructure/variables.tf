variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"  # Ensure this matches your AWS region
}

variable "aws_availability_zone" {
  description = "AWS availability zone"
  default     = "us-east-1a"  # Updated to match AWS region
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  default     = "ami-05b10e08d247fb927"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "myadmin"
}


variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "profile" {
  description = "AWS profile name"
  type        = string
  default     = "my_web_app_1"
}