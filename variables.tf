variable "project_id" {
  description = "The project ID for the Google Cloud resources."
  type        = string
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
  description = "The region where the resources will be deployed."
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "The zone to create the instance in"
  type        = string
  default     = null
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
