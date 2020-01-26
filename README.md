# opsschool-mid-project
Opsschool 2020 mid-course project

This project is creates a full CI/CD process for WEB application (WEB app TBD).
In this project using AWS services. The AWS environment is created using Terraform.
- Tools involved in this project:
    * Ansible (not implemented yet)
    * Terraform
    * K8s (not implemented yet)
    * Docker (not implemented yet)
    * Consul (not implemented yet)
    * Jenkins (not implemented yet)
    
- Environment details:
    * Terraform will create a VPC with all requirements.
    * Ansible will install and configure k8s (Might change to EKS).
    * Deploy your application in K8s and expose the service to the world.
    * The application needs to register with consul.
    * Runs tests.