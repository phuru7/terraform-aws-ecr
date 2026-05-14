# ── ECR Repositories ──────────────────────────────────────
output "repository_urls" {
  description = "Map of repository name => repository URL"
  value       = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "repository_arns" {
  description = "Map of repository name => repository ARN"
  value       = { for k, v in aws_ecr_repository.this : k => v.arn }
}

output "repository_names" {
  description = "List of created repository names"
  value       = [for v in aws_ecr_repository.this : v.name]
}

output "registry_id" {
  description = "AWS account ID associated with the ECR registry"
  value       = values(aws_ecr_repository.this)[0].registry_id
}