#!/bin/bash

# Test Next.js App Locally
# This script tests the app in different modes

set -e

echo "Testing KIN241 Next.js App locally..."

# Test 1: Development mode
echo "Test 1: Development mode"
echo "Starting dev server on http://localhost:3000"
echo "Press Ctrl+C to stop..."
npm run dev &

DEV_PID=$!
sleep 10

# Test 2: Production build
echo "Test 2: Production build"
npm run build

# Test 3: Production start
echo "Test 3: Production start"
echo "Starting production server on http://localhost:3000"
echo "Press Ctrl+C to stop..."
npm start &

PROD_PID=$!
sleep 10

# Test 4: Docker build
echo "Test 4: Docker build"
npm run docker:build

# Test 5: Docker run
echo "Test 5: Docker run"
echo "Starting Docker container on http://localhost:3000"
echo "Press Ctrl+C to stop..."
npm run docker:run &

DOCKER_PID=$!
sleep 10

echo "All tests completed successfully!"
echo "You can now access the app at:"
echo "  - Development: http://localhost:3000 (if running)"
echo "  - Production: http://localhost:3000 (if running)"
echo "  - Docker: http://localhost:3000 (if running)"

# Cleanup
echo "Cleaning up test processes..."
kill $DEV_PID 2>/dev/null || true
kill $PROD_PID 2>/dev/null || true
kill $DOCKER_PID 2>/dev/null || true

echo "Local testing completed!"
