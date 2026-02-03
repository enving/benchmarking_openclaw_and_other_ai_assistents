#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v docker-compose &> /dev/null; then
  echo "Error: docker-compose is not installed."
  exit 1
fi

ARGS="$@"
CONTAINER_SERVICE="my_opencode_setup_client"

if [ -z "$ARGS" ]; then
    echo ">>> Dropping into interactive shell..."
    echo "    Type 'opencode' to see available commands."
    echo "    Type 'exit' to leave."
    docker-compose run --rm $CONTAINER_SERVICE bash
else
    echo ">>> Running command: $ARGS"
    docker-compose run --rm $CONTAINER_SERVICE $ARGS
fi
