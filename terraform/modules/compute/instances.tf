resource "aws_instance" "control_plane" {
  ami                    = data.aws_ami.ubuntu_lts.id
  instance_type          = "m6a.large"
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tags = merge(var.tags, {
    Name    = "${var.project_name}-control-plane"
    Project = var.project_name
    Node    = "Control-Plane"
  })
}

resource "aws_instance" "worker" {
  count = 2

  ami                    = data.aws_ami.ubuntu_lts.id
  instance_type          = "t3.medium"
  subnet_id              = var.subnet_ids[(count.index + 1) % length(var.subnet_ids)]
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tags = merge(var.tags, {
    Name    = "${var.project_name}-worker-${count.index + 1}"
    Project = var.project_name
    Node    = "Worker"
  })
}
