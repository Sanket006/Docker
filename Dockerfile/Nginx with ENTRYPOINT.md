# Dockerfile – Nginx with ENTRYPOINT

This repository contains a simple **Dockerfile** that runs an **Nginx web server** using `ENTRYPOINT`. The example is designed for beginners to understand how Dockerfile components work together in a real-world scenario.

---

## 📁 Files Used

```
custom
├── Dockerfile
└── nginx.conf
```

* **Dockerfile** – Defines how the Docker image is built
* **nginx.conf** – Custom Nginx configuration file

---

## 🐳 Dockerfile Content

```dockerfile
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]

CMD ["-c", "/etc/nginx/nginx.conf"]
```

---

## 🧩 Explanation (Easy Way)

### 1️⃣ FROM

```dockerfile
FROM nginx:alpine
```

* Uses the official **Nginx Alpine image**
* Lightweight and fast

---

### 2️⃣ COPY

```dockerfile
COPY nginx.conf /etc/nginx/nginx.conf
```

* Copies your custom Nginx configuration into the container
* Replaces the default Nginx config

---

### 3️⃣ EXPOSE

```dockerfile
EXPOSE 80
```

* Informs Docker that the container listens on **port 80**
* Used for HTTP traffic

---

### 4️⃣ ENTRYPOINT

```dockerfile
ENTRYPOINT ["nginx", "-g", "daemon off;"]
```

* Starts Nginx when the container runs
* `daemon off;` keeps Nginx running in the foreground
* This keeps the container alive

---

### 5️⃣ CMD

```dockerfile
CMD ["-c", "/etc/nginx/nginx.conf"]
```

* Provides default arguments to `ENTRYPOINT`
* Can be overridden when running the container

---

## ▶️ How to Build the Image

```bash
docker build -t my-nginx-image .
```

---

## ▶️ How to Run the Container

```bash
docker run -d -p 8080:80 --name my-nginx-container my-nginx-image
```

* Open browser: **[http://localhost:8080](http://localhost:8080)**

---

## 🎯 Key Learning Points

* Difference between **ENTRYPOINT** and **CMD**
* How Nginx runs inside a container
* How to use custom configuration files
* Real-world production-style Dockerfile

---

## ✅ Best Use Case

* Static websites
* Reverse proxy
* Load balancer
* Beginner Docker practice

---

## 📌 Next Practice Ideas

* Add `HEALTHCHECK`
* Add volumes
* Use multi-stage builds
* Combine with Docker Compose

---

Happy Docker Learning 🚀
