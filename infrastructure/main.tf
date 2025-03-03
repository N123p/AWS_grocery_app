provider "aws" {
  region  = var.aws_region
  profile = var.profile
}


resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.aws_availability_zone
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "MyWebServer"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  db_name             = "mygrocerydb"
  username           = var.db_username
  password           = var.db_password
  publicly_accessible = true
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.sg.id]
}
