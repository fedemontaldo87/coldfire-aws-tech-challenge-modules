# AWS Auto Scaling Group (ASG) Terraform Module

Terraform module that creates an **Auto Scaling Group (ASG)** with a Launch Template on AWS.

This module supports:

- Creating a Launch Template for EC2 instances
- Defining Auto Scaling Group capacity and behavior
- Associating security groups and subnets
- Adding lifecycle hooks and instance protection (optional)

## Supported Resources

* [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)
* [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)

## Usage

```hcl
module "asg" {
  source  = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-asg?ref=v1.0.0"

  prefix                 = "webapp"
  vpc_zone_identifier    = ["subnet-aaa", "subnet-bbb"]
  security_group_ids     = ["sg-abcdef12"]
  instance_type          = "t3.micro"
  ami_id                 = "ami-0c55b159cbfafe1f0"
  desired_capacity       = 2
  min_size               = 1
  max_size               = 3
  key_name               = "mi-clave-ec2"
  user_data              = file("user_data.sh")

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
| aws | 5.100.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami_id | AMI ID to use for EC2 instances | `string` | n/a | yes |
| desired_capacity | Desired number of instances in the Auto Scaling Group | `number` | n/a | yes |
| instance_profile_name | Name of the IAM instance profile to attach | `string` | n/a | yes |
| instance_type | EC2 instance type | `string` | `"t3.micro"` | no |
| key_name | Key pair name for SSH access | `string` | n/a | yes |
| max_size | Maximum number of instances in the Auto Scaling Group | `number` | n/a | yes |
| min_size | Minimum number of instances in the Auto Scaling Group | `number` | n/a | yes |
| name | Base name used for resources (Launch Template, ASG, etc.) | `string` | n/a | yes |
| region | AWS region | `string` | n/a | yes |
| security_groups | List of security group IDs to associate with the instance | `list(string)` | n/a | yes |
| subnet_ids | List of subnet IDs for the Auto Scaling Group | `list(string)` | n/a | yes |
| target_group_arns | List of target group ARNs for the Auto Scaling Group | `list(string)` | n/a | yes |
| user_data | User data script to be base64 encoded | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| autoscaling_group_arn | ARN of the Auto Scaling Group |
| autoscaling_group_name | Name of the Auto Scaling Group |
| launch_template_id | ID of the created Launch Template |
<!-- END_TF_DOCS -->