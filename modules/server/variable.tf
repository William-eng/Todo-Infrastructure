variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 server"
  type        = string
  default     = "t2.medium"
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}
variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}
variable "domain" {
  description = "Domain name for the application"
  type        = string
}
variable "security_group_name" {
  description = "Security Group Name"
  type        = string
}
variable "key_name" {
  description = "SSH key name"
  type        = string
  
}
