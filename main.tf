#-----------------------------------------------------------------
# Application Load Balancer (ALB)
#-----------------------------------------------------------------

resource "aws_lb" "main" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_lb_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = var.lb_name
  })
}

#-----------------------------------------------------------------
# Target Groups (Blue & Green)
#-----------------------------------------------------------------

resource "aws_lb_target_group" "blue" {
  name        = var.blue_tg_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/index.html"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.common_tags, {
    Name = var.blue_tg_name
  })
}

resource "aws_lb_target_group" "green" {
  name        = var.green_tg_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/index.html"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(var.common_tags, {
    Name = var.green_tg_name
  })
}

#-----------------------------------------------------------------
# ALB Listener with Weighted Routing
#-----------------------------------------------------------------

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }

      stickiness {
        enabled  = false
        duration = 1 # Required if enabled, but we are disabling it
      }
    }
  }

  tags = merge(var.common_tags, {
    Name = "${var.lb_name}-listener"
  })
}

#-----------------------------------------------------------------
# Launch Templates (Blue & Green)
#-----------------------------------------------------------------

resource "aws_launch_template" "blue" {
  name = var.blue_lt_name

  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.sg_ssh_id, var.sg_http_id]

  user_data = base64encode(local.blue_user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.blue_asg_name}-instance"
    })
  }

  tags = merge(var.common_tags, {
    Name = var.blue_lt_name
  })
}

resource "aws_launch_template" "green" {
  name = var.green_lt_name

  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.sg_ssh_id, var.sg_http_id]

  user_data = base64encode(local.green_user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.green_asg_name}-instance"
    })
  }

  tags = merge(var.common_tags, {
    Name = var.green_lt_name
  })
}

#-----------------------------------------------------------------
# Auto Scaling Groups (Blue & Green)
#-----------------------------------------------------------------

resource "aws_autoscaling_group" "blue" {
  name = var.blue_asg_name

  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.public_subnet_ids

  target_group_arns = [aws_lb_target_group.blue.arn]

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }

  # Correct ASG Tagging Syntax
  tag {
    key                 = "Name"
    value               = var.blue_asg_name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_group" "green" {
  name = var.green_asg_name

  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.public_subnet_ids

  target_group_arns = [aws_lb_target_group.green.arn]

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }

  # Correct ASG Tagging Syntax
  tag {
    key                 = "Name"
    value               = var.green_asg_name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
