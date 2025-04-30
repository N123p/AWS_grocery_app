terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {

  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  region               = var.region
  vpc_cidr             = "10.0.0.0/16"
  vpc_name             = "grocery-vpc"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
}



module "security_groups" {
  source            = "./modules/security_groups"
  vpc_id            = module.vpc.vpc_id  # Correctly using vpc_id from the VPC module
  allowed_ips       = var.allowed_ips
  name              = "rds-postgres-security-group"
  alb_ingress_ports = [80, 5000]

}

module "iam_roles_ec2" {
  source          = "./modules/iam_roles_ec2"
  iam_role_name   = "ec2-s3-access-role"
  iam_policy_name = "ec2-s3-policy"
  s3_bucket_name  = var.bucket_name  # Or your actual S3 bucket name
  folder_path     = var.avatar_prefix
}

module "ec2_launch_template" {
  source             = "./modules/ec2_launch_template"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_id  = module.security_groups.ec2_security_group_id
  subnet_id          = module.vpc.public_subnet_ids[0]
  ec2_name           = "mygroceryec2"
}



module "rds" {
  source                 = "./modules/rds"
  db_identifier          = "grocery-db"
  instance_class         = "db.t3.micro"
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "17.4"
  storage_encrypted      = true
  deletion_protection    = false
  publicly_accessible    = false
  multi_az               = true
  vpc_security_group_ids = [module.security_groups.rds_security_group_id]
   db_subnet_group_name   = module.vpc.db_subnet_group_name
  skip_final_snapshot    = true



  # Database credentials (From terraform.tfvars)
  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
}

module "s3_bucket" {
  source                  = "./modules/s3_bucket"
  bucket_name             = var.bucket_name
  versioning_status       = "Disabled"
  lifecycle_status        = "Disabled"
  expiration_days         = 30
  block_public_acls       = true
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = true
  restrict_public_buckets = true
  avatar_prefix           = "avatars/"
  avatar_filename         = "user_default.png"
  avatar_s3_key           = "avatars/user_default.png"    # new variable
  db_dump_prefix          = "db_backups/"
  db_dump_filename        = "sqlite_dump_clean.sql"
  db_dump_s3_key          = "db_backups/sqlite_dump_clean.sql"   # new variable
}


module "alb" {
  source                = "./modules/alb"
  alb_name              = "grocery-alb"
  alb_security_group_id = module.security_groups.alb_security_group_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  target_group_name     = "grocery-alb-tg"
  target_group_port     = 5000
  vpc_id                = module.vpc.vpc_id
  health_check_path     = "/health"
}

module "aws_secrets_manager" {
  source            = "./modules/aws_secrets_manager"
  secret_name       = "my_grocery_secret"
  secret_description = "This is a test secret"
  secret_string     = jsonencode({
    "API_KEY" = "my-super-secret-api-key"
  })
  secret_tags = {
    "Environment" = "Development"
  }
}
