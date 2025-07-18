# Terraform VPC Module – Coldfire Challenge

Reusable VPC module including:

- VPC creation
- Public and private subnets across 2 AZs
- Internet Gateway
- NAT Gateway
- Route Tables with associations

## Variables

- `vpc_cidr`: CIDR block for the VPC
- `public_subnet_cidrs`: List of CIDRs for public subnets
- `private_subnet_cidrs`: List of CIDRs for private subnets
- `azs`: List of availability zones to use

## Outputs

- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`
