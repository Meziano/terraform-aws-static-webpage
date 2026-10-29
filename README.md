# terraform-aws-static-webpage

Serve a custom web page from an EC2 instance in AWS, generated via Terraform, displaying instance metadata (ID, type, AZ, public IP) fetched from IMDS v2 at boot.

## Infrastructure (Terraform)

| File | Contents |
|:----|:---|
| providers.tf | AWS provider, region eu-central-1 |
| variables.tf | project_name, environment, vpc_cidr, public_subnet_cidr, ami_id, instance_type, key_name |
| main.tf | locals.common_tags only |
| vpc.tf  | VPC, IGW, public subnet (eu-central-1a), route table, RTA |
| security.tf | SG: HTTP:80 from 0.0.0.0/0, SSH:22 from data.external.my_ip (your IP via curl) |
| instance.tf  | data.aws_ami (latest Ubuntu 22.04), aws_instance with user_data script |
| outputs.tf   | web_public_ip, instance_id, vpc_id, public_subnet_id, my_ip |
