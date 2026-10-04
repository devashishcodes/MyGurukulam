module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "assignment-5-vpc"
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id

  internet_gateway_id = module.vpc.internet_gateway_id

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.2.0/24",
    "10.0.4.0/24"
  ]

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id              = module.vpc.vpc_id
  security_group_name = "assignment-5-ec2-sg"
}

module "instance" {
  source = "./modules/instance"

  subnet_ids        = module.subnet.public_subnet_ids
  security_group_id = module.security_group.security_group_id
  instance_type     = "t3.micro"
  key_name          = "assignment2-key"
}