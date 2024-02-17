resource "aws_db_instance" "prod" {
  identifier           = "prod-mysql-rds"
  allocated_storage    = 10
  storage_type         = "gp2"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  username             = "administrator"                           # "foo"
  password             = data.aws_ssm_parameter.rds_password.value # "foobarbaz" 
}

# Generate Password
resource "random_password" "main" {
  length           = 20
  special          = true # Default: '@#/?<>
  override_special = "#'()"
}

# Store Password
resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/prod-mysql-rds/password"
  description = "Master Password for RDS Database"
  type        = "SecureString"
  value       = random_password.main.result
}

# Retrive Password
data "aws_ssm_parameter" "rds_password" {
  name       = "/prod/prod-mysql-rds/password"
  depends_on = [aws_ssm_parameter.rds_password]
}