variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning_status" {
  description = "The versioning status of the S3 bucket"
  type        = string
}

variable "lifecycle_status" {
  description = "Lifecycle policy status"
  type        = string
}

variable "expiration_days" {
  description = "The number of days to wait before deleting objects"
  type        = number
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
}

variable "block_public_policy" {
  description = "Whether to block public policy"
  type        = bool
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public buckets"
  type        = bool
}


variable "avatar_prefix" {
  description = "The prefix for the avatars storage path"
  type        = string
}



variable "avatar_filename" {
  description = "The default avatar filename"
  type        = string
}

variable "db_dump_prefix" {
  description = "Prefix for the database dump file in S3"
  type        = string
}

variable "db_dump_filename" {
  description = "The name of the SQLite database dump file"
  type        = string
}



variable "avatar_s3_key" {
  description = "The S3 key (path inside the bucket) for the default avatar image"
  type        = string
}

variable "db_dump_s3_key" {
  description = "The S3 key (path inside the bucket) for the database dump"
  type        = string
}

