# AWS Security Group Terraform Module

Terraform module which creates Security Group resources on AWS.

These types of resources are supported:

* [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)

## Usage

```hcl
module "security_group" {
  source      = "git@github.com:IHSA-TDG/infrastructure-terraform-modules.git///terraform-aws-security-group?ref=main"

  name        = "web-sg"
  description = "Security group for web servers"
  vpc_id      = "vpc-12345678"

  ingress_rules = [
    {
      description      = "HTTP access"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Environment = "prod"
  }
}

Terraform Documentation
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
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Description of the security group | `string` | n/a | yes |
| egress_rules | List of egress rules | ```list(object({ description = string from_port = number to_port = number protocol = string cidr_blocks = list(string) ipv6_cidr_blocks = list(string) }))``` | ```[ { "cidr_blocks": [ "0.0.0.0/0" ], "description": "Allow all egress", "from_port": 0, "ipv6_cidr_blocks": [ "::/0" ], "protocol": "-1", "to_port": 0 } ]``` | no |
| ingress_rules | List of ingress rules | ```list(object({ description = string from_port = number to_port = number protocol = string cidr_blocks = list(string) ipv6_cidr_blocks = list(string) }))``` | `[]` | no |
| name | Name of the security group | `string` | n/a | yes |
| region | n/a | `string` | `"us-east-1"` | no |
| tags | Tags to apply to the SG | `map(string)` | `{}` | no |
| vpc_id | VPC ID where to create the security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | n/a |
<!-- END_TF_DOCS -->

