#!/bin/bash
APP_NAME=sample-api
APP_ENV=$1
#export AWS_PROFILE=$2
if [ ${APP_ENV} = 'dev' ]; then
  CLUSTER_VERSION='v1'
fi
if [ ${APP_ENV} = 'prod' ]; then
  CLUSTER_VERSION='v1'
fi
if [ ${APP_ENV} = 'stg' ]; then
  CLUSTER_VERSION='v1'
fi
CLUSTER_NAME=${APP_NAME}-${APP_ENV}-${CLUSTER_VERSION}
SERVICE_NAME=${APP_NAME}-${APP_ENV}
CONTAINER_NAME=php-fpm
TASK_ID=$(aws ecs list-tasks --cluster ${CLUSTER_NAME} --service-name ${SERVICE_NAME} --query 'taskArns[0]' --output text | cut -d '/' -f 3)
echo $TASK_ID
aws ecs execute-command --cluster ${CLUSTER_NAME} --interactive --command "/bin/bash" --container "${CONTAINER_NAME}" --task ${TASK_ID}


