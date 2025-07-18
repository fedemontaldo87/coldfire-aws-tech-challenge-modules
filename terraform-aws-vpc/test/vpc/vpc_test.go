package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVpcModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../terraform-aws-vpc",
		Vars: map[string]interface{}{
			"vpc_cidr":            "10.0.0.0/16",
			"azs":                 []string{"us-east-1a", "us-east-1b"},
			"public_subnet_cidrs": []string{"10.0.1.0/24", "10.0.2.0/24"},
			"private_subnet_cidrs": []string{"10.0.3.0/24", "10.0.4.0/24"},
			"region":               "us-east-1",
		},
		EnvVars: map[string]string{
			"AWS_PROFILE": "dummy",
			"AWS_REGION":  "us-east-1",
		},
		NoColor: true,
	}

	terraform.Init(t, terraformOptions)
	plan := terraform.Plan(t, terraformOptions)

	t.Log("📄 Terraform plan:")
	t.Log(plan)

	assert.NotContains(t, plan, "Error:")
	assert.Contains(t, plan, "aws_vpc")
}
