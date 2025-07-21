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
| terraform | >= 1.5.0 |
| aws | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| internal | Indicates whether the ALB is internal or internet-facing | `bool` | `false` | no |
| name | Base name for the ALB | `string` | n/a | yes |
| region | AWS region where the infrastructure will be deployed | `string` | `"us-east-1"` | no |
| security_groups | List of security groups to attach to the ALB | `list(string)` | n/a | yes |
| subnet_ids | List of public subnets for the ALB | `list(string)` | n/a | yes |
| vpc_id | VPC where the ALB will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb_arn | n/a |
| alb_dns_name | DNS del ALB |
| alb_target_group_arn | n/a |
<!-- END_TF_DOCS -->