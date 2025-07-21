output "ec2_logs_policy_arn" {
  description = "ARN of the EC2 logs policy"
  value       = try(aws_iam_policy.ec2_logs_policy[0].arn, null)
}

output "ec2_logs_instance_profile_name" {
  description = "Instance profile name for EC2 with logs"
  value       = aws_iam_instance_profile.ec2_logs.name
}

output "asg_images_instance_profile_name" {
  description = "Instance profile name for ASG with logs and images"
  value       = aws_iam_instance_profile.asg_images.name
}

output "asg_role_name" {
  description = "IAM role name for the ASG"
  value       = aws_iam_role.asg_images_role[0].name
}
