variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones to use (e.g., [\"us-east-1a\", \"us-east-1b\"])"
  type        = list(string)
}

variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}
