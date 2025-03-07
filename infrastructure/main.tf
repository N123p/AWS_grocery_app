provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MainVPC"
  }
}

# Create Subnet in us-east-1a
resource "aws_subnet" "main_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-A"
  }
}

# Create Subnet in us-east-1b
resource "aws_subnet" "main_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet-B"
  }
}

# Security Group within VPC
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]  # Restrict SSH to your IP only
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]  # Restrict DB access to your IP
  }

  # Outbound Rules (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in the same VPC with Key Pair
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main_subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = var.key_name  # SSH key added for EC2 access
  associate_public_ip_address = true

  tags = {
    Name = "MyWebServer"
  }
}

# RDS Instance with Name for Database
resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                = "postgres"
  instance_class        = "db.t3.micro"
  db_name               = var.db_name  # Using variable for DB name
  username              = var.db_username
  password              = var.db_password
  publicly_accessible   = false
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main_subnet_group.name

  tags = {
    Name = var.db_name  # Name assigned to RDS instance
  }
}

# Create DB subnet group to associate the RDS instance with the same VPC
resource "aws_db_subnet_group" "main_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = [
    aws_subnet.main_subnet_1.id,
    aws_subnet.main_subnet_2.id
  ]

  tags = {
    Name = "MainDBSubnetGroup"
  }
}
