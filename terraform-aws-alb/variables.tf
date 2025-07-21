variable "name" {
  description = "Base name for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC where the ALB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups to attach to the ALB"
  type        = list(string)
}

variable "internal" {
  description = "Indicates whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "listener_port" {
  description = "Port on which the ALB listener will listen (e.g., 80 for HTTP)"
  type        = number
  default     = 80
}

variable "target_port" {
  description = "Port on which traffic is forwarded to the targets (e.g., 443 for HTTPS)"
  type        = number
  default     = 80
}

variable "target_protocol" {
  description = "Protocol for forwarding to targets (HTTP or HTTPS)"
  type        = string
  default     = "HTTP"
  validation {
    condition     = contains(["HTTP", "HTTPS"], var.target_protocol)
    error_message = "Target protocol must be HTTP or HTTPS."
  }
}