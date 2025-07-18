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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the security group | `string` | n/a | yes |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules | <pre>list(object({<br/>    description      = string<br/>    from_port        = number<br/>    to_port          = number<br/>    protocol         = string<br/>    cidr_blocks      = list(string)<br/>    ipv6_cidr_blocks = list(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "Allow all egress",<br/>    "from_port": 0,<br/>    "ipv6_cidr_blocks": [<br/>      "::/0"<br/>    ],<br/>    "protocol": "-1",<br/>    "to_port": 0<br/>  }<br/>]</pre> | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules | <pre>list(object({<br/>    description      = string<br/>    from_port        = number<br/>    to_port          = number<br/>    protocol         = string<br/>    cidr_blocks      = list(string)<br/>    ipv6_cidr_blocks = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the SG | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where to create the security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END_TF_DOCS -->

