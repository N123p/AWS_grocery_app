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

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "aws-grocery-avatars" # Be sure to set a unique name!
}

variable "versioning_status" {
description = "The versioning status of the S3 bucket"
type = string
default = "Disabled"
}

variable "lifecycle_status" {
description = "Lifecycle policy status"
type = string
default = "Disabled"
}

variable "expiration_days" {
description = "The number of days to wait before deleting objects"
type = number
default = 30
}

variable "block_public_acls" {
description = "Whether to block public ACLs"
type = bool
default = false
}

variable "block_public_policy" {
description = "Whether to block public policy"
type = bool
default = false
}

variable "ignore_public_acls" {
description = "Whether to ignore public ACLs"
type = bool
default = false
}

variable "restrict_public_buckets" {
description = "Whether to restrict public buckets"
type = bool
default = false
}

variable "prefix" {
description = "The prefix for the avatars storage path"
type = string
default = "avatars/"
}

variable "avatar_filename" {
description = "The default avatar filename"
type = string
default = "user_default.png"
}

variable "avatar_path" {
  description = "Path to the local default avatar image file"
  type        = string
  default     = "../backend/avatar/user_default.png"
} 