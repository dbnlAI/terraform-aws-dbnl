variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete blobstore (S3) data on destroy."
  default     = false
}
