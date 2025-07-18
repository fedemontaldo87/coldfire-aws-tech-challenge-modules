package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCloudwatchMonitoringModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../terraform-aws-cloudwatch-monitoring",
		Vars: map[string]interface{}{
			"prefix":               "test-cloudwatch",
			"region":               "us-east-1",
			"alert_email":          "fake@example.com",
			"asg_name":             "dummy-asg-name",
			"alarm_cpu_threshold":  80,
			"cpu_low_threshold":    10,
		},
		PlanFilePath: "./plan.out",
	}

	_, err := terraform.InitAndPlanE(t, terraformOptions)
	assert.NoError(t, err)
}
