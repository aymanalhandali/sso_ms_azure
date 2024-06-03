#!/bin/bash

# Define variables
BACKEND_DIR=""
DOCKERFILE_PATH="Dockerfile"
IMAGE_NAME="backend-app-image"
CONTAINER_NAME="backend-app-container"

# Check if the Dockerfile exists in the specified subdirectory
if [ ! -f "$DOCKERFILE_PATH" ]; then
  echo "Error: Dockerfile not found in $BACKEND_DIR"
  exit 1
fi

# Navigate to the parent directory
cd "$(dirname "$0")"

# Build the Docker image
echo "Building Docker image..."
docker build -f "$DOCKERFILE_PATH" -t "$IMAGE_NAME" .

# Check if the Docker build was successful
if [ $? -ne 0 ]; then
  echo "Error: Docker image build failed"
  exit 1
fi

# Run the Docker container
echo "Running Docker container..."
docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"

# Check if the Docker container started successfully
if [ $? -ne 0 ]; then
  echo "Error: Failed to run Docker container"
  exit 1
fi

# Print the status of the Docker container
echo "Docker container status:"
docker ps -f "name=$CONTAINER_NAME"

echo "Docker container is running successfully"
