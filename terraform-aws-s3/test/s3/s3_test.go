package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestS3ModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../terraform-aws-s3",
		Vars: map[string]interface{}{
			"prefix": "test-bucket",
			"region": "us-east-1",
		},
		PlanFilePath: "./plan.out",
	}

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	assert.NoError(t, err)
}
