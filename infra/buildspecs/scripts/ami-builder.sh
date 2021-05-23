#!/bin/bash

set -o errexit
set -o pipefail

function initialize_environment {
	echo "Getting BASE_AMI"
	export BASE_AMI=$(aws ssm get-parameters \
		--region ap-southeast-2 \
		--name /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 | jq -r .Parameters[].Value)
	if [ ! -z "${BASE_AMI}" ]; then
		echo "Latest AMI ID for amazon-linux-2 is: ${BASE_AMI}"
	else
		echo "Cloud not able to retrieve latest AMI ID from SSM Parameter Store." >&2
		exit 1
	fi

	echo "Pulling secrets from CodeBuild project assumed role to be used by HashiCorp Packer(Ansible)."
	curl -qL 169.254.170.2/${AWS_CONTAINER_CREDENTIALS_RELATIVE_URI} > temp.json
	echo export AWS_REGION=${AWS_REGION} > aws_credential
    echo export AWS_ACCESS_KEY_ID=$(jq -r '.AccessKeyId' temp.json) >> aws_credential
    echo export AWS_SECRET_ACCESS_KEY=$(jq -r '.SecretAccessKey' temp.json) >> aws_credential
    echo export AWS_SESSION_TOKEN=$(jq -r '.Token' temp.json) >> aws_credential
    echo "Validating packer template.json"
    packer validate inputs/packer_template.json

}

function pakcer_build_ami {
	echo "Building AMI for Servian-Tech-Challenge-App"
	./packer build -color=false inputs/packer_template.json | tee build.log
    echo "Checking the new AMI ID..."
    AMI_ID=$(egrep "${AWS_REGION}\:\sami\-" build.log | cut -d' ' -f2)
    # stashing AMI_ID to file so that it can be used in the next pipeline stages.
    echo export AMI_ID="${AMI_ID}" > ami_id
    test ! -z ${AMI_ID} || exit 1
    echo "HashiCorp Packer build for Servian-Tech-Challenge-App completed on $(date), AMI ID is ${AMI_ID}"

}

function main {

	initialize_environment
	pakcer_build_ami

}

main $@