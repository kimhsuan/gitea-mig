resource "google_compute_disk" "data" {
  name = "${var.org_name}-${var.app_name}-${var.environment}-data"
  type = "pd-standard"
  zone = local.zone
  size = 10
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 15.0.0"

  project_id        = var.project_id
  instance_template = module.instance_template.self_link
  region            = var.region
  hostname          = "${var.org_name}-${var.app_name}-${var.environment}"
  target_size       = 1
  update_policy = [
    {
      instance_redistribution_type   = "NONE"
      max_surge_fixed                = 0
      max_unavailable_fixed          = 1
      replacement_method             = "RECREATE"
      minimal_action                 = "RESTART"
      most_disruptive_allowed_action = "REPLACE"
      type                           = "PROACTIVE"
    },
  ]
  distribution_policy_zones = [local.zone]
  # named_ports = [
  #   {
  #     name = "gitea"
  #     port = 3000
  #   },
  # ]
  # health_check = {
  #   type                = "tcp"
  #   initial_delay_sec   = 30
  #   check_interval_sec  = 30
  #   healthy_threshold   = 1
  #   timeout_sec         = 10
  #   unhealthy_threshold = 5
  #   response            = ""
  #   proxy_header        = "NONE"
  #   port                = 3000
  #   request             = ""
  #   request_path        = "/"
  #   host                = ""
  #   enable_logging      = true
  # }
}

resource "google_compute_region_per_instance_config" "gitea" {
  region                        = var.region
  region_instance_group_manager = module.mig.instance_group_manager.name
  name                          = "${var.org_name}-${var.app_name}-${var.environment}"

  preserved_state {
    disk {
      device_name = "data"
      source      = google_compute_disk.data.id
      mode        = "READ_WRITE"
    }
  }
}
