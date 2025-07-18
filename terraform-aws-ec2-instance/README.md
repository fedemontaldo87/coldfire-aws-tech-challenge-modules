# AWS EC2 Instance Terraform Module

Terraform module which creates EC2 instance(s) on AWS.

This module supports:

- Launching one or more EC2 instances with customizable parameters
- Specifying key pair, instance type, AMI, subnet and security groups
- Adding custom tags
- Optional monitoring

These types of resources are supported:

* [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [aws_ami_copy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_copy)
* [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)

# Usage

```hcl
module "ec2_instance" {
  source                 = "git::https://github.com/fedemontaldo87/coldfire-aws-tech-challenge-modules.git//terraform-aws-ec2-instance?ref=v1.0.0"

  name                   = "rhel-ec2"
  ami                    = "ami-0c55b159cbfafe1f0" # RHEL 9 en us-east-1
  instance_type          = "t3.micro"
  key_name               = "mi-clave-ec2"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}



Terraform Documentation
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.100.0 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access_key | n/a | `string` | `"dummy"` | no |
| ami | ID of AMI to use for the instance | `string` | n/a | yes |
| associate_public_ip_address | If true, the EC2 instance will have associated public IP address | `bool` | `null` | no |
| cpu_credits | The credit option for CPU usage (unlimited or standard) | `string` | `"standard"` | no |
| disable_api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `false` | no |
| ebs_block_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| ephemeral_block_device | Customize Ephemeral (also known as Instance Store) volumes on the instance | `list(map(string))` | `[]` | no |
| get_password_data | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| iam_instance_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | `string` | `""` | no |
| instance_count | Number of instances to launch | `number` | `1` | no |
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance | `string` | `""` | no |
| instance_type | The type of instance to start | `string` | n/a | yes |
| ipv6_address_count | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. | `number` | `null` | no |
| ipv6_addresses | Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface | `list(string)` | `null` | no |
| key_name | The key name to use for the instance | `string` | `""` | no |
| metadata_options | Customize the metadata options of the instance | `map(string)` | `{}` | no |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| name | Name to be used on all resources as prefix | `string` | n/a | yes |
| network_interface | Customize network interfaces to be attached at instance boot time | `list(map(string))` | `[]` | no |
| num_suffix_format | Numerical suffix format used as the volume and EC2 instance name suffix | `string` | `"-%d"` | no |
| placement_group | The Placement Group to start the instance in | `string` | `""` | no |
| private_ip | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| private_ips | A list of private IP address to associate with the instance in a VPC. Should match the number of instances. | `list(string)` | `[]` | no |
| region | n/a | `string` | `"us-east-1"` | no |
| root_block_device | Customize details about the root block device of the instance. See Block Devices below for details | `list(map(string))` | `[]` | no |
| secret_key | n/a | `string` | `"dummy"` | no |
| source_dest_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. | `bool` | `true` | no |
| subnet_id | The VPC Subnet ID to launch in | `string` | `""` | no |
| subnet_ids | A list of VPC Subnet IDs to launch in | `list(string)` | `[]` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| tenancy | The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. | `string` | `"default"` | no |
| use_num_suffix | Always append numerical suffix to instance name, even if instance_count is 1 | `bool` | `false` | no |
| user_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead. | `string` | `null` | no |
| user_data_base64 | Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| vpc_security_group_ids | A list of security group IDs to associate with | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | List of ARNs of instances |
| availability_zone | List of availability zones of instances |
| credit_specification | List of credit specification of instances |
| ebs_block_device_volume_ids | List of volume IDs of EBS block devices of instances |
| id | List of IDs of instances |
| instance_count | Number of instances to launch specified as argument to this module |
| instance_id | ID de la instancia creada |
| instance_state | List of instance states of instances |
| ipv6_addresses | List of assigned IPv6 addresses of instances |
| key_name | List of key names of instances |
| metadata_options | List of metadata options of instances |
| password_data | List of Base-64 encoded encrypted password data for the instance |
| placement_group | List of placement groups of instances |
| primary_network_interface_id | List of IDs of the primary network interface of instances |
| private_dns | List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC |
| private_ip | List of private IP addresses assigned to the instances |
| public_dns | List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC |
| public_ip | List of public IP addresses assigned to the instances, if applicable |
| root_block_device_volume_ids | List of volume IDs of root block devices of instances |
| security_groups | List of associated security groups of instances |
| subnet_id | List of IDs of VPC subnets of instances |
| tags | List of tags of instances |
| volume_tags | List of tags of volumes of instances |
| vpc_security_group_ids | List of associated security groups of instances, if running in non-default VPC |
<!-- END_TF_DOCS -->