module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 15.0.0"

  project_id         = var.project_id
  region             = var.region
  network            = module.vpc.network_name
  subnetwork         = module.vpc.subnets["${var.region}/${var.org_name}-${var.app_name}-${var.environment}-vpc-1-subnet-1"].name
  subnetwork_project = var.project_id
  access_config = [
    {
      network_tier = "STANDARD"
    },
  ]
  service_account = {
    email = null
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
  create_service_account = false
  name_prefix            = "${var.org_name}-${var.app_name}-${var.environment}"
  machine_type           = "e2-micro"
  spot                   = true
  source_image_family    = "cos-stable"
  source_image_project   = "cos-cloud"
  disk_size_gb           = 10
  disk_type              = "pd-standard"
  metadata = merge(var.additional_metadata, {
    user-data = templatefile("${path.cwd}/assets/cloud-config.yaml.tftpl", {
      gitea_image_name = var.gitea_image_name
      gitea_image_tag  = var.gitea_image_tag
    })
    ssh-keys = var.ssh_keys
  })
  tags = [
    "allow-cloud-iap",
    "allow-health-check",
  ]
  labels = {
    app = var.app_name
    env = var.environment
  }
}
