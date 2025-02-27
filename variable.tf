variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "ami" {
  description = "Ubuntu 24.04 AMI ID"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
  default     = "app_sg"
}

variable "server_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
variable "domain" {
  description = "Domain name for the application"
  type        = string
  default = "liberttinnii.xyz"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
  default = "your hosted zone id"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default = "worker"
  
}