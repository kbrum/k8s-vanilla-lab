#!/bin/bash

set -euo pipefail

REGION="${1:-us-east-1}"
PROJECT_NAME="${2:-k8s-vanilla-lab}"
NODE_FILTER="${3:-all}"

if ! command -v aws >/dev/null 2>&1; then
  echo "Erro: AWS CLI nao encontrada no PATH."
  exit 1
fi

FILTERS=(
  "Name=tag:Project,Values=${PROJECT_NAME}"
  "Name=instance-state-name,Values=pending,running,stopping,stopped"
)

case "${NODE_FILTER}" in
  all)
    ;;
  control-plane)
    FILTERS+=("Name=tag:Node,Values=Control-Plane")
    ;;
  worker)
    FILTERS+=("Name=tag:Node,Values=Worker")
    ;;
  *)
    echo "Uso: $0 [region] [project_name] [all|control-plane|worker]"
    exit 1
    ;;
esac

echo "Regiao: ${REGION}"
echo "Projeto: ${PROJECT_NAME}"
echo "Filtro de node: ${NODE_FILTER}"
echo

aws ec2 describe-instances \
  --region "${REGION}" \
  --filters "${FILTERS[@]}" \
  --query "Reservations[].Instances[].{Name:Tags[?Key=='Name']|[0].Value,Node:Tags[?Key=='Node']|[0].Value,InstanceId:InstanceId,State:State.Name,PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress}" \
  --output table
