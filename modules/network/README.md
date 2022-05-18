# AWS Custom VPC

This Terraform module creates a VPC with the following resources:
- Internet Gateway
- Public Route Table
- Private Route Table
- Public Route Table Association with VPC
- Route from Public Route Table to Internet Gateway
- Three Public Subnets
- Three Private Subnets
- Public Subnet Association with Public Route Table
- Private Subnet Association with Private Route Table

Requirements: There are eight variables that you **must** specify in order to provide a valid Terraform configuration:

1. The cidr range for your VPC: `vpc_cidr`
2. Environment name: `env`
3. The cidr range for public subnet a: `public-subnet-cidr-a`
4. The cidr range for public subnet b: `public-subnet-cidr-b`
5. The cidr range for public subnet c: `public-subnet-cidr-c`
6. The cidr range for private subnet a: `private-subnet-cidr-a`
7. The cidr range for private subnet b: `private-subnet-cidr-b`
8. The cidr range for private subnet c: `private-subnet-cidr-c`

Example usage:
```
module "network" {
  source = "github.com/jakefurlong/terraform/modules/network"

  vpc_cidr              = "172.16.0.0/16"
  env                   = "Development"
  public-subnet-cidr-a  = "172.16.0.0/24"
  public-subnet-cidr-b  = "172.16.1.0/24"
  public-subnet-cidr-c  = "172.16.2.0/24"
  private-subnet-cidr-a = "172.16.3.0/24"
  private-subnet-cidr-b = "172.16.4.0/24"
  private-subnet-cidr-c = "172.16.5.0/24"
}
```

You can create separate directories for each environment (i.e. dev, test, prod) and create a `main.tf` file in each directory. In that main file, you can create a `module` block (see example aove) and change the variables to match your cloud environment. Example: `env` could have the same naming convention across environments but you have to replace "dev" with "prod" in the production directory. **Make sure you don't have overlapping networks!**
```
.
|--- README.md
|--- dev
|    |--- main.tf
|--- prod
|    |--- main.tf
```