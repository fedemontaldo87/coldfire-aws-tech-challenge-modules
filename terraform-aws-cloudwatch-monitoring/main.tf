resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/${var.prefix}/app"
  retention_in_days = 30
}

resource "aws_sns_topic" "alerts" {
  name = "${var.prefix}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "${var.prefix}-HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.alarm_cpu_threshold
  alarm_description   = "This alarm monitors high CPU usage"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  alarm_name          = "${var.prefix}-LowCPUUtilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_low_threshold
  alarm_description   = "This alarm monitors low CPU usage"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name]
          ],
          period = 300,
          stat   = "Average",
          region = var.region,
          title  = "EC2 CPU Utilization"
        }
      }
    ]
  })
}
