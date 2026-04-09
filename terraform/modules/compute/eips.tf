resource "aws_eip" "control_plane" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name    = "${var.project_name}-control-plane-eip"
    Project = var.project_name
    Node    = "Control-Plane"
  })
}

resource "aws_eip_association" "control_plane" {
  instance_id   = aws_instance.control_plane.id
  allocation_id = aws_eip.control_plane.id
}

resource "aws_eip" "worker" {
  count  = 2
  domain = "vpc"

  tags = merge(var.tags, {
    Name    = "${var.project_name}-worker-${count.index + 1}-eip"
    Project = var.project_name
    Node    = "Worker"
  })
}

resource "aws_eip_association" "worker" {
  count = 2

  instance_id   = aws_instance.worker[count.index].id
  allocation_id = aws_eip.worker[count.index].id
}
