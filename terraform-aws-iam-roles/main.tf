locals {
  templates = {
    EC2 = "iam_t_assume_role_with_ec2.tpl"
  }

  # Leer políticas desde archivos
  custom_policies_data = {
    for path in var.custom_policies :
    basename(path) => file("${path.module}/policies/${path}")
  }

  mandatory_tags = {
    "Name"          = var.role_name,
    "Terraform"     = "true",
    "Environment"   = var.environment,
    "Business_unit" = var.business_unit
  }

  tags = merge(local.mandatory_tags, var.tags)
}

resource "aws_iam_role" "iam_role" {
  count                = var.create_role ? 1 : 0
  name                 = var.role_name
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  assume_role_policy = templatefile(
    "${path.module}/roles/${lookup(local.templates, var.assume_role_index, "EC2")}", 
    {
      trusted_services = jsonencode(var.trusted_services)
      trusted_roles    = jsonencode(var.trusted_role_arns)
      external_id      = var.external_id
    }
  )

  tags = local.tags
}

# Crear políticas desde objetos named_custom_policies
resource "aws_iam_policy" "named_custom_policy" {
  for_each = { for policy in var.named_custom_policies : policy.name => policy }

  name   = each.key
  policy = each.value.policy
  tags   = local.tags
}

# Crear políticas desde archivos custom_policies
resource "aws_iam_policy" "file_custom_policy" {
  for_each = var.custom_policies != [] ? local.custom_policies_data : {}

  name   = trimsuffix(each.key, ".json")
  policy = each.value
  tags   = local.tags
}

# Adjuntar políticas named_custom_policies al rol
resource "aws_iam_role_policy_attachment" "named_custom_attachment" {
  for_each = var.create_role ? aws_iam_policy.named_custom_policy : {}

  role       = aws_iam_role.iam_role[0].name
  policy_arn = each.value.arn
}

# Adjuntar políticas file_custom_policy al rol
resource "aws_iam_role_policy_attachment" "file_custom_attachment" {
  for_each = var.create_role ? aws_iam_policy.file_custom_policy : {}

  role       = aws_iam_role.iam_role[0].name
  policy_arn = each.value.arn
}

# Adjuntar políticas gestionadas por AWS
resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  count = var.create_role ? length(var.policies_arn) : 0

  role       = aws_iam_role.iam_role[0].name
  policy_arn = var.policies_arn[count.index]
}

resource "aws_iam_role_policy" "inline" {
  count  = var.inline_policy_json != "" ? 1 : 0
  name   = "${var.role_name}-inline"
  role   = aws_iam_role.iam_role[0].name
  policy = var.inline_policy_json
}
