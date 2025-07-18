variable "prefix" {
  description = "Prefix to use for resource names (e.g., project or environment name)"
  type        = string
}

variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to monitor"
  type        = string
}

variable "alert_email" {
  description = "Email address to receive CloudWatch alerts"
  type        = string
}

variable "alarm_cpu_threshold" {
  description = "CPU usage percentage that triggers a high alarm"
  type        = number
  default     = 80
}

variable "cpu_low_threshold" {
  description = "CPU usage percentage that triggers a low alarm"
  type        = number
  default     = 10
}
