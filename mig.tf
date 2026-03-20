module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 15.0.0"

  project_id        = var.project_id
  instance_template = module.instance_template.self_link
  region            = var.region
  hostname          = "${var.org_name}-${var.app_name}-${var.environment}"
  target_size       = null
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
}

resource "google_compute_region_per_instance_config" "gitea" {
  name                          = "${var.org_name}-${var.app_name}-${var.environment}"
  region                        = var.region
  region_instance_group_manager = module.mig.instance_group_manager.name

  preserved_state {
    disk {
      device_name = "data"
      source      = google_compute_disk.data.id
    }
  }
}
