variable "role_name" {
  description = "IAM role name."
  type        = string
}

variable "role_path" {
  description = "IAM role path."
  type        = string
  default     = "/"
}

variable "assume_role_index" {
  description = "Type of entity that will assume the role (e.g., EC2, LAMBDA, etc.)."
  type        = string
  default     = "EC2"
}

variable "custom_policies" {
  description = "List of paths to JSON files with custom policies. The files should be in the 'policies/' directory of the module."
  type        = list(string)
  default     = []
}

variable "named_custom_policies" {
  description = "List of objects with name and content of custom policies. Each object must have 'name' (string) and 'policy' (string, JSON content)."
  type = list(object({
    name   = string
    policy = string
  }))
  default = []
}

variable "policies_arn" {
  description = "List of ARNs of AWS-managed policies to attach to the role."
  type        = list(string)
  default     = []
}

variable "create_role" {
  description = "Controls whether the IAM role should be created."
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum session duration for the role in seconds (between 3600 and 43200)."
  type        = number
  default     = 3600
  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "The maximum session duration must be between 3600 and 43200 seconds."
  }
}

variable "environment" {
  description = "Environment (e.g., dev, prod) for tagging resources."
  type        = string
}

variable "business_unit" {
  description = "Business unit for tagging resources."
  type        = string
}

variable "tags" {
  description = "Map of additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "external_id" {
  description = "Optional external ID for cross-account trust policies."
  type        = string
  default     = ""
}

variable "trusted_services" {
  description = "AWS services that can assume the role (e.g., ec2.amazonaws.com)."
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "trusted_role_arns" {
  description = "List of ARNs of roles or users that can assume this role (for cross-account trust)."
  type        = list(string)
  default     = []
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "account_id" {
  description = "AWS account ID."
  type        = string
}

variable "inline_policy_json" {
  description = "Inline policy in JSON string format."
  type        = string
  default     = ""
}

# Added: Specific policies for logs and images (JSON strings)
variable "logs_policy_json" {
  description = "JSON policy for S3 logs write access (PutObject)."
  type        = string
  default     = ""  # Set default as empty; pass in call if used
}

variable "images_policy_json" {
  description = "JSON policy for S3 images read access (GetObject)."
  type        = string
  default     = ""
}

variable "create_ec2_logs_policy" {
  description = "Indicates whether to create a custom EC2 logs policy."
  type        = bool
  default     = false
}

variable "prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "coldfire"
}
