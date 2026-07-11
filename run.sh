#!/bin/bash

set -e

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$DEPLOY_DIR")"

BACKEND_DIR="$ROOT_DIR/kanban-backend"
FRONTEND_DIR="$ROOT_DIR/kanban-frontend"

echo "Deploy directory: $DEPLOY_DIR"
echo "Root directory: $ROOT_DIR"


if [ ! -d "$BACKEND_DIR" ]; then
    echo "Cloning backend..."
    git clone https://github.com/theruderaw/kanban-backend.git "$BACKEND_DIR"
else
    echo "Updating backend..."
    cd "$BACKEND_DIR"
    git pull --ff-only
fi


if [ ! -d "$FRONTEND_DIR" ]; then
    echo "Cloning frontend..."
    git clone https://github.com/theruderaw/kanban-frontend.git "$FRONTEND_DIR"
else
    echo "Updating frontend..."
    cd "$FRONTEND_DIR"
    git pull --ff-only
fi


cd "$DEPLOY_DIR"

echo "Stopping old containers..."
docker compose down


echo "Building and starting..."
docker compose up -d --build


echo "Done."
docker compose ps