variable "project_id" {
  description = "The project ID for the Google Cloud resources."
  type        = string
}

variable "org_name" {
  description = "The organization name used for naming and labeling resources."
  type        = string
}

variable "app_name" {
  description = "The application name used for naming resources."
  type        = string
  default     = "gitea"
}

variable "environment" {
  description = "The deployment environment name."
  type        = string
  default     = "test"
}

variable "region" {
  description = "The region where the resources will be deployed."
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "The zone where the instance will be created."
  type        = string
  default     = null
}

variable "spot" {
  description = "Whether to use spot capacity for the instance."
  type        = bool
  default     = false
}

variable "source_image_project" {
  description = "The project that provides the source image family for the instance."
  type        = string
  default     = "cos-cloud"
}

variable "source_image_family" {
  description = "The source image family used to create the instance boot disk."
  type        = string
  default     = "cos-125-lts"
}

variable "github_repository_owner" {
  description = "The GitHub repository owner used for workload identity federation configuration."
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository name used for workload identity federation configuration."
  type        = string
}

variable "ssh_keys" {
  description = "SSH keys to apply to the instance."
  type        = string
  default     = ""
}

variable "additional_metadata" {
  description = "Additional metadata to attach to the instance."
  type        = map(any)
  default     = {}
}

variable "docker_image_name" {
  description = "The Docker CLI image name used for container management tasks."
  type        = string
  default     = "docker"
}

variable "docker_image_tag" {
  description = "The Docker CLI image tag used for container management tasks."
  type        = string
  default     = "27-cli"
}

variable "gitea_image_name" {
  description = "The Gitea container image name."
  type        = string
  default     = "docker.gitea.com/gitea"
}

variable "gitea_image_tag" {
  description = "The Gitea container image tag."
  type        = string
  default     = "latest-rootless"
}

variable "cloudflared_token" {
  description = "The Cloudflared tunnel token used to authenticate the tunnel client."
  type        = string
}

variable "gitea_domain" {
  description = "The domain name used to expose the Gitea service."
  type        = string
}

variable "gitea_root_url" {
  description = "The externally accessible root URL for the Gitea instance."
  type        = string
}

variable "gitea_lfs_jwt_secret" {
  description = "The JWT secret used by Gitea for Git LFS authentication."
  type        = string
}

variable "gitea_internal_token" {
  description = "The internal token used by Gitea for inter-service authentication."
  type        = string
}

variable "gitea_oauth2_jwt_secret" {
  description = "The JWT secret used by Gitea for OAuth2 operations."
  type        = string
}
