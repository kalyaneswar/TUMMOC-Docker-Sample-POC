# TUMMOC Docker Sample POC - Expense Tracker

This repository contains the source code and configuration for an expense tracking application composed of three main services:
- **Frontend** (React / Nginx)
- **Backend** (Node.js)
- **Database** (MySQL)

## Project Structure

- `/frontend`: Contains the frontend application code and Dockerfile.
- `/backend`: Contains the backend API application code and Dockerfile.
- `/mysql`: Contains the setup scripts and Dockerfile for the MySQL database.
- `docker-compose.yml`: Deployment composition for running the services locally.
- `Jenkinsfile`: CI/CD pipeline configuration to build and push Docker images to Docker Hub.

## Running Locally

To run the application locally using Docker Compose, execute the following command in the root of the project directory:

```bash
docker-compose up -d
```

This will run:
1. `mysql` container, provisioning the initial `transactions` database.
2. `backend` API service.
3. `frontend` UI service available on port `80`.

To stop the containers:

```bash
docker-compose down
```

## CI/CD with Jenkins

A `Jenkinsfile` is provided to build the Docker images and push them to the Docker Hub registry (`kalyaneswarm`).

### Prerequisites for Jenkins

1. **Docker Installed**: Ensure Docker is installed on the Jenkins agent.
2. **Docker Credentials**: In Jenkins, go to **Manage Jenkins** -> **Credentials** and add a new **Username with password** credential.
   - **Username**: Your Docker Hub username (`kalyaneswarm`).
   - **Password**: Your Docker Hub password or access token.
   - **ID**: `docker-credentials` (This ID is referenced directly in the `Jenkinsfile`).

### Pipeline Stages

1. **Checkout**: Fetches the source code.
2. **Docker Login**: Authenticates with Docker Hub using the configured credentials.
3. **Build & Push MySQL Image**: Builds `kalyaneswarm/mysql:v1.0` and pushes it.
4. **Build & Push Backend Image**: Builds `kalyaneswarm/backend:v1.0` and pushes it.
5. **Build & Push Frontend Image**: Builds `kalyaneswarm/frontend:v1.0` and pushes it.
6. **Logout**: Logs out from Docker Hub.
7. **Cleanup**: Cleans the Jenkins workspace.

## Modifying Docker images in Compose

By default, the `docker-compose.yml` is configured to build the images based on local context. Once you push your images to Docker Hub via Jenkins, you can uncomment the lines in `docker-compose.yml` to use the remote images instead:

```yaml
    # image: kalyaneswarm/mysql:v1.0
    # image: kalyaneswarm/backend:v1.0
    # image: kalyaneswarm/frontend:v1.0
```
