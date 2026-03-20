module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 16.1"

  project_id   = var.project_id
  network_name = "${var.org_name}-${var.app_name}-${var.environment}-vpc-1"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${var.org_name}-${var.app_name}-${var.environment}-vpc-1-subnet-1"
      subnet_ip     = "10.10.10.0/29"
      subnet_region = var.region
    }
  ]

  firewall_rules = [
    {
      name = "${var.org_name}-${var.app_name}-${var.environment}-cloud-iap-tcp-allow-rule"
      ranges = [
        "35.235.240.0/20",
      ]
      target_tags = [
        "allow-cloud-iap",
      ]
      allow = [
        {
          protocol = "tcp"
        }
      ]
    },
    {
      name = "${var.org_name}-${var.app_name}-${var.environment}-health-check-all-allow-rule"
      ranges = [
        "35.191.0.0/16",
        "130.211.0.0/22",
      ]
      target_tags = [
        "allow-cloud-iap",
      ]
      allow = [
        {
          protocol = "all"
        }
      ]
    },
  ]
}
