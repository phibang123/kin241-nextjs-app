#!/bin/bash

# Build and Push Docker Image for KIN241 Next.js App
# Usage: ./build-and-push.sh [environment] [version]

set -e

# Default values
ENVIRONMENT=${1:-dev}
VERSION=${2:-$(date +%Y%m%d-%H%M%S)}
REGISTRY="kin241registry.azurecr.io"
IMAGE_NAME="kin241-nextjs-app"
FULL_IMAGE_NAME="${REGISTRY}/${IMAGE_NAME}:${VERSION}"
LATEST_TAG="${REGISTRY}/${IMAGE_NAME}:latest"

echo "Building and pushing Next.js app for environment: $ENVIRONMENT"
echo "Version: $VERSION"
echo "Registry: $REGISTRY"
echo "Image: $FULL_IMAGE_NAME"

# Build the Docker image
echo "Building Docker image..."
docker build -t $FULL_IMAGE_NAME -t $LATEST_TAG .

# Login to Azure Container Registry (if needed)
echo "Logging in to Azure Container Registry..."
az acr login --name kin241registry

# Push the image
echo "Pushing image to registry..."
docker push $FULL_IMAGE_NAME
docker push $LATEST_TAG

echo "Successfully built and pushed:"
echo "  - $FULL_IMAGE_NAME"
echo "  - $LATEST_TAG"

# Output for Azure Pipelines
echo "##vso[task.setvariable variable=IMAGE_NAME]$FULL_IMAGE_NAME"
echo "##vso[task.setvariable variable=IMAGE_VERSION]$VERSION"
