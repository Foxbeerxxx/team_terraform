output "marketing_vm_ip" {
  value = yandex_compute_instance.vm_marketing.network_interface[0].nat_ip_address
}

output "analytics_vm_ip" {
  value = yandex_compute_instance.vm_analytics.network_interface[0].nat_ip_address
}
