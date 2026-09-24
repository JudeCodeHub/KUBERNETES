# Kubernetes Node.js API

A simple Node.js and Express API deployed with Docker and Kubernetes using Minikube.

## Overview

This project demonstrates how to:

- Build a Node.js API with Express
- Run the application inside a Docker container
- Use Docker Compose for local development
- Deploy the application to Kubernetes
- Run multiple application replicas
- Configure Kubernetes health checks
- Expose the application with a NodePort service
- Automate image building and deployment

## Technologies

- Node.js
- Express
- Docker
- Docker Compose
- Kubernetes
- Minikube
- Shell Script

## Project Structure

```text
.
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── Dockerfile
├── docker-compose.yaml
├── deploy.sh
├── index.js
├── package.json
└── package-lock.json
```

## Requirements

Install the following tools before running the project:

- Node.js 18 or later
- npm
- Docker
- Docker Compose
- Minikube
- kubectl
- A Docker Hub account for image deployment

## Installation

Clone the repository:

```bash
git clone https://github.com/JudeCodeHub/KUBERNETES.git
cd KUBERNETES
```

Install the project dependencies:

```bash
npm install
```

## Run Locally with Node.js

Start the application:

```bash
npm start
```

The API will be available at:

```text
http://localhost:3000
```

For development with automatic file watching:

```bash
npm run dev
```

## Run with Docker Compose

Build and start the application:

```bash
docker compose up --build
```

The API will be available at:

```text
http://localhost:3000
```

Stop the application:

```bash
docker compose down
```

## API Endpoints

### `GET /`

Returns a JSON response containing application and container information.

Example response:

```json
{
  "message": "Hello From a Container....welcome to Kubernetes with Node.js",
  "service": "hello-node",
  "pod": "unknown",
  "time": "2026-09-24T00:00:00.000Z"
}
```

### `GET /readyz`

Readiness check used by Kubernetes to confirm that the application is ready to receive traffic.

```text
ready
```

### `GET /healthz`

Liveness check used by Kubernetes to confirm that the application is running.

```text
ok
```

## Build the Docker Image

Build the Docker image locally:

```bash
docker build -t kubernetes-api .
```

Run the container:

```bash
docker run -p 3000:3000 kubernetes-api
```

The application will be available at:

```text
http://localhost:3000
```

## Deploy to Minikube

Start Minikube:

```bash
minikube start
```

Apply the Kubernetes Deployment:

```bash
minikube kubectl -- apply -f k8s/deployment.yaml
```

Apply the Kubernetes Service:

```bash
minikube kubectl -- apply -f k8s/service.yaml
```

Check the deployment:

```bash
minikube kubectl -- get deployments
```

Check the running pods:

```bash
minikube kubectl -- get pods
```

Check the service:

```bash
minikube kubectl -- get services
```

Open the application through Minikube:

```bash
minikube service kubernetes-api-service
```

To display the service URL:

```bash
minikube service kubernetes-api-service --url
```

## Kubernetes Configuration

The Kubernetes Deployment includes:

- Two application replicas
- Container port `3000`
- CPU and memory resource requests
- CPU and memory resource limits
- Readiness probe using `/readyz`
- Liveness probe using `/healthz`
- Automatic pod name injection
- Automatic image updates using `imagePullPolicy: Always`

The Kubernetes Service uses the `NodePort` type, which makes the application accessible through Minikube.

## Automated Deployment

The `deploy.sh` script automates the deployment process.

It performs the following tasks:

1. Creates a timestamp-based Docker image tag
2. Builds the Docker image
3. Pushes the image to Docker Hub
4. Applies the Kubernetes Service
5. Updates the Kubernetes Deployment image
6. Waits for the deployment rollout
7. Displays running pods and services

Before running the script, log in to Docker Hub:

```bash
docker login
```

Run the deployment script:

```bash
sh deploy.sh
```

The script currently uses the Docker Hub image:

```text
jude2001/kubernetes-api
```

Update the following variables in `deploy.sh` if you want to use another Docker Hub account or image name:

```bash
NAME="kubernetes-api"
USERNAME="jude2001"
```

## Useful Kubernetes Commands

View application logs:

```bash
minikube kubectl -- logs deployment/kubernetes-api
```

View detailed deployment information:

```bash
minikube kubectl -- describe deployment kubernetes-api
```

Check rollout status:

```bash
minikube kubectl -- rollout status deployment/kubernetes-api
```

View all Kubernetes resources:

```bash
minikube kubectl -- get all
```

Delete the Kubernetes resources:

```bash
minikube kubectl -- delete -f k8s/
```

Stop Minikube:

```bash
minikube stop
```

Delete the Minikube cluster:

```bash
minikube delete
```

## Environment Variables

The application supports the following environment variables:

| Variable | Default | Description |
|---|---:|---|
| `PORT` | `3000` | Port used by the Node.js application |
| `NODE_ENV` | Not set | Defines the application environment |
| `POD_NAME` | `unknown` | Kubernetes pod name displayed by the API |

## npm Scripts

| Command | Description |
|---|---|
| `npm install` | Installs project dependencies |
| `npm start` | Starts the application |
| `npm run dev` | Starts the application in development mode |
| `npm run deploy` | Runs the deployment script |

## Troubleshooting

### Check whether the application is running

```bash
curl http://localhost:3000/healthz
```

### Check the Kubernetes pods

```bash
minikube kubectl -- get pods
```

### View pod logs

```bash
minikube kubectl -- logs <pod-name>
```

### Check the service URL

```bash
minikube service kubernetes-api-service --url
```

### Check deployment events

```bash
minikube kubectl -- describe deployment kubernetes-api
```
