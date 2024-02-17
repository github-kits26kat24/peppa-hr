# resource "aws_default_vpc" "default" {}

resource "aws_subnet" "node-1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_subnet" "node-2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}

# output "aws_availability_zones" {
#   value = data.aws_availability_zones.working.names
# }
####################   ####################

resource "aws_launch_template" "prod" {
  name                   = "Highly-Available-LT"
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.hr-app-sg.id]
  user_data              = file("script.sh")
}

####################   ####################

resource "aws_autoscaling_group" "prod" {
  name                = "Highly-Available-ASG-Ver-${aws_launch_template.prod.latest_version}"
  min_size            = 2
  max_size            = 2
  min_elb_capacity    = 2
  health_check_type   = "ELB"
  vpc_zone_identifier = [aws_subnet.node-1.id, aws_subnet.node-2.id]
  target_group_arns   = [aws_lb_target_group.prod.arn]

  launch_template {
    id      = aws_launch_template.prod.id
    version = aws_launch_template.prod.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG-v${aws_launch_template.prod.latest_version}"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

####################   ####################

resource "aws_lb" "web" {
  name               = "Prod-HighlyAvailable-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hr-app-sg.id]
  subnets            = [aws_subnet.node-1.id, aws_subnet.node-2.id]
}

output "prod_loadbalancer_url" {
  value = aws_lb.web.dns_name
}

resource "aws_lb_target_group" "prod" {
  name                 = "Prod-HighlyAvailable-TG"
  vpc_id               = aws_vpc.prod.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 # seconds
}

resource "aws_lb_listener" "prod" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod.arn
  }
}