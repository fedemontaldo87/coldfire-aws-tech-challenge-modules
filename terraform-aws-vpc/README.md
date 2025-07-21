# Terraform AWS VPC Module

Terraform module which provisions a complete Virtual Private Cloud (VPC) on AWS.

This module creates:

- A VPC with custom CIDR block
- Two public subnets and two private subnets (spread across 2 AZs)
- An Internet Gateway
- A NAT Gateway with Elastic IP
- Route Tables and proper subnet associations

These types of resources are supported:

* [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
* [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
* [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
* [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)
* [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
* [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)
* [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)

---

# Usage

```hcl
module "vpc" {
  source = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-vpc?ref=v1.0.0"

  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.0.0/24", "10.1.1.0/24"]
  private_subnet_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.100.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azs | List of Availability Zones to use (e.g., ["us-east-1a", "us-east-1b"]) | `list(string)` | n/a | yes |
| private_subnet_cidrs | List of CIDR blocks for private subnets | `list(string)` | n/a | yes |
| public_subnet_cidrs | List of CIDR blocks for public subnets | `list(string)` | n/a | yes |
| region | AWS region where the infrastructure will be deployed | `string` | n/a | yes |
| vpc_cidr | CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private_subnet_ids | List of private subnet IDs |
| public_subnet_ids | List of public subnet IDs |
| vpc_id | ID of the VPC |
<!-- END_TF_DOCS -->