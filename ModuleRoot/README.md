🧠 High-Level Architecture

Root Module
   |
   ├── VPC Module
   |     ├── VPC (10.0.0.0/16)
   |     ├── Public Subnet (10.0.1.0/24)
   |     ├── Internet Gateway + Route Table
   |     └── Security Group (allow all)
   |
   └── EC2 Module
         └── Ubuntu EC2 (t2.micro)

==================================================================================================================

📁 Folder Structure (Mental Map)

ModuleRoot/
├── main.tf                # Root module (orchestration)
└── Modules/
    ├── vpc_module/               # Network layer
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2_module/               # Compute layer
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

==================================================================================================================

🧩 Module Responsibilities
🔹 VPC Module (Network-Owned)

Creates:
  1. VPC (10.0.0.0/16)
  2. Public Subnet (10.0.1.0/24)
  3. Internet Gateway
  4. Route Table
  5. Security Group (allow all traffic)
  6. Outputs:
      vpc_id
      public_subnet_id
      security_group_id

🔹 EC2 Module
Creates:
  1. Ubuntu EC2 instance (t2.micro)

Consumes:
  1. Subnet ID (from VPC module)
  2. Security Group ID (from VPC module)

Outputs:
  1. public_ip

==================================================================================================================

🔗 How Modules Are Connected?

Modules never reference resources outside themselves. Only the root module can connect modules.

1. VPC Module Exposes What It Creates

Inside the VPC module, Terraform creates resources and then provides few values as outputs so that it can be used by EC2 module.

    output "vpc_id" {
        value = aws_vpc.vpc_module.id
    }

    output "vpc_security_group_ids" {
        value = aws_security_group.sg.id
    }

2. Root Module reads those outputs & injects those values into the EC2 module:

    module "ec2" {
        subnet_id          = module.vpc_module.public-id                >> Means, In vpc_module, reads the subnet_id output name
        security_group_ids = [module.vpc_module.vpc_security_group_ids] >> Means, In vpc_module, reads the security_group_ids nam
    }


Outputs → Inputs → Dependency Graph

Terraform automatically ensures:

VPC → Subnet → SG → EC2


No depends_on required.