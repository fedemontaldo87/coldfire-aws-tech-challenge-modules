package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestAutoscalingModulePlan(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../../",  // <-- corregido

    Vars: map[string]interface{}{
      "region":                "us-east-1",
      "ami_id":                "ami-12345678",
      "instance_type":         "t2.micro",
      "key_name":              "dummy-key",
      "security_groups":       []string{"sg-12345678"},
      "subnet_ids":            []string{"subnet-abc", "subnet-def"},
      "instance_profile_name": "dummy-instance-profile",
      "desired_capacity":      1,
      "min_size":              1,
      "max_size":              2,
      "target_group_arns":     []string{"arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/test/abcdef123456"},
      "user_data":             "#!/bin/bash\necho hello",
      "name":                  "test-asg",
    },

    PlanFilePath: "./plan.out",
  }

  _, err := terraform.InitAndPlanE(t, terraformOptions)
  assert.NoError(t, err)
}
