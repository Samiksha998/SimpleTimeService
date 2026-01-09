


# Local Testing

### Local Testing
```bash
npm install
node app.js
```

Visit `http://localhost:8080`

# Docker
```bash
# Build (tag matches Kubernetes manifest)
docker build -t samikshav/simpletimeservice:v1 .

# Run locally (maps container port 8080 to host 8080)
docker run -p 8080:8080 samikshav/simpletimeservice:v1
```

###Kubernetes (microservice.yml)


#### Manifest Features
- **Resource Limits**: CPU (requests: 100m, limits: 500m) and memory (requests: 128Mi, limits: 512Mi)
- **Liveness Probe**: Restarts unhealthy containers (HTTP GET every 10s after 30s startup delay)
- **Readiness Probe**: Removes pods from service if not ready (HTTP GET every 5s after 10s startup delay)
- **Security Context**: Restricts container privileges and prevents privilege escalation

```bash
# Apply the manifest
kubectl apply -f microservice.yml

# Verify deployment and service
kubectl get deploy simpletimeservice
kubectl get svc simpletimeservice

# If Service type is NodePort, get the assigned nodePort
kubectl get svc simpletimeservice -o jsonpath='{.spec.ports[0].nodePort}'

# Get node IPs (use one of these IPs with the nodePort)
kubectl get nodes -o wide

# Minikube: print a reachable URL
minikube service simpletimeservice --url

# View logs
kubectl logs deployment/simpletimeservice

# Check resource usage
kubectl top pod -l app=simpletimeservice

# To remove
kubectl delete -f microservice.yml
```

### Push image to Docker Hub
```bash
# Log in to Docker Hub
docker login

# Tag (if needed) and push
docker tag samikshav/simpletimeservice:v1 samikshav/simpletimeservice:v1
docker push samikshav/simpletimeservice:v1
```

## Project Structure

- `app.js` - Node.js web application
- `package.json` - Dependencies
- `Dockerfile` - Container configuration
- `.github/workflows/` - CI/CD pipeline

