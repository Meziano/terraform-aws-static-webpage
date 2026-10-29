variable "aws_region" {
  description = "AWS Region für alle Ressourcen"
  type        = string
  default     = "eu-central-1" # Frankfurt - naheliegend für CH, vollständig unterstützt
}

variable "project_name" {
  description = "Projektname, wird als Präfix für Ressourcennamen genutzt"
  type        = string
  default     = "static-web-page"
}

variable "environment" {
  description = "Umgebung (z.B. dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR-Block für die VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR-Blocks für die öffentlichen Subnets (mind. 1, in unterschiedlichen AZs)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  type    = string
  default = "ami-0fa06da5547f46a7d"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# variables.tf
variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair"
  default     = "key_pair_4_static_webpage"
}   