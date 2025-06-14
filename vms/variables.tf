###cloud vars

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
}
variable "image_id" {
  description = "ID образа для ВМ"
  type        = string
}

variable "subnet_id" {
  description = "ID подсети"
  type        = string
}


variable "ip_address" {
  type        = string
  description = "ip-адрес"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_address))
    error_message = "Значение должно быть валидным IPv4 адресом."
  }
}

variable "ip_list" {
  type        = list(string)
  description = "список ip-адресов"
  validation {
    condition = alltrue([
      for ip in var.ip_list : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", ip))
    ])
    error_message = "Все значения должны быть валидными IPv4 адресами."
  }
}
