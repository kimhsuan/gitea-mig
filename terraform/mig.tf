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
  stateful_disks = [
    {
      device_name = "data"
      delete_rule = "NEVER"
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
