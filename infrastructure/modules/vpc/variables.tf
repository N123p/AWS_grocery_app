# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Availability zone to be used for public and private subnets
variable "availability_zone" {
  description = "The availability zone to use for the subnets"
  type        = string
  default     = "us-east-1a"
}

# Public subnet CIDR blocks
variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Private subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# Region for deploying resources
variable "region" {
  description = "AWS region for the VPC"
  type        = string
  default     = "us-east-1"
}


variable "availability_zones" {
  type = list(string)
}

variable "vpc_name" {
   type        = string

}


variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = "my-db-subnet-group"
}

variable "db_subnet_cidrs" {
  description = "The CIDRs of the private subnets to be used in the DB subnet group"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]  # Modify as per your setup
}



