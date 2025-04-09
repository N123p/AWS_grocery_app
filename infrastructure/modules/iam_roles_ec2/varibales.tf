variable "iam_role_name" {
  description = "IAM role name for EC2"
  type        = string
}

variable "iam_policy_name" {
  description = "IAM policy name"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name the EC2 instance should access"
  type        = string
}

variable "folder_path" {
  description = "Folder path (prefix) inside the S3 bucket EC2 can access"
  type        = string
  default     = ""  # Optional: set a default if not always needed
}