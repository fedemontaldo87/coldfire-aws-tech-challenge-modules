package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestSecurityGroupModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../terraform-aws-security-groups",
		Vars: map[string]interface{}{
			"vpc_id":      "vpc-12345678",
			"name":        "test-sg",
			"description": "Security group for testing",
			"ingress_rules": []map[string]interface{}{
				{
					"type":             "ingress",
					"from_port":        22,
					"to_port":          22,
					"protocol":         "tcp",
					"cidr_blocks":      []string{"0.0.0.0/0"},
					"ipv6_cidr_blocks": []string{},
					"description":      "Allow SSH from anywhere",
				},
			},
		},
		EnvVars: map[string]string{
			"AWS_ACCESS_KEY_ID":     "dummyaccesskey",
			"AWS_SECRET_ACCESS_KEY": "dummysecretkey",
			"AWS_REGION":            "us-east-1",
		},
		NoColor: true,
	}

	terraform.Init(t, terraformOptions)
	plan := terraform.Plan(t, terraformOptions)

	t.Log("📄 Terraform plan:")
	t.Log(plan)

	assert.NotContains(t, plan, "Error:")
	assert.Contains(t, plan, "aws_security_group")
}
