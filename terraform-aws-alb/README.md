# AWS Application Load Balancer (ALB) Terraform Module

Terraform module that creates an **Application Load Balancer (ALB)** on AWS.

This module supports:

- Creating an ALB (Application Load Balancer)
- Defining listeners (HTTP/HTTPS)
- Creating target groups
- Registering EC2 instances (or autoscaling groups)
- Associating security groups and subnets



* [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)
* [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)
* [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)
* [aws_lb_target_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)

## Usage

```hcl
module "alb" {
  source  = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-alb?ref=v1.0.0"

  prefix           = "webapp"
  vpc_id           = "vpc-12345678"
  subnet_ids       = ["subnet-aaa", "subnet-bbb"]
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-tg/abc123"
  security_groups  = ["sg-abcdef12"]

  tags = {
    Environment = "prod"
    Terraform   = "true"
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_internal"></a> [internal](#input\_internal) | Define si el ALB es interno o externo | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Nombre base del ALB | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | La región de AWS donde se desplegará la infraestructura | `string` | `"us-east-1"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Lista de SGs para el ALB | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Lista de subnets públicas para el ALB | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC donde se desplegará el ALB | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | n/a |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS del ALB |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | n/a |
<!-- END_TF_DOCS -->