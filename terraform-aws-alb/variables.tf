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
