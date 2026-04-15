resource "aws_route_table" "k8s-vanilla-lab-rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
  })
}

resource "aws_route_table_association" "k8s-vanilla-lab-rt-ass" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.k8s-vanilla-lab-rt.id
}
