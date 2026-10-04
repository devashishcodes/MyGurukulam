output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the created VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.subnet.private_subnet_ids
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.security_group.security_group_id
}

output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = module.instance.instance_ids
}

output "public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.instance.public_ips
}

output "private_ips" {
  description = "Private IP addresses of EC2 instances"
  value       = module.instance.private_ips
}