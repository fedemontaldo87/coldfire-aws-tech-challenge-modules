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

```plaintext
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
- terraform-docs: https://terraform-docs.io/ (A utility to generate documentation from Terraform modules in various output formats)

##  How to Automatically Update the README with terraform-docs

This repository uses terraform-docs to automatically generate and update the Inputs and Outputs sections of the README file when changes are made to any Terraform module.

To ensure that the README file is always up-to-date, follow the steps below:

1- Create or Modify .terraform-docs.yml File

Make sure the following configuration is included in your project. This file tells terraform-docs how to format the output:

formatter: markdown
output:
  file: README.md
  mode: inject
settings:
  anchor: false
  color: false
  default: true
  description: true
  escape: false
  hide-empty: true
  html: false
  indent: 2
  lockfile: true
  output-values: true
  read-comments: true
  required: true
  sensitive: true
  type: true

2- Update the README with terraform-docs

After making any changes to a Terraform module, run the following command to automatically update the README.md:

This command will:

- Generate the Inputs and Outputs sections of the README file.
- Inject the Terraform documentation content between the special markers.


##  Example Format for Your README

You will notice that terraform-docs will place the auto-generated content between these markers:

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


## Changes made:

    <!-- BEGIN_TF_DOCS --> and <!-- END_TF_DOCS --> were inserted after the References to Resources Used section.

- <!-- BEGIN_TF_DOCS --> and <!-- END_TF_DOCS --> were inserted after the References to Resources Used section.
- The Inputs and Outputs sections now contain placeholders for the auto-generated Terraform documentation.

## Next Steps:

- Run terraform-docs whenever you make changes to the module (such as adding new input variables or outputs).
- This will automatically inject the Terraform-generated content into the specified locations in the README.
- Ensure you commit and push any changes to the README after updating it.

##  Why Use This Approach?

By using terraform-docs, you ensure that your module documentation is always up-to-date and reflects the current state of your Terraform configuration. Every time you change your module (add a new variable, output, or resource), you can easily regenerate the README without manually editing it.