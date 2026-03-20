resource "google_compute_disk" "data" {
  name = "${var.org_name}-${var.app_name}-${var.environment}-data"
  type = "pd-standard"
  zone = local.zone
  size = 10
}
