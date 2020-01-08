resource "aws_s3_bucket" "storage" {
  bucket = "dev-app-tf-state-${var.env}-${var.my_unique_bucket}"

  versioning {
    enabled = true
  }

  tags {
    Name      = "dev-app-tf-state-${var.env}-${var.my_unique_bucket}"
    env       = "${var.env}"
    terraform = "true"
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = "${aws_s3_bucket.storage.bucket}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowIAMAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": ${jsonencode(var.role-arns)}
            },
            "Action": [
                "s3:List*",
                "s3:Get*",
                "s3:Put*"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.storage.id}/*",
                "arn:aws:s3:::${aws_s3_bucket.storage.id}"
            ]
        },
        {
            "Sid": "OnlyEncryptedUpload",
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.storage.id}/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "AllowOnlySpecificKMS",
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.storage.id}/*",
            "Condition": {
                "ForAllValues:StringNotEquals": {
                    "s3:x-amz-server-side-encryption-aws-kms-key-id": [
                      "${aws_kms_key.dev-app-tf-state.arn}"
                    ]
                }
            }
        }
    ]
}
EOF
}
