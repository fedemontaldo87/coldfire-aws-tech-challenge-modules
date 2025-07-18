// ec2_test.go
package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEC2ModulePlan(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../../terraform-aws-ec2-instance",
		Vars: map[string]interface{}{
			"name":                   "test-ec2",
			"ami":                    "ami-0c55b159cbfafe1f0", // RHEL 9 en us-east-1
			"instance_type":          "t3.micro",
			"key_name":               "dummy-key",
			"monitoring":             true,
			"vpc_security_group_ids": []string{"sg-12345678"},
			"subnet_id":              "subnet-12345678",
			"tags": map[string]string{
				"Environment": "test",
				"Terraform":   "true",
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
	assert.Contains(t, plan, "aws_instance")
}
