locals {
  zone = var.zone == null ? data.google_compute_zones.available.names[0] : var.zone
}
