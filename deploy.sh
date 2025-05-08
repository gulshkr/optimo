#!/bin/bash

# Configuration
ECR_REGISTRY="470507049399.dkr.ecr.us-east-1.amazonaws.com"
REPO_NAME="test"
AWS_REGION="us-east-1"

# Authenticate with ECR
echo "🔑 Authenticating with ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

# Build and push Frontend
echo "🛠️ Building and pushing Frontend..."
cd feature-extraction-frontend-main
docker build -t $ECR_REGISTRY/$REPO_NAME/frontend:latest .
docker push $ECR_REGISTRY/$REPO_NAME/frontend:latest
cd ..

# Build and push Backend
echo "🛠️ Building and pushing Backend..."
cd feature-extraction-backend-main
docker build -t $ECR_REGISTRY/$REPO_NAME/backend:latest .
docker push $ECR_REGISTRY/$REPO_NAME/backend:latest
cd ..

# Deploy with Docker Compose
echo "🚀 Deploying services..."
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up -d

echo "✅ Deployment complete!"
echo "Frontend: http://localhost:3000"
echo "Backend API: http://localhost:8000"