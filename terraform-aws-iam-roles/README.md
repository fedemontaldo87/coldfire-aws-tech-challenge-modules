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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_id | ID de cuenta AWS | `string` | n/a | yes |
| assume_role_index | Tipo de entidad que asumirá el rol (ej: EC2, LAMBDA, etc). | `string` | `"EC2"` | no |
| business_unit | Unidad de negocio para etiquetar los recursos. | `string` | n/a | yes |
| create_role | Controla si se debe crear el rol IAM. | `bool` | `true` | no |
| custom_policies | Lista de rutas a archivos JSON con políticas personalizadas. Los archivos deben estar en el directorio 'policies/' del módulo. | `list(string)` | `[]` | no |
| environment | Ambiente (ej: dev, prod) para etiquetar los recursos. | `string` | n/a | yes |
| external_id | ID externo opcional para trust policies cross-account. | `string` | `""` | no |
| inline_policy_json | Política inline en formato JSON string | `string` | `""` | no |
| max_session_duration | Duración máxima de la sesión del rol en segundos (entre 3600 y 43200). | `number` | `3600` | no |
| named_custom_policies | Lista de objetos con nombre y contenido de políticas custom. Cada objeto debe tener 'name' (string) y 'policy' (string, contenido JSON). | ```list(object({ name = string policy = string }))``` | `[]` | no |
| policies_arn | Lista de ARNs de políticas gestionadas por AWS para adjuntar al rol. | `list(string)` | `[]` | no |
| region | Región de AWS | `string` | n/a | yes |
| role_name | Nombre del rol IAM. | `string` | n/a | yes |
| role_path | Ruta del rol IAM. | `string` | `"/"` | no |
| tags | Mapa de tags adicionales a aplicar a los recursos. | `map(string)` | `{}` | no |
| trusted_role_arns | Lista de ARNs de roles o usuarios que pueden asumir este rol (para confianza entre cuentas). | `list(string)` | `[]` | no |
| trusted_services | Servicios AWS que pueden asumir el rol (ej: ec2.amazonaws.com). | `list(string)` | ```[ "ec2.amazonaws.com" ]``` | no |

## Outputs

| Name | Description |
|------|-------------|
| custom_policy_arns | Lista de ARNs de políticas custom creadas por el módulo (si existen) |
| role_arn | ARN del rol creado |
| role_name | Nombre del rol creado |
<!-- END_TF_DOCS -->
