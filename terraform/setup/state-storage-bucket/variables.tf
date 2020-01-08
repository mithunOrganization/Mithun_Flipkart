variable env {
  description = "unique environment identifier"
}

variable my_unique_bucket {
  default = "devops-101"
}

variable region {
  default = "eu-west-1"
}

variable role-arns {
  description = "list of role arns that will have access to s3 and kms"
  type        = "list"
}

variable tf-state-bucket {
  description = "list of role arns that will have access to s3 and kms"
  default = "dev-app-tf-state"
}
