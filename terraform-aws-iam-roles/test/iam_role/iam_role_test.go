package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)


func TestIAMRoleModulePlanOnly(t *testing.T) {
	t.Parallel()

	baseVars := map[string]interface{}{
		"account_id":         "123456789012",
		"role_name":          "test-ec2-role",
		"environment":        "test",
		"business_unit":      "devops",
		"assume_role_index":  "EC2",
		"region":             "us-east-1",
		"inline_policy_json": "",
		"policies_arn":       []string{},
	}

	terraformOptions := &terraform.Options{
		TerraformDir: "../../",
		Vars:         baseVars,
		NoColor:      true,
		EnvVars: map[string]string{
			"AWS_ACCESS_KEY_ID":     "dummyaccesskey",
			"AWS_SECRET_ACCESS_KEY": "dummysecretkey",
			"AWS_REGION":            "us-east-1",
		},
	}

	// Step 1: Init and plan without inline policy
	terraform.Init(t, terraformOptions)
	planWithoutPolicy := terraform.Plan(t, terraformOptions)
	t.Log("✅ Plan without inline policy:")
	t.Log(planWithoutPolicy)

	assert.NotContains(t, planWithoutPolicy, "Error:")
	assert.Contains(t, planWithoutPolicy, "aws_iam_role")

	// Step 2: Add inline policy and re-plan (text output)
	baseVars["inline_policy_json"] = loadPolicy("../../policies/combined_inline_policy.json")
	terraformOptions.Vars = baseVars

	planWithPolicy := terraform.Plan(t, terraformOptions)
	t.Log("📄 Plan with inline policy:")
	t.Log(planWithPolicy)

	assert.Contains(t, planWithPolicy, "aws_iam_role")
	if baseVars["inline_policy_json"] != "" {
    assert.Contains(t, planWithPolicy, "aws_iam_role_policy")
}
	assert.NotContains(t, planWithPolicy, "Error:")
}

func loadPolicy(path string) string {
	data, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}
	return string(data)
}
