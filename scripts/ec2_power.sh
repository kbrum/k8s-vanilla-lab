#!/bin/bash

REGION="us-east-1"
PROJECT_TAG="k8s-vanilla-lab"

ACTION=$1
ROLE=$2  # opcional: control-plane ou worker

if [ -z "$ACTION" ]; then
  echo "Uso: $0 {start|stop|status} [role]"
  exit 1
fi

# Monta filtro base
FILTERS="Name=tag:Project,Values=$PROJECT_TAG"

# Se role for passada, adiciona filtro
if [ ! -z "$ROLE" ]; then
  FILTERS="$FILTERS Name=tag:Role,Values=$ROLE"
fi

# Pega instance IDs
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $REGION \
  --filters $FILTERS \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "Nenhuma instância encontrada."
  exit 0
fi

echo "Instâncias encontradas:"
echo "$INSTANCE_IDS"
echo "----------------------"

case "$ACTION" in
  start)
    echo "Iniciando instâncias..."
    aws ec2 start-instances \
      --region $REGION \
      --instance-ids $INSTANCE_IDS
    ;;

  stop)
    echo "Parando instâncias..."
    aws ec2 stop-instances \
      --region $REGION \
      --instance-ids $INSTANCE_IDS
    ;;

  status)
    echo "Status das instâncias:"
    aws ec2 describe-instances \
      --region $REGION \
      --filters $FILTERS \
      --query "Reservations[].Instances[].{ID:InstanceId,State:State.Name,Name:Tags[?Key=='Name']|[0].Value}" \
      --output table
    ;;

  *)
    echo "Ação inválida. Use: start | stop | status"
    exit 1
    ;;
esac
