# Terraform module to deploy Wordpress in AWS


Terraform module which creates Wordpress resources on AWS.


The following resources will be created in AWS:

* [AWS VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
* [AWS Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/working-with-vpcs.html#AddaSubnet)
* [AWS Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
* [AWS VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html)
* [AWS EC2 Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
* [AWS EC2 Key Pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* [AWS Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
* [AWS EC2 Target Groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)
* [AWS Launch Configurations](https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchConfiguration.html)
* [AWS Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html)
* [AWS RDS (Relational Database Service)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html)


## Usage

#### 1. Update the **provider.tf** file to provide your credentials.

Update the values accordingly. **UPPERCASE** values should always be updated.
```hcl
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile = "PROFILE"
  region = "${var.aws_region}"
}
terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    key = "infrastructure/wordpress"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "PROFILE"
  }
}
```


#### 2. Update the **variables.tf** file to personalize the deployment.
Update the values accordingly, if no profile has been created use `aws configure --profile PROFILE_NAME` to create a new profile.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| profile | AWS profile to use, use `aws configure --profile PROFILE_NAME` to create a new profile | string | `PROFILE` | yes |
| aws_region | AWS Region to use | string | `us-east-1` | yes |
| public_key | To create a new key pair run 'ssh-keygen -t rsa -b 4096 -C noname' and specify the public key `key.pub` | string | `~/.ssh/key.pub` | yes |
| key_name | Name of key-pair to create | string | `bastion_key` | yes |
| bastion_ami | AWS AMI to use in the bastion host [link](https://aws.amazon.com/amazon-linux-ami/) | string | `ami-b70554c8` | yes |
| bastion_type | Instance type to use for bastion host [link](https://aws.amazon.com/ec2/instance-types/) | string | `t2.small` | yes |
| **RDS Inputs** | - | - | - | - |
| db_username | username for DB | string | `username` | yes |
| db_password | password for DB | string | `YourPwdShouldBeLongAndSecure!` | yes |
| db_instance_class | Instance type to use for DB [link](https://aws.amazon.com/rds/instance-types/) | string | `db.t2.medium` | yes |
| **VPC Inputs ** | - | - | - | - |
| vpc-name | VPC Name | string | `wordpress` | yes |
| vpc-cidr | The CIDR block for the VPC | string | `172.16.0.0/20` | yes |
| vpc-azs | A list of availability zones in the region | list | `[ "us-east-1e", "us-east-1b", "us-east-1c" ]` | yes |
| vpc-priv-sub | A list of private subnets inside the VPC | list | `[ "172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24" ]` | yes |
| vpc-pub-sub | A list of public subnets inside the VPC	 | list | `[ "172.16.12.0/24", "172.16.11.0/24", "172.16.10.0/24" ]` | yes |


## Outputs

| Name | Description |
|------|-------------|
| dns_name | Load Balancer DNS Name |

## Considerations
Be aware that Terraform can post `creation completed` on some resources like AWS instances  before resources are fully operative, Terraform can finish deploying and the system could take a few minutes to be ready.

## Terraform version

Terraform version 0.11.8 is required for this module to work.

## Authors

Module is maintain by [Ivan Torrellas](https://github.com/ivantorrellas).

## License

MIT License. See LICENSE for full details.
