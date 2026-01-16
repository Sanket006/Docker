# Docker Compose – Beginner to Hands-on Guide

## 📌 What is Docker Compose?

Docker Compose is a tool that helps you **define, configure, and run multiple Docker containers** using a single YAML file (`docker-compose.yml`). Instead of running many `docker run` commands, you manage everything in **one place**.

---

## 📁 Basic File Structure

```
Docker_Compose/
│── docker-compose.yml
│── Zomato_app/
│    ├── frontend/
│    │   ├── frontend.dockerfile
│    │   └── index.html
│    ├── backend/
│    │    ├── backend.dockerfile
│    │    ├── server.js
│    │    └── package.json
│    └── docker-compose.yaml
└── README.md
```

---

## 🧱 Main Components of docker-compose.yml

### 1️⃣ version

```yaml
version: '3.8'
```

* Defines the Docker Compose file format
* `3.8` is commonly used and stable

---

### 2️⃣ services

```yaml
services:
```

* The **heart of Docker Compose**
* Each service represents **one container**
* Example services: frontend, backend, database

---

## 🔍 Service Sub-Components (Very Important)

### 🔹 image

```yaml
image: node:14
```

* Docker image to use
* Pulled from Docker Hub if not available locally

---

### 🔹 build

```yaml
build: ./backend
```

* Builds an image using a Dockerfile
* Used when you have custom application code

---

### 🔹 container_name

```yaml
container_name: backend-app
```

* Gives a custom name to the container
* Helpful for debugging

---

### 🔹 ports

```yaml
ports:
  - "8080:8080"
```

* Maps **host port → container port**
* Format: `HOST:CONTAINER`

---

### 🔹 volumes

```yaml
volumes:
  - ./backend:/app
```

* Shares files between host and container
* Used for:

  * Live code changes
  * Data persistence

---

### 🔹 environment

```yaml
environment:
  MYSQL_USER: user
  MYSQL_PASSWORD: password
```

* Sets environment variables inside container
* Commonly used for DB credentials and configs

---

### 🔹 env_file

```yaml
env_file:
  - .env
```

* Loads environment variables from a file
* Keeps secrets out of YAML file

---

### 🔹 depends_on

```yaml
depends_on:
  - db
```

* Starts services in the correct order
* Does **not** wait for service to be fully ready

---

### 🔹 restart

```yaml
restart: always
```

* Automatically restarts containers on failure
* Options: `no`, `always`, `on-failure`, `unless-stopped`

---

### 🔹 command

```yaml
command: npm start
```

* Overrides default command of the image

---

## 📦 volumes (Global)

```yaml
volumes:
  db_data:
```

* Named volumes for persistent storage
* Data remains even after containers stop

---

## 🌐 networks (Optional)

```yaml
networks:
  app-network:
```

* Custom network for services
* Improves security and isolation

---

## ▶️ Common Docker Compose Commands

### Start containers

```bash
docker-compose up
```

### Start in background

```bash
docker-compose up -d
```

### Stop containers

```bash
docker-compose down
```

### View running containers

```bash
docker-compose ps
```

### View logs

```bash
docker-compose logs -f
```

---

## 🎯 Why Use Docker Compose?

- ✔ Easy multi-container setup
- ✔ One command to run everything
- ✔ Perfect for development & testing
- ✔ Clean and repeatable environment

---

## 📘 Best Practices

* Use `.env` file for secrets
* Use volumes for databases
* Keep services small and focused
* Use meaningful service names

---

## 🚀 Next Steps

* Add **healthcheck**
* Use **profiles**
* Combine with **CI/CD pipelines**
* Move to **Docker Swarm / Kubernetes**

---

Happy Learning Docker Compose 🐳🔥
