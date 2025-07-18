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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.file_custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.named_custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.file_custom_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.named_custom_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_index"></a> [assume\_role\_index](#input\_assume\_role\_index) | Tipo de entidad que asumirá el rol (ej: EC2, LAMBDA, etc). | `string` | `"EC2"` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | Unidad de negocio para etiquetar los recursos. | `string` | n/a | yes |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Controla si se debe crear el rol IAM. | `bool` | `true` | no |
| <a name="input_custom_policies"></a> [custom\_policies](#input\_custom\_policies) | Lista de rutas a archivos JSON con políticas personalizadas. Los archivos deben estar en el directorio 'policies/' del módulo. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambiente (ej: dev, prod) para etiquetar los recursos. | `string` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | ID externo opcional para trust policies cross-account. | `string` | `""` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Duración máxima de la sesión del rol en segundos (entre 3600 y 43200). | `number` | `3600` | no |
| <a name="input_named_custom_policies"></a> [named\_custom\_policies](#input\_named\_custom\_policies) | Lista de objetos con nombre y contenido de políticas custom. Cada objeto debe tener 'name' (string) y 'policy' (string, contenido JSON). | <pre>list(object({<br/>    name   = string<br/>    policy = string<br/>  }))</pre> | `[]` | no |
| <a name="input_policies_arn"></a> [policies\_arn](#input\_policies\_arn) | Lista de ARNs de políticas gestionadas por AWS para adjuntar al rol. | `list(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Nombre del rol IAM. | `string` | n/a | yes |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Ruta del rol IAM. | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de tags adicionales a aplicar a los recursos. | `map(string)` | `{}` | no |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | Lista de ARNs de roles o usuarios que pueden asumir este rol (para confianza entre cuentas). | `list(string)` | `[]` | no |
| <a name="input_trusted_services"></a> [trusted\_services](#input\_trusted\_services) | Servicios AWS que pueden asumir el rol (ej: ec2.amazonaws.com). | `list(string)` | <pre>[<br/>  "ec2.amazonaws.com"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_policy_arns"></a> [custom\_policy\_arns](#output\_custom\_policy\_arns) | ARNs de las políticas personalizadas creadas |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN del rol IAM creado |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Nombre del rol IAM creado |
<!-- END_TF_DOCS -->
