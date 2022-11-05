# Terraform GCP
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "balancer" {
    value = join(" ", google_compute_instance.balancer.*.network_interface.0.access_config.0.nat_ip)
}

output "balancer_ssh" {
 value = google_compute_instance.balancer.self_link
}

# example for a set of identical instances created with "count"
output "bootstorage_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.bootstorage[*].name, google_compute_instance.bootstorage[*].network_interface.0.access_config.0.nat_ip)
}

output "expressed_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.expressed[*].name, google_compute_instance.expressed[*].network_interface.0.access_config.0.nat_ip)
}

output "happy_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.happy[*].name, google_compute_instance.happy[*].network_interface.0.access_config.0.nat_ip)
}

output "vuecalc_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.vuecalc[*].name, google_compute_instance.vuecalc[*].network_interface.0.access_config.0.nat_ip)
}

output "monitoring_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.monitoring[*].name, google_compute_instance.monitoring[*].network_interface.0.access_config.0.nat_ip)
}
