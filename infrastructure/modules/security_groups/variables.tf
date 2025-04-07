variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ips" {
  description = "List of allowed IPs"
  type        = list(string)
}

variable "name" {
  description = "The name of the security group"
  type        = string
  default     = "rds-postgres-sg"
}


