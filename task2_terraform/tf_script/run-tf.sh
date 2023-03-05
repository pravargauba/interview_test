#!/usr/bin/env bash
set -eo pipefail

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)

GLOBAL_TF_VARS="${REPO_ROOT_DIR}/v2/global/terraform.tfvars"

WORKSPACE="${ENV}"

runCommands() {

    if [[ "${LAYER}" == "global" ]]; then
        WORKSPACE="default" 
    fi    

    if [[ "${1}" == "init" ]]; then
        init
    elif [[ "${1}" == "apply" ]]; then
        apply
    elif [[ "${1}" == "destroy" ]]; then
        destroy
    elif [[ "${1}" == "plan" ]]; then
        plan
    else
        echo "Available commands: init, plan, apply, destroy"
        exit 1
    fi
}

init() {
    echo "*** Initialising remote terraform state" && \
        navigateToLayer && \
        validateAndFormat && \
        terraform init
}

plan() {
    echo "*** Running Terraform Plan ***" && \
        init && \
        validateAndFormat && \
        selectWorkspace && \
        terraform plan -var-file=${GLOBAL_TF_VARS}
}

apply() {
    echo "*** Running Terraform Apply ***" && \
        navigateToLayer && \
        validateAndFormat && \
        selectWorkspace && \
        terraform apply -auto-approve -var-file=${GLOBAL_TF_VARS}
}

destroy() {
    echo "*** Running Terraform Destroy ***" && \
        navigateToLayer && \
        validateAndFormat && \
        selectWorkspace && \
        terraform destroy -force
}

validateAndFormat() {
    terraform validate
    terraform fmt
}

navigateToLayer() {
    cd ${LAYER}
}

selectWorkspace() {
    terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE
}

runCommands "${@}"