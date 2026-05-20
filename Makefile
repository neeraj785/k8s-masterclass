# Define variables to avoid repetition
CLUSTER_NAME=devops-sandbox
CONFIG_FILE=kind-config.yaml

.PHONY: all cluster clean deploy status restart help

# The default action if you just type 'make'
all: help

## cluster   : Create the KinD Kubernetes cluster using the local configuration
cluster:
	@echo "🚀 Creating KinD cluster: $(CLUSTER_NAME)..."
	kind create cluster --config $(CONFIG_FILE) --name $(CLUSTER_NAME)
	@echo "✅ Cluster created successfully!"

## deploy    : Deploy the application manifests into the running cluster
deploy:
	@echo "📦 Deploying application components..."
	kubectl apply -f backend.yaml
	@echo "⏳ Waiting for pods to become ready..."
	kubectl wait --for=condition=ready pod -l app=flask-backend --timeout=60s
	@echo "🎉 Deployment complete! Access your app at http://localhost:8080"

## clean     : Completely destroy the local KinD cluster and clean the workspace
clean:
	@echo "🗑️ Destroying KinD cluster: $(CLUSTER_NAME)..."
	kind delete cluster --name $(CLUSTER_NAME)
	@echo "✨ Workspace cleaned!"

## status    : Check the running status of your cluster components
status:
	@echo "📊 Cluster Nodes:"
	kubectl get nodes
	@echo "\n📋 Cluster Pods:"
	kubectl get pods -o wide
	@echo "\n🔌 Cluster Services:"
	kubectl get services

## restart   : Tear down and completely rebuild the environment in one command
restart: clean cluster deploy

## help      : Show this help menu with descriptions of available commands
help:
	@echo "Available automation commands:"
	@grep -E '^##' $(MAKEFILE_LIST) | sed -e 's/## //'
