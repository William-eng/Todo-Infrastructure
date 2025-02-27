# [Project](https://github.com/William-eng/To-do-App/) Infrastructure Repository
This repository contains Infrastructure as Code (IaC) for deploying a multi-service application using Terraform and Ansible on AWS.

## Directory Structure

          .
          ├── ansible
          │   └── playbook.yml
          ├── ansible.cfg
          ├── main.tf
          ├── modules
          │   └── server
          │       ├── main.tf
          │       ├── output.tf
          │       └── variable.tf
          ├── playbook.yml
          ├── README.md
          ├── roles
          │   ├── dependencies
          │   │   ├── defaults
          │   │   │   └── main.yml
          │   │   ├── handlers
          │   │   │   └── main.yml
          │   │   ├── meta
          │   │   │   └── main.yml
          │   │   ├── README.md
          │   │   ├── tasks
          │   │   │   └── main.yml
          │   │   ├── tests
          │   │   │   ├── inventory
          │   │   │   └── test.yml
          │   │   └── vars
          │   │       └── main.yml
          │   └── deployment
          │       ├── defaults
          │       │   └── main.yml
          │       ├── handlers
          │       │   └── main.yml
          │       ├── meta
          │       │   └── main.yml
          │       ├── README.md
          │       ├── tasks
          │       │   └── main.yml
          │       ├── tests
          │       │   ├── inventory
          │       │   └── test.yml
          │       ├── traefik.yml
          │       └── vars
          │           └── main.yml
          ├── templates
          │   └── inventory.tpl
          ├── terraform.tfstate
          ├── terraform.tfstate.backup
          ├── terraform.tfvars
          ├── tfvars.terraform
          └── variable.tf






## Overview
This project uses:

- Terraform to provision the required cloud infrastructure.
- Ansible to configure the provisioned servers and deploy the Todo Application.
- The infrastructure includes:


- An EC2 Instance for application servers
- Security Group for controlled access

## Technologies Used
- Terraform: Infrastructure as Code for provisioning cloud resources.
- Ansible: Configuration management and application deployment.
- AWS: Cloud provider for infrastructure resources.

## Prerequisites
Before you begin, ensure you have the following installed:

- Terraform (v1.0.0 or later)
- Ansible
- AWS CLI
- Git
- An AWS Account with necessary IAM permissions
- Setup Instructions
### Clone the Repository:


      git clone https://github.com/William-eng/Todo-Infrastructure.git
      cd Todo-Infrastructure


### Initialize Terraform:


      terraform init


### Configure AWS Credentials: Ensure your AWS credentials are set up. You can configure them using:


        aws configure


### Provision Infrastructure with Terraform:

Preview the infrastructure changes:



      terraform plan



### Apply the infrastructure changes:


      terraform apply



Generate Inventory File: After provisioning, Terraform will output public IPs. Use them to update the Ansible inventory file.

and it automatically runs Ansible Playbook:


Update the following variables in terraform.tfvars:



    region           = "us-east-1"
    project_name     = "todo-app"
    instance_type    = "t2.micro"
    hosted_zone_id   = ""





### Clean-Up
To destroy all resources provisioned by Terraform:

 
        terraform destroy


Ensure no critical data is lost before running the destroy command.

