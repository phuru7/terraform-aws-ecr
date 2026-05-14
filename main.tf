resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)

  name                 = each.value
  image_tag_mutability = length(var.mutable_tag_exclusions) > 0 ? "IMMUTABLE_WITH_EXCLUSION" : var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" ? (var.kms_key_id != "" ? var.kms_key_id : null) : null
  }

  dynamic "image_tag_mutability_exclusion_filter" {
    for_each = var.mutable_tag_exclusions
    content {
      filter      = image_tag_mutability_exclusion_filter.value
      filter_type = "WILDCARD"
    }
  }

  lifecycle {
    precondition {
      condition     = var.env == "prod" ? var.force_delete == false : true
      error_message = "force_delete must be false in prod environment."
    }

    precondition {
      condition     = var.env == "prod" ? var.image_tag_mutability == "IMMUTABLE" : true
      error_message = "image_tag_mutability must be IMMUTABLE in prod environment."
    }
  }

  tags = {
    Name = each.value
  }
}