#!/bin/bash

docker-compose -p pubbot up -d
while :
do
  echo "Checking RabbitMQ health status..."
  STATUS=`curl -s -u guest:guest http://localhost:15672/api/healthchecks/node`
  if [ "$STATUS" == "{\"status\":\"ok\"}" ]; then
    break;
  fi
  sleep 5
done

echo "Creating RabbitMQ resources..."
docker exec pubbot_rabbitmq_1 rabbitmqadmin declare queue name=hello.queue durable=false
docker exec pubbot_rabbitmq_1 rabbitmqadmin declare exchange name=event.exchange type=direct
docker exec pubbot_rabbitmq_1 rabbitmqadmin declare queue name=event.queue durable=false
docker exec pubbot_rabbitmq_1 rabbitmqadmin declare binding source=event.exchange destination=event.queue

echo "Pubbot log..."
docker logs -f pubbot_pubbot_1
