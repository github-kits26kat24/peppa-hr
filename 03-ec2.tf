resource "aws_instance" "node-1" {
  ami                         = data.aws_ami.latest_amazon_linux.id #### Using Latest AMI ####  # "ami-02cad064a29d4550c"
  instance_type               = "t3.micro"
  key_name                    = "Kitskat2023"
  subnet_id                   = aws_subnet.node-1.id
  vpc_security_group_ids      = [aws_security_group.hr-app-sg.id]
  associate_public_ip_address = true

  depends_on = [
    aws_db_instance.prod,
    aws_instance.monitoring,
    aws_instance.node-2
  ]

  user_data = file("script.sh")

  tags = {
    Name = "Node-1"
  }
}


resource "aws_instance" "node-2" {
  ami                         = data.aws_ami.latest_amazon_linux.id # "ami-02cad064a29d4550c"
  instance_type               = "t3.micro"
  key_name                    = "Kitskat2023"
  subnet_id                   = aws_subnet.node-2.id
  vpc_security_group_ids      = [aws_security_group.hr-app-sg.id]
  associate_public_ip_address = true

  depends_on = [
    aws_db_instance.prod,
    aws_instance.monitoring
  ]

  user_data = file("script.sh")

  tags = {
    Name = "Node-2"
  }
}

resource "aws_instance" "monitoring" {
  ami                         = data.aws_ami.latest_amazon_linux.id # "ami-02cad064a29d4550c"
  instance_type               = "t3.micro"
  key_name                    = "Kitskat2023"
  subnet_id                   = aws_subnet.monitoring.id
  vpc_security_group_ids      = [aws_security_group.hr-app-sg.id]
  associate_public_ip_address = true

  depends_on = [
    aws_db_instance.prod
  ]

  tags = {
    Name = "Monitoring"
  }
}