#!/bin/bash
set -e

COMPOSE_FILE="docker/docker-compose.yml"

case "$1" in
  start)
    docker compose -f $COMPOSE_FILE up -d
    ;;
  build)
    docker compose -f $COMPOSE_FILE up -d --build
    ;;
  stop)
    docker compose -f $COMPOSE_FILE down
    ;;
  restart)
    docker compose -f $COMPOSE_FILE down
    docker compose -f $COMPOSE_FILE up -d
    ;;
  logs)
    docker compose -f $COMPOSE_FILE logs -f
    ;;
  clean)
    docker compose -f $COMPOSE_FILE down -v
    ;;
  *)
    echo "Usage: ./jenkins.sh {start|build|stop|restart|logs|clean}"
    exit 1
esac