variable "name" {
  description = "Base name used for resources (Launch Template, ASG, etc.)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = null  # Agregado: default null para hacerlo opcional
}

variable "user_data" {
  description = "User data script to be base64 encoded"
  type        = string
  default     = ""
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile to attach"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling Group"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "volume_size" {
  description = "Size of the root volume in GB for ASG instances"
  type        = number
  default     = null  # Null para usar default de AWS/AMI si no se pasa
}