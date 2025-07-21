output "ec2_logs_policy_arn" {
  description = "ARN de la política EC2 logs"
  value       = try(aws_iam_policy.ec2_logs_policy[0].arn, null)
}

output "ec2_logs_instance_profile_name" {
  description = "Nombre del instance profile para EC2 con logs"
  value       = aws_iam_instance_profile.ec2_logs.name
}

output "asg_images_instance_profile_name" {
  description = "Nombre del instance profile para ASG con logs e imágenes"
  value       = aws_iam_instance_profile.asg_images.name
}

output "asg_role_name" {
  description = "Nombre del rol IAM para el ASG"
  value       = aws_iam_role.asg_images_role[0].name
}
