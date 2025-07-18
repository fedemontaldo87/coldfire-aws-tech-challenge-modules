# AWS CloudWatch Monitoring Terraform Module

Terraform module that configures **CloudWatch monitoring and alerting** for EC2 Auto Scaling Groups (ASG), including alarms, dashboards and SNS notifications.

This module supports:

- Creating CloudWatch alarms for high and low CPU usage
- Sending alerts via Amazon SNS
- Creating a CloudWatch dashboard with CPU metrics
- Customizable thresholds and email notifications

## Supported Resources

* [aws_cloudwatch_metric_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)
* [aws_cloudwatch_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard)
* [aws_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)
* [aws_sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription)
* [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)

## Usage

```hcl
module "cloudwatch_monitoring" {
  source  = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-cloudwatch-monitoring?ref=v1.0.0"

  prefix              = "webapp"
  region              = "us-east-1"
  asg_name            = "webapp-asg"
  alert_email         = "alerts@example.com"
  alarm_cpu_threshold = 80
  cpu_low_threshold   = 10
}

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
| [aws_cloudwatch_dashboard.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_log_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.cpu_high_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_low_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_cpu_threshold"></a> [alarm\_cpu\_threshold](#input\_alarm\_cpu\_threshold) | CPU usage percentage that triggers a high alarm | `number` | `80` | no |
| <a name="input_alert_email"></a> [alert\_email](#input\_alert\_email) | Email address to receive CloudWatch alerts | `string` | n/a | yes |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of the Auto Scaling Group to monitor | `string` | n/a | yes |
| <a name="input_cpu_low_threshold"></a> [cpu\_low\_threshold](#input\_cpu\_low\_threshold) | CPU usage percentage that triggers a low alarm | `number` | `10` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for resource names (e.g., project or environment name) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_alarm_names"></a> [cloudwatch\_alarm\_names](#output\_cloudwatch\_alarm\_names) | Names of the CloudWatch alarms |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | ARN of the SNS topic used for CloudWatch notifications |
<!-- END_TF_DOCS -->