set -e


NAME="kubernetes-api"
USERNAME="jude2001"

# Generate a unique tag based on the current time
# Example: v20251216-220456
TAG="v$(date +%Y%m%d-%H%M%S)"
FULL_IMAGE="$USERNAME/$NAME:$TAG"

echo "--------------------------------------------------"
echo "🚀 Deploying Version: $TAG"
echo "--------------------------------------------------"

# --- 2. BUILD ---
echo "Building Docker image..."
docker build -t $FULL_IMAGE .

# --- 3. PUSH ---
echo "Pushing image to Docker Hub..."
docker push $FULL_IMAGE

# --- 4. DEPLOY ---
echo "Updating Kubernetes..."
minikube.exe kubectl -- apply -f k8s/service.yaml


echo "Updating deployment with new image..."
sed "s|image: $USERNAME/$NAME:.*|image: $FULL_IMAGE|g" k8s/deployment.yaml | minikube.exe kubectl -- apply -f -


echo "Waiting for rollout to complete..."
minikube.exe kubectl -- rollout status deployment/$NAME

echo "--------------------------------------------------"
echo "Getting pods..."
minikube.exe kubectl -- get pods

echo "Getting services..."
minikube.exe kubectl -- get services

echo "Fetching specific service..."
minikube.exe kubectl -- get services "$NAME-service"