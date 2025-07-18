package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAlbModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../..",
		Vars: map[string]interface{}{
			"name":            "test-alb",
			"vpc_id":          "vpc-12345678",
			"subnet_ids":      []string{"subnet-11111111", "subnet-22222222"},
			"security_groups": []string{"sg-12345678"},
			"internal":        false,
		},
		NoColor: true,
	})

	planOutput := terraform.InitAndPlan(t, terraformOptions)

	t.Log("📄 Terraform plan:\n", planOutput)

	assert.Contains(t, planOutput, "aws_lb.this will be created")
	assert.Contains(t, planOutput, "aws_lb_target_group.this will be created")
	assert.Contains(t, planOutput, "aws_lb_listener.http will be created")
}
