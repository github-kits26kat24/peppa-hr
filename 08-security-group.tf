resource "aws_security_group" "hr-app-sg" {
  name        = "hr-app-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id # aws_vpc.hr-app-vpc.id

  dynamic "ingress" {
    for_each = ["22", "433", "80", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # Change this to specific protocol or protocols if needed
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "hr-app-sg" # Replace "sg_name" with the actual name of the security group
  }
}

