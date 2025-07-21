output "alb_dns_name" {
  description = "DNS of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = aws_lb_target_group.this.arn
}
