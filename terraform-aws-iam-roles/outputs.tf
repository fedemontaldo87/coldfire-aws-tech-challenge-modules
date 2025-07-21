output "role_arn" {
  description = "ARN del rol creado"
  value       = aws_iam_role.ec2_logs_role[0].arn  # O el asg, ya que son similares
}

output "role_name" {
  description = "Nombre del rol creado"
  value       = aws_iam_role.ec2_logs_role[0].name
}

output "custom_policy_arns" {
  description = "Lista de ARNs de políticas custom creadas por el módulo (si existen)"
  value = concat(
    can(aws_iam_policy.named_custom_policy) ? [for p in aws_iam_policy.named_custom_policy : p.arn] : [],
    can(aws_iam_policy.file_custom_policy)  ? [for p in aws_iam_policy.file_custom_policy : p.arn] : []
  )
}

output "ec2_logs_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_logs.name
}

output "asg_images_instance_profile_name" {
  value = aws_iam_instance_profile.asg_images.name
}

# Agregado: Outputs para el attachment
output "asg_role_name" {
  description = "Nombre del rol para ASG"
  value       = aws_iam_role.asg_images_role[0].name
}

output "ec2_logs_policy_arn" {
  description = "ARN de la policy para EC2 logs"
  value       = try(aws_iam_policy.ec2_logs_policy[0].arn, null)
}