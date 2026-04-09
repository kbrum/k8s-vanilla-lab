variable "project_name" {
  description = "Nome do projeto aplicado em tags e nomes"
  type        = string
}

variable "tags" {
  description = "Tags padrao"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs das subnets onde as EC2 serao criadas"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "Informe pelo menos 2 subnets para distribuir as instancias."
  }
}
