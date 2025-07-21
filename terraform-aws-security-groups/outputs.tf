output "asg_sg_id" {
  description = "ID of the ASG security group"
  value       = aws_security_group.asg_sg.id
}

output "alb_sg_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}
