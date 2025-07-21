# AWS IAM Role Terraform MModule

Terraform module which creates IAM Role resources on AWS with flexible policy attachments.

These types of resources are supported:

* [`aws_iam_role`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
* [`aws_iam_policy`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
* [`aws_iam_role_policy_attachment`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)
* [`aws_iam_group`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)
* [`aws_iam_group_policy_attachment`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)

## Usage

```hcl
module "asg_iam_role" {
  source = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-iam-roles?ref=v1.0.0"

  role_name      = "asg-image-reader"
  environment    = "prod"
  business_unit  = "marketing"

  # Trusted entities (EC2 by default)
  trusted_services = ["ec2.amazonaws.com"]
  
  # Policies from JSON files
  custom_policies = ["s3_read_images.json"]
  
  # Inline custom policies
  named_custom_policies = [
    {
      name   = "s3-access"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Action   = ["s3:ListBucket"]
          Effect   = "Allow"
          Resource = "arn:aws:s3:::images"
        }]
      })
    }
  ]

  # AWS-managed policies
  policies_arn = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

  tags = {
    Project = "ImageProcessing"
  }
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
| [aws_iam_policy.file_custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.named_custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.file_custom_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.named_custom_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| account_id | AWS account ID | `string` | n/a | yes |
| assume_role_index | Type of entity that will assume the role (e.g., EC2, LAMBDA, etc.). | `string` | `"EC2"` | no |
| business_unit | Business unit for tagging resources. | `string` | n/a | yes |
| create_role | Controls whether the IAM role should be created. | `bool` | `true` | no |
| custom_policies | List of file paths for custom policies in JSON format. The files must be in the 'policies/' directory of the module. | `list(string)` | `[]` | no |
| environment | Environment (e.g., dev, prod) for tagging resources. | `string` | n/a | yes |
| external_id | Optional external ID for cross-account trust policies. | `string` | `""` | no |
| inline_policy_json | Inline policy in JSON string format | `string` | `""` | no |
| max_session_duration | Maximum session duration for the role in seconds (between 3600 and 43200). | `number` | `3600` | no |
| named_custom_policies | List of objects with name and content of custom policies. Each object must have 'name' (string) and 'policy' (string, JSON content). | ```list(object({ name = string policy = string }))``` | `[]` | no |
| policies_arn | List of AWS-managed policy ARNs to attach to the role. | `list(string)` | `[]` | no |
| region | AWS region | `string` | n/a | yes |
| role_name | IAM role name. | `string` | n/a | yes |
| role_path | IAM role path. | `string` | `"/"` | no |
| tags | Map of additional tags to apply to resources. | `map(string)` | `{}` | no |
| trusted_role_arns | List of ARNs for roles or users that can assume this role (for cross-account trust). | `list(string)` | `[]` | no |
| trusted_services | AWS services that can assume the role (e.g., ec2.amazonaws.com). | `list(string)` | ```[ "ec2.amazonaws.com" ]``` | no |


## Outputs

| Name | Description |
|------|-------------|
| custom_policy_arns | Lista de ARNs de políticas custom creadas por el módulo (si existen) |
| role_arn | ARN del rol creado |
| role_name | Nombre del rol creado |
<!-- END_TF_DOCS -->
