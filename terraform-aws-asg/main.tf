resource "aws_launch_template" "this" {
  name_prefix   = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name  # Ahora opcional
  user_data     = base64encode(var.user_data)

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }

  # Agregado: Block device para root volume si volume_size se pasa
  dynamic "block_device_mappings" {
    for_each = var.volume_size != null ? [1] : []
    content {
      device_name = "/dev/sda1"  # Root device para la mayoría de AMIs

      ebs {
        volume_size = var.volume_size
        volume_type = "gp3"  # Default type, puedes agregar var si quieres
        delete_on_termination = true
      }
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns         = var.target_group_arns
  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.name}-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.name}-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
}