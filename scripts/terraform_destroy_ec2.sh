#!/bin/bash
export ENVIRONMENT=$1
export VARIABLES_FILE=${CI_PROJECT_DIR}/terraform/dev-app/backend_$ENVIRONMENT.tfvars
export PATH=$PATH:~
export TF_STATE_KEY=${CI_COMMIT_REF_SLUG}/dev-app-ecs.tfstate

echo "env = \"${ENVIRONMENT}\"" | tee -a ${CI_PROJECT_DIR}/terraform/dev-app/dev-app-${ENVIRONMENT}.tfvars
echo "uuid = \"${UUID}\"" | tee -a ${CI_PROJECT_DIR}/terraform/dev-app/dev-app-${ENVIRONMENT}.tfvars
echo "ssm_prefix = \"${SSM_PREFIX}\"" | tee -a ${CI_PROJECT_DIR}/terraform/dev-app/dev-app-${ENVIRONMENT}.tfvars

echo "DESTROYING to $ENVIRONMENT"

cd ${CI_PROJECT_DIR}/terraform/dev-app

terraform -version
terraform init -backend=true -backend-config=$VARIABLES_FILE -backend-config="key=${TF_STATE_KEY}"
terraform destroy -var-file=${CI_PROJECT_DIR}/terraform/dev-app/dev-app-${ENVIRONMENT}.tfvars -auto-approve
