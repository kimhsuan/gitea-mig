variable "project_id" {
  type        = string
  description = "The project ID for the Google Cloud resources."
}

variable "org_name" {
  type = string
}

variable "app_name" {
  type    = string
  default = "gitea"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "region" {
  type        = string
  description = "The region where the resources will be deployed."
  default     = "us-west1"
}

variable "zone" {
  type        = string
  description = "The zone to create the instance in"
  default     = null
}

variable "spot" {
  type    = bool
  default = false
}

variable "source_image_project" {
  type    = string
  default = "cos-cloud"
}

variable "source_image_family" {
  type    = string
  default = "cos-125-lts"
}

variable "github_repository_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "ssh_keys" {
  description = "SSH keys to apply to the instance."
  type        = string
  default     = ""
}

variable "additional_metadata" {
  type        = map(any)
  description = "Additional metadata to attach to the instance"
  default     = {}
}

variable "docker_image_name" {
  type    = string
  default = "docker"
}

variable "docker_image_tag" {
  type    = string
  default = "27-cli"
}

variable "cloudflared_image_name" {
  type    = string
  default = "cloudflare/cloudflared"
}

variable "cloudflared_image_tag" {
  type    = string
  default = "2026.2.0"
}

variable "gitea_image_name" {
  description = "The name of the image to use for the instance."
  type        = string
  default     = "docker.gitea.com/gitea"
}

variable "gitea_image_tag" {
  description = "The tag of the image to use for the instance."
  type        = string
  default     = "latest-rootless"
}

variable "cloudflared_token" {
  type = string
}

variable "gitea_ssh_domain" {
  type = string
}

variable "gitea_domain" {
  type = string
}

variable "gitea_root_url" {
  type = string
}

variable "gitea_lfs_jwt_secret" {
  type = string
}

variable "gitea_internal_token" {
  type = string
}

variable "gitea_oauth2_jwt_secret" {
  type = string
}
