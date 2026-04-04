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
  spot                   = var.spot
  source_image_project   = var.source_image_project
  source_image_family    = var.source_image_family
  disk_size_gb           = 10
  disk_type              = "pd-standard"
  metadata = merge(var.additional_metadata, {
    user-data = templatefile("${path.cwd}/assets/cloud-config.yaml.tftpl", {
      docker_image_name       = var.docker_image_name
      docker_image_tag        = var.docker_image_tag
      cloudflared_image_name  = var.cloudflared_image_name
      cloudflared_image_tag   = var.cloudflared_image_tag
      gitea_image_name        = var.gitea_image_name
      gitea_image_tag         = var.gitea_image_tag
      cloudflared_token       = var.cloudflared_token
      gitea_ssh_domain        = var.gitea_ssh_domain
      gitea_domain            = var.gitea_domain
      gitea_root_url          = var.gitea_root_url
      gitea_lfs_jwt_secret    = var.gitea_lfs_jwt_secret
      gitea_internal_token    = var.gitea_internal_token
      gitea_oauth2_jwt_secret = var.gitea_oauth2_jwt_secret
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
