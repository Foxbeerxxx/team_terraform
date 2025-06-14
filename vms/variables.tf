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
