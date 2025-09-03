#!/bin/bash

# Deploy Next.js App to Azure Infrastructure
# Usage: ./deploy-to-azure.sh [environment] [version]

set -e

# Default values
ENVIRONMENT=${1:-staging}
VERSION=${2:-$(date +%Y%m%d-%H%M%S)}
REGISTRY="kin241registry.azurecr.io"
IMAGE_NAME="kin241-nextjs-app"
FULL_IMAGE_NAME="${REGISTRY}/${IMAGE_NAME}:${VERSION}"

echo "Deploying Next.js app to Azure environment: $ENVIRONMENT"
echo "Version: $VERSION"
echo "Image: $FULL_IMAGE_NAME"

# Step 1: Build and push Docker image
echo "Step 1: Building and pushing Docker image..."
./build-and-push.sh $ENVIRONMENT $VERSION

# Step 2: Deploy infrastructure with Bicep
echo "Step 2: Deploying infrastructure with Bicep..."
cd ..

# Deploy to staging environment
if [[ "$ENVIRONMENT" == "staging" ]]; then
    echo "Deploying to staging environment..."
    ./main.sh deploy --env staging --sub 15ac0741-7ff8-4002-8f28-bbd2150454b1 --rgp DxF2002Tenant-staging
elif [[ "$ENVIRONMENT" == "prod" ]]; then
    echo "Deploying to production environment..."
    ./main.sh deploy --env prod --sub 15ac0741-7ff8-4002-8f28-bbd2150454b1 --rgp DxF2002Tenant-prod
else
    echo "Deploying to development environment..."
    ./main.sh deploy --env dev --sub 15ac0741-7ff8-4002-8f28-bbd2150454b1 --rgp DxF2002Tenant-dev
fi

echo "Deployment completed successfully!"
echo "Next.js app is now accessible through:"
echo "  - Application Gateway: https://agw-dmz-kinyu-japaneast-${ENVIRONMENT}.japaneast.cloudapp.azure.com"
echo "  - Azure Front Door: https://frontdoor-kinyu-japaneast-002.azurefd.net"
echo "  - Direct App Service: https://app-officialhrpoke-kinyu-japaneast-002.azurewebsites.net (private)"
