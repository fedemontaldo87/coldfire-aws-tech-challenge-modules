output "role_arn" {
  description = "ARN del rol creado"
  value       = aws_iam_role.iam_role[0].arn
}

output "role_name" {
  description = "Nombre del rol creado"
  value       = aws_iam_role.iam_role[0].name
}

output "custom_policy_arns" {
  description = "Lista de ARNs de políticas custom creadas por el módulo (si existen)"
  value = concat(
    can(aws_iam_policy.named_custom_policy) ? [for p in aws_iam_policy.named_custom_policy : p.arn] : [],
    can(aws_iam_policy.file_custom_policy)  ? [for p in aws_iam_policy.file_custom_policy : p.arn] : []
  )
}
