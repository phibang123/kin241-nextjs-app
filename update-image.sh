#!/bin/bash

# Update Container Image Version
# Usage: ./update-image.sh [environment] [new-version]

set -e

# Default values
ENVIRONMENT=${1:-staging}
NEW_VERSION=${2:-$(date +%Y%m%d-%H%M%S)}

echo "Updating container image version for environment: $ENVIRONMENT"
echo "New version: $NEW_VERSION"

# Build and push new image
echo "Building and pushing new image version..."
./build-and-push.sh $ENVIRONMENT $NEW_VERSION

# Update main.parameters.json with new version
echo "Updating main.parameters.json with new image version..."
cd ..

# Update staging environment
if [[ "$ENVIRONMENT" == "staging" ]]; then
    sed -i '' "s/kin241registry.azurecr.io\/kin241-nextjs-app:latest/kin241registry.azurecr.io\/kin241-nextjs-app:${NEW_VERSION}/g" environments/staging/main.parameters.json
    echo "Updated staging environment with version: ${NEW_VERSION}"
elif [[ "$ENVIRONMENT" == "prod" ]]; then
    sed -i '' "s/kin241registry.azurecr.io\/kin241-nextjs-app:latest/kin241registry.azurecr.io\/kin241-nextjs-app:${NEW_VERSION}/g" environments/prod/main.parameters.json
    echo "Updated production environment with version: ${NEW_VERSION}"
else
    sed -i '' "s/kin241registry.azurecr.io\/kin241-nextjs-app:latest/kin241registry.azurecr.io\/kin241-nextjs-app:${NEW_VERSION}/g" environments/dev/main.parameters.json
    echo "Updated development environment with version: ${NEW_VERSION}"
fi

echo "Container image version updated successfully!"
echo "New version: ${NEW_VERSION}"
echo "You can now deploy the updated infrastructure using:"
echo "  ./main.sh deploy --env ${ENVIRONMENT}"
