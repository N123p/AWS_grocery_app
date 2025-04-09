resource "aws_secretsmanager_secret" "example_secret" {
  name        = var.secret_name
  description = var.secret_description

  tags = var.secret_tags
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.example_secret.id
  secret_string = var.secret_string
}
