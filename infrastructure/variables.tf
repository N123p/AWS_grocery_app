variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "AWS availability zone"
  default     = "us-east-1a"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair Name for EC2"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string

}


variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "profile" {
  description = "AWS profile name"
  type        = string

}

variable "my_ip" {
  description = "Your public IP for security group access"
  type        = string
}