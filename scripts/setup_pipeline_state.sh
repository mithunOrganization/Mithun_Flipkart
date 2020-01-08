#!/bin/sh

export ENVIRONMENT=$1

# As every s3 bucket name in the world is unique we need to make some
# unique extension to this bucket name. So please remove text devops-101
# and put your name at that place.

export MY_UNIQUE_BUCKET=devops-101

aws configure set aws_access_key_id <YOUR-ACCESS_KEY>
aws configure set aws_secret_access_key <YOUR-SECRET-KEY>
aws configure set region eu-west-1
cat ~/.aws/config
cat ~/.aws/credentials


echo "Checking if the Terraform S3 state bucket is available in $1. This might take up to 100 seconds"
echo "Checking for bucket dev-app-tf-state-$ENVIRONMENT-$MY_UNIQUE_BUCKET"
echo "Checking if s3 bucket exists"
aws s3 ls
echo "Above is list of all s3 buckets "
#aws s3api wait bucket-exists --bucket dev-app-tf-state-$ENVIRONMENT || exitCode=$?

exitCode=1000
aws s3 ls s3://dev-app-tf-state-$ENVIRONMENT-$MY_UNIQUE_BUCKET || exitCode=$?
echo "Exit code for checking s3 bucket is "
echo $exitCode
echo "------------------------------------------"
if [[ "$exitCode" = "255" ]]
then
    echo "The Terraform S3 state bucket is unavailable. We will create it"
    cd ${CI_PROJECT_DIR}/terraform/setup/state-storage-bucket
    echo "Terraform initializing"
    terraform init
    TF_LOG=debug terraform plan -var-file=variables_dev.tfvars
    terraform apply -var-file=variables_$ENVIRONMENT.tfvars -auto-approve
else
    echo "S3 bucket is already available"
fi
echo "Step setup state pipeline state has been finished."