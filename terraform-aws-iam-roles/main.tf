locals {
  templates = {
    EC2 = "iam_t_assume_role_with_ec2.tpl"
  }

  # Load policies from files
  custom_policies_data = {
    for path in var.custom_policies :
    basename(path) => file("${path.module}/policies/${path}")
  }

  mandatory_tags = {
    Name          = var.role_name,
    Terraform     = "true",
    Environment   = var.environment,
    Business_unit = var.business_unit
  }

  tags = merge(local.mandatory_tags, var.tags)
}

# IAM Role for EC2 logs (only logs write)
resource "aws_iam_role" "ec2_logs_role" {
  count                = var.create_role ? 1 : 0
  name                 = "${var.role_name}-ec2-logs"
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  assume_role_policy = templatefile(
    "${path.module}/roles/${lookup(local.templates, var.assume_role_index, "EC2")}",
    {
      trusted_services = jsonencode(var.trusted_services),
      trusted_roles    = jsonencode(var.trusted_role_arns),
      external_id      = var.external_id
    }
  )

  tags = local.tags
}

# IAM Role for ASG images (logs write + images read)
resource "aws_iam_role" "asg_images_role" {
  count                = var.create_role ? 1 : 0
  name                 = "${var.role_name}-asg-images"
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  assume_role_policy = templatefile(
    "${path.module}/roles/${lookup(local.templates, var.assume_role_index, "EC2")}",
    {
      trusted_services = jsonencode(var.trusted_services),
      trusted_roles    = jsonencode(var.trusted_role_arns),
      external_id      = var.external_id
    }
  )

  tags = local.tags
}

# Policy for logs write (S3 PutObject)
resource "aws_iam_policy" "ec2_logs_policy" {
  count = var.logs_policy_json != "" ? 1 : 0

  name   = "${var.role_name}-ec2-logs-policy"
  policy = var.logs_policy_json
  tags   = local.tags
}

# Policy for images read (S3 GetObject)
resource "aws_iam_policy" "asg_images_policy" {
  count = var.images_policy_json != "" ? 1 : 0

  name   = "${var.role_name}-asg-images-policy"
  policy = var.images_policy_json
  tags   = local.tags
}

# Named inline IAM policies (genéricas)
resource "aws_iam_policy" "named_custom_policy" {
  for_each = { for policy in var.named_custom_policies : policy.name => policy }

  name   = each.key
  policy = each.value.policy
  tags   = local.tags
}

# Policies loaded from files (genéricas)
resource "aws_iam_policy" "file_custom_policy" {
  for_each = var.custom_policies != [] ? local.custom_policies_data : {}

  name   = trimsuffix(each.key, ".json")
  policy = each.value
  tags   = local.tags
}

# Attach logs policy to EC2 role
resource "aws_iam_role_policy_attachment" "ec2_logs_attachment" {
  count = var.create_role && var.logs_policy_json != "" ? 1 : 0

  role       = aws_iam_role.ec2_logs_role[0].name
  policy_arn = aws_iam_policy.ec2_logs_policy[0].arn
}

# Attach logs and images policies to ASG role
resource "aws_iam_role_policy_attachment" "asg_logs_attachment" {
  count = var.create_role && var.logs_policy_json != "" ? 1 : 0

  role       = aws_iam_role.asg_images_role[0].name
  policy_arn = aws_iam_policy.ec2_logs_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "asg_images_attachment" {
  count = var.create_role && var.images_policy_json != "" ? 1 : 0

  role       = aws_iam_role.asg_images_role[0].name
  policy_arn = aws_iam_policy.asg_images_policy[0].arn
}

# Attach named custom policies to both roles (si aplican)
resource "aws_iam_role_policy_attachment" "named_custom_ec2_attachment" {
  for_each = var.create_role ? aws_iam_policy.named_custom_policy : {}

  role       = aws_iam_role.ec2_logs_role[0].name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "named_custom_asg_attachment" {
  for_each = var.create_role ? aws_iam_policy.named_custom_policy : {}

  role       = aws_iam_role.asg_images_role[0].name
  policy_arn = each.value.arn
}

# Inline policy (attach a ambos si se pasa)
resource "aws_iam_role_policy" "inline_ec2" {
  count  = var.inline_policy_json != "" ? 1 : 0
  name   = "${var.role_name}-ec2-inline"
  role   = aws_iam_role.ec2_logs_role[0].name
  policy = var.inline_policy_json
}

resource "aws_iam_role_policy" "inline_asg" {
  count  = var.inline_policy_json != "" ? 1 : 0
  name   = "${var.role_name}-asg-inline"
  role   = aws_iam_role.asg_images_role[0].name
  policy = var.inline_policy_json
}

# Instance profiles
resource "aws_iam_instance_profile" "ec2_logs" {
  name = "${var.role_name}-ec2-logs-profile"
  role = aws_iam_role.ec2_logs_role[0].name
}

resource "aws_iam_instance_profile" "asg_images" {
  name = "${var.role_name}-asg-images-profile"
  role = aws_iam_role.asg_images_role[0].name
}
