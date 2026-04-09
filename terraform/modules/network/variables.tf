variable "project_name" {
  description = "Nome do projeto aplicado em tags e nomes"
  type        = string
}

variable "tags" {
  description = "Tags padrao"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista com 2 CIDRs para as subnets publicas"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Informe exatamente 2 CIDRs para public_subnet_cidrs."
  }
}
