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

variable "alb_ingress_ports" {
  description = "Ports for the ALB security group ingress"
  type        = list(number)
}
