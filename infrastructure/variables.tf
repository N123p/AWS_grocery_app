variable "region" {
  description = "AWS region"
  type        = string
}



variable "allowed_ips" {
  description = "List of allowed IPs for SSH access"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH Key Name"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "grocery-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "allowed_ssh_ip" {
  description = "The IP address that is allowed to SSH into the EC2 instances"
  type        = string
  default     = "0.0.0.0/0" # Set your actual IP in terraform.tfvar
}

variable "availability_zone" {
  description = "The availability zone in which to create subnets"
  type        = string
  default     = "us-east-1a"
}
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "my-grocery-db"
}

variable "db_name" {
  description = "The name of the database"
  type        = string

}

variable "db_username" {
  description = "The master username for the database"
  type        = string

}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance type for the RDS database"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in GB for the RDS instance"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs to be used in the DB subnet group."
  type        = list(string)
   default     = ["subnet-12345678", "subnet-87654321"]
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group for the RDS instance"
  type        = string
  default     = "grocery-db-subnet-group"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "grocery-s3-v1.0" # Be sure to set unique name!!!
}

variable "versioning_status" {
  description = "The versioning status of the S3 bucket"
  type        = string
  default     = "Disabled"
}

variable "lifecycle_status" {
  description = "Lifecycle policy status"
  type        = string
  default     = "Disabled"
}

variable "expiration_days" {
  description = "The number of days to wait before deleting objects"
  type        = number
  default     = 30
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether to block public policy"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public buckets"
  type        = bool
  default     = false
}

variable "avatar_prefix" {
  description = "The prefix for the avatars storage path"
  type        = string
  default     = "avatars/"
}

variable "avatar_filename" {
  description = "The default avatar filename"
  type        = string
  default     = "user_default.png"
}



variable "db_dump_prefix" {
  description = "Prefix for database dump file"
  type        = string
  default     = "db_backups/"
}

variable "db_dump_filename" {
  description = "Filename for database dump"
  type        = string
  default     = "sqlite_dump_clean.sql"
}




variable "db_subnet_cidrs" {
  description = "The CIDRs of the private subnets to be used in the DB subnet group"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]  # Modify as per your setup
}

variable "alb_ingress_ports" {
  description = "Ports for the ALB security group ingress."
  type        = list(number)
  default     = [80, 5000]
}

variable "avatar_s3_key" {
  description = "The S3 key (path inside the bucket) for the default avatar image"
  type        = string
  default     = "avatars/user_default.png"
}

variable "db_dump_s3_key" {
  description = "The S3 key (path inside the bucket) for the database dump"
  type        = string
  default     = "db_backups/sqlite_dump_clean.sql"
}

