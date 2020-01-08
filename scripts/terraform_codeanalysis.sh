#!/bin/bash

echo "We are now trying to format the terraform code"

terraform fmt terraform/dev-app

echo "Exit code the command(dev-app) is " $?

terraform fmt terraform/setup/state-storage-bucket

echo "Exit code the command(state-staorage-bucket) is " $?

echo "No terraform formatting issues found!"

  #add terraform validate
