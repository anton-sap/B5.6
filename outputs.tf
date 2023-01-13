output "ya-vm-1_internal_ip_address" {
  value = module.ya-vm-1.internal_ip_address_vm
}

output "ya-vm-1_external_ip_address" {
  value = module.ya-vm-1.external_ip_address_vm
}

output "ya-vm-2_internal_ip_address" {
  value = module.ya-vm-2.internal_ip_address_vm
}

output "ya-vm-2_external_ip_address" {
  value = module.ya-vm-2.external_ip_address_vm
}

output "lb_external_ip" {
  value = [for s in yandex_lb_network_load_balancer.web-servers.listener: s.external_address_spec.*.address].0[0]
}