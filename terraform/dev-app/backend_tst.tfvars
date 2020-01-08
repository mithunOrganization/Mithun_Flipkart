bucket     = "dev-app-tf-state-${var.env}-${var.my_unique_bucket}"
region     = "eu-west-1"
encrypt    = true
kms_key_id = "alias/dev-app-tf-state-${var.env}-${var.my_unique_bucket}"
