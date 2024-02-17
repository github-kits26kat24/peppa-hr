################# RDS ID OUTPUT ##########################

output "rds_id" {
  value = aws_db_instance.prod.id
}

output "rds_address" {
  value = aws_db_instance.prod.address
}

output "rds_port" {
  value = aws_db_instance.prod.port
}

output "rds_username" {
  value = aws_db_instance.prod.username
}

output "rds_password" {
  value     = data.aws_ssm_parameter.rds_password.value
  sensitive = true
}

################ VPC ID OUTPUT ##########################

output "vpc_id" {
  value = aws_vpc.prod.id # aws_vpc.hr-app-vpc.id
}

################# SUBNET ID OUTPUT ##########################

output "subnet_id" {
  value = [
    aws_subnet.node-1.id,
    aws_subnet.node-2.id,
    aws_subnet.monitoring.id
  ]
}

################# SECURITY GROUP ID OUTPUT ##########################

output "security-group" {
  value = aws_security_group.hr-app-sg.id
}

################# NODE IP OUTPUT ##########################

output "node-1-public_ip" {
  value = aws_instance.node-1.public_ip
}

output "node-2-public_ip" {
  value = aws_instance.node-2.public_ip
}

output "monitoring-private_ip" {
  value = aws_instance.monitoring.private_ip
}

################# NODE ID OUTPUT ##########################

output "instances_ids" {
  value = [
    aws_instance.node-1.id,
    aws_instance.node-2.id,
    aws_instance.monitoring.id
  ]
}

