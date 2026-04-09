output "control_plane_instance_id" {
  description = "ID da instancia control plane"
  value       = aws_instance.control_plane.id
}

output "worker_instance_ids" {
  description = "IDs das instancias worker"
  value       = aws_instance.worker[*].id
}

output "instance_public_ips" {
  description = "IPs publicos das instancias"
  value = {
    control_plane = aws_eip.control_plane.public_ip
    workers       = aws_eip.worker[*].public_ip
  }
}

output "instance_eip_allocation_ids" {
  description = "Allocation IDs dos Elastic IPs"
  value = {
    control_plane = aws_eip.control_plane.id
    workers       = aws_eip.worker[*].id
  }
}
