output "cloudwatch_alarm_names" {
  description = "Names of the CloudWatch alarms"
  value = [
    aws_cloudwatch_metric_alarm.cpu_high_alarm.alarm_name,
    aws_cloudwatch_metric_alarm.cpu_low_alarm.alarm_name
  ]
}


output "sns_topic_arn" {
  description = "ARN of the SNS topic used for CloudWatch notifications"
  value       = aws_sns_topic.alerts.arn
}
