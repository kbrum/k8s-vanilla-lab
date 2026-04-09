output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs das 2 subnets publicas"
  value       = module.network.public_subnet_ids
}

output "control_plane_instance_id" {
  description = "ID da instancia Control Plane"
  value       = module.compute.control_plane_instance_id
}

output "worker_instance_ids" {
  description = "IDs das instancias Worker"
  value       = module.compute.worker_instance_ids
}

output "instance_public_ips" {
  description = "IPs publicos das instancias"
  value       = module.compute.instance_public_ips
}

output "instance_eip_allocation_ids" {
  description = "Allocation IDs dos Elastic IPs"
  value       = module.compute.instance_eip_allocation_ids
}
