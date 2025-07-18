output "alb_dns_name" {
  description = "DNS del ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.this.arn
}
