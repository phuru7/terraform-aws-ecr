# ── Identity ──────────────────────────────────────────────
variable "env" {
  description = "Environment: dev | qa | prod"
  type        = string
  default     = "dev"
}

variable "org" {
  description = "Organization name"
  type        = string
}

# ── Repositories ──────────────────────────────────────────
variable "repository_names" {
  description = "List of ECR repository names to create. Names are defined by the calling module."
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "Tag mutability: MUTABLE | IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Must be 'MUTABLE' or 'IMMUTABLE'."
  }
}

variable "mutable_tag_exclusions" {
  description = "Tags que serán mutables aunque el repo sea IMMUTABLE"
  type        = list(string)
  default     = []
}

variable "force_delete" {
  description = "If true, deletes the repository even if it contains images. Not allowed in prod."
  type        = bool
  default     = false
}

variable "scan_on_push" {
  description = "Enable image vulnerability scan on push"
  type        = bool
  default     = true
}

# ── Encryption ────────────────────────────────────────────
variable "encryption_type" {
  description = "Encryption type: AES256 | KMS"
  type        = string
  default     = "KMS"

  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Must be 'AES256' or 'KMS'."
  }
}

variable "kms_key_id" {
  description = "KMS key ARN for encryption. Required when encryption_type is KMS."
  type        = string
  default     = ""
}
