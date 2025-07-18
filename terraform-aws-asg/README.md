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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

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
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID to use for EC2 instances | `string` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of instances in the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | Name of the IAM instance profile to attach | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key pair name for SSH access | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of instances in the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of instances in the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name used for resources (Launch Template, ASG, etc.) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs to associate with the instance | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the Auto Scaling Group | `list(string)` | n/a | yes |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | List of target group ARNs for the Auto Scaling Group | `list(string)` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to be base64 encoded | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | ARN of the Auto Scaling Group |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | Name of the Auto Scaling Group |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | ID of the created Launch Template |
<!-- END_TF_DOCS -->