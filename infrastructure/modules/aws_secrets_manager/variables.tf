variable "secret_name" {
  description = "The name of the secret"
  type        = string
}

variable "secret_description" {
  description = "The description of the secret"
  type        = string
  default     = "This is a secret stored in Secrets Manager"
}

variable "secret_tags" {
  description = "Tags for the secret"
  type        = map(string)
  default     = {}
}

variable "secret_string" {
  description = "The actual secret value (in JSON format)"
  type        = string
}
