#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CONTAINER="my_opencode_setup_client"

echo ">>> Building Docker Environment..."
docker-compose build

echo ">>> Running Internal Setup..."
docker-compose run --rm $CONTAINER /home/agent/scripts/setup.sh

echo ">>> Setup script finished."
echo ">>> Now entering container for manual authentication."
echo ">>> Run 'opencode auth login' inside the container."
docker-compose run --rm $CONTAINER bash
