provider "aws" {
  profile = "my_web_app_1"
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
  allocated_storage      = 20
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
  bucket_name             = var.bucket_name # Set your S3 bucket name in terraform.tfvars
  versioning_status       = "Disabled"
  lifecycle_status        = "Disabled"
  expiration_days         = 30
  block_public_acls       = true
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = true
  restrict_public_buckets = true
  avatar_prefix           = "avatars/"
  avatar_filename         = "user_default.png"
  avatar_path             = "../backend/avatar/user_default.png"
  db_dump_prefix          = "db_backups/"
  db_dump_filename        = "sqlite_dump_clean.sql"
  db_dump_path            = "../backend/app/sqlite_dump_clean.sql"
}
