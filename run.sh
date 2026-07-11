#!/bin/bash

set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

BACKEND_DIR="$BASE_DIR/kanban-backend"
FRONTEND_DIR="$BASE_DIR/kanban-frontend"

BACKEND_REPO="https://github.com/theruderaw/kanban-backend.git"
FRONTEND_REPO="https://github.com/theruderaw/kanban-frontend.git"

echo "=== Updating repositories ==="

if [ ! -d "$BACKEND_DIR" ]; then
    echo "Cloning backend..."
    git clone "$BACKEND_REPO" "$BACKEND_DIR"
else
    echo "Updating backend..."
    cd "$BACKEND_DIR"
    git pull --ff-only
fi

if [ ! -d "$FRONTEND_DIR" ]; then
    echo "Cloning frontend..."
    git clone "$FRONTEND_REPO" "$FRONTEND_DIR"
else
    echo "Updating frontend..."
    cd "$FRONTEND_DIR"
    git pull --ff-only
fi


echo "=== Stopping old containers ==="

cd "$BASE_DIR"

docker compose down


echo "=== Building and starting containers ==="

docker compose up -d --build


echo "=== Deployment complete ==="

docker compose ps