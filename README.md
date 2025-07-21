# 🚀 Coldfire AWS Tech Challenge – Terraform Modules

[![Validate Terraform Modules](https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules/actions/workflows/validate-modules.yml/badge.svg)](https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules/actions/workflows/validate-modules.yml)

This repository contains a set of reusable and composable Terraform modules used to build a complete AWS infrastructure for the **Coldfire AWS Technical Challenge – July 2025**.

Each module is designed to be standalone, testable, and production-ready, with support for continuous integration, security scanning, and automated validation using **Terratest** and **tfsec**.

---

## 📦 Available Modules

- [`terraform-aws-vpc`](./terraform-aws-vpc): Creates a VPC with public and private subnets across multiple Availability Zones.
- [`terraform-aws-security-groups`](./terraform-aws-security-groups): Defines security groups for ALB and ASG following least privilege.
- [`terraform-aws-alb`](./terraform-aws-alb): Deploys an Application Load Balancer (ALB) with listeners and target groups.
- [`terraform-aws-asg`](./terraform-aws-asg): Creates an Auto Scaling Group with launch template and user_data script.
- [`terraform-aws-ec2-instance`](./terraform-aws-ec2-instance): Provisions a standalone EC2 instance with IAM profile and storage.
- [`terraform-aws-iam-roles`](./terraform-aws-iam-roles): Generates IAM roles and policies for EC2, ASG, and other services.
- [`terraform-aws-s3`](./terraform-aws-s3): Creates S3 buckets (`images`, `logs`) with lifecycle policies and initial folders.
- [`terraform-aws-cloudwatch-monitoring`](./terraform-aws-cloudwatch-monitoring): (Optional) Adds metrics, alarms, and CloudWatch dashboards.

## ✅ Testing & CI

Each module is validated automatically using **GitHub Actions**:

- ✅ Terraform `validate` and `plan`
- 🔐 Security scan via `tfsec`
- 🧪 Terratest execution with `go test`

CI pipeline: [.github/workflows/validate-modules.yml](.github/workflows/validate-modules.yml)

## 📁 Structure

Each module follows the standard Terraform layout:

terraform-aws-<module>/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── provider.tf (optional)
├── README.md
└── test/
├── <module>_test.go
└── create_dummy_profile.sh


All modules are versioned using Git and support `source` referencing for reuse in other Terraform projects.

## 🧪 How to Test locally

If you want to test a module locally, you can use the create_dummy_profile.sh script to create a dummy AWS profile with fake credentials. After setting up the dummy profile, you can run the Terraform plan and apply.

1- Go to the test folder of the desired module:
   cd terraform-aws-alb/test/alb
2- Set up the dummy AWS profile: 
   ./create_dummy_profile.sh
3- Run the Go test to execute the Terratest:
   go mod tidy
   go test -v

## References to Resources Used
- Terraform Documentation: https://www.terraform.io/docs
- AWS Provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- AWS Diagrams: AWS Architecture Icons
- Terratest: https://terratest.gruntwork.io/ (for automated infrastructure testing with Go).

---

<!-- BEGIN_TF_DOCS -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | Prefix for naming the S3 buckets | `string` | n/a | yes |
| region | AWS region where the infrastructure will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| images_bucket_name | The name of the S3 bucket for images |
| logs_bucket_name | The name of the S3 bucket for logs |

<!-- END_TF_DOCS -->

Changes made:

    <!-- BEGIN_TF_DOCS --> and <!-- END_TF_DOCS --> were inserted after the References to Resources Used section.

    The Inputs and Outputs sections now contain the placeholders for the auto-generated Terraform documentation.

Now, when you run terraform-docs to generate the documentation, it will automatically inject the module's inputs and outputs between these markers.
Next Steps:

    After making these changes, you can run terraform-docs to generate the documentation:

terraform-docs markdown ./ --output-file README.md --mode inject

This will inject the Terraform-generated content in the specified locations.
