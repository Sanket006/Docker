# Dockerfile – Complete Guide with All Key Components

This README explains **all important Dockerfile components** with a **single real-world example**. It is written in an easy way so you can remember the components and confidently write Dockerfiles during interviews and hands-on practice.

---

## 🧩 Key Dockerfile Components (Quick List)

1. FROM
2. LABEL
3. ARG
4. WORKDIR
5. COPY
6. ADD
7. RUN
8. ENV
9. USER
10. EXPOSE
11. VOLUME
12. HEALTHCHECK
13. ENTRYPOINT
14. CMD

---

## 📁 Folder Structure

```
Dockerfile
├── apache-image/
│   ├── apache.dockerfile
│   └── index.html
├── custom-nginx-image/
│   ├── index.html
│   ├── custom-nginx.dockerfile
│   └── nginx.conf
├── nginx-image/
│   ├── index.html
│   └── nginx.dockerfile
└── README.md
```

---

## 🐳 Complete Dockerfile Example (All Components Used)

```dockerfile
# 1. FROM – Base image
FROM nginx:alpine

# 2. LABEL – Metadata
LABEL maintainer="devops@example.com" \
      project="Dockerfile Practice"

# 3. ARG – Build-time variable
ARG APP_VERSION=1.0

# 4. ENV – Runtime environment variable
ENV APP_ENV=production \
    APP_VERSION=${APP_VERSION}

# 5. WORKDIR – Working directory
WORKDIR /usr/share/nginx/html

# 6. COPY – Copy local files
COPY html/ ./

# 7. ADD – Add files (can extract archives or download URLs)
ADD https://example.com /tmp/example.html

# 8. RUN – Execute commands during build
RUN apk add --no-cache curl \
    && echo "Build completed"

# 9. USER – Run container as non-root (security best practice)
USER nginx

# 10. EXPOSE – Application port
EXPOSE 80

# 11. VOLUME – Persistent storage
VOLUME ["/var/cache/nginx"]

# 12. HEALTHCHECK – Check container health
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost || exit 1

# 13. ENTRYPOINT – Main process
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# 14. CMD – Default arguments
CMD ["-c", "/etc/nginx/nginx.conf"]
```

---

## 🧠 Easy Explanation (Remember This Flow)

### 🔹 FROM

Base image – starting point of the container.

### 🔹 LABEL

Adds metadata (author, version, description).

### 🔹 ARG

Used **only during build time**.

### 🔹 ENV

Used **while the container is running**.

### 🔹 WORKDIR

Sets the default directory inside the container.

### 🔹 COPY / ADD

Moves files into the container.

* COPY → simple file copy
* ADD → extra features (URL, extract archives)

### 🔹 RUN

Runs commands during image build.

### 🔹 USER

Improves security by avoiding root user.

### 🔹 EXPOSE

Documents the port used by the app.

### 🔹 VOLUME

Stores data outside the container lifecycle.

### 🔹 HEALTHCHECK

Docker checks if container is healthy.

### 🔹 ENTRYPOINT

Main command (cannot be easily overridden).

### 🔹 CMD

Default arguments (can be overridden).

---

## ▶️ Build the Image

```bash
docker build -t nginx-full-example .
```

---

## ▶️ Run the Container

```bash
docker run -d -p 8080:80 --name nginx-demo nginx-full-example
```

Open browser:

```
http://localhost:8080
```

---

## 🎯 Interview Tip (Very Important)

> **ENTRYPOINT + CMD together = Production-style Dockerfile**

---

## 🚀 Practice Tasks

1. Remove `CMD` and observe behavior
2. Change `ARG` value during build
3. Add another `HEALTHCHECK`
4. Convert this into Docker Compose

---

## 🧩 Easy Memory Trick (Interview Friendly)

Remember Dockerfile in this order:

**FROM → META → CONFIG → COPY → BUILD → SECURE → NETWORK → RUN**

* FROM (Base)
* LABEL / ARG / ENV (Metadata & config)
* WORKDIR (Context)
* COPY / ADD (Code)
* RUN (Build)
* USER (Security)
* EXPOSE / VOLUME / HEALTHCHECK (Runtime)
* ENTRYPOINT / CMD (Execution)

If you can explain this flow, you can write **any Dockerfile**.

---

# Dockerfile – Nginx with ENTRYPOINT

This repository contains a simple **Dockerfile** that runs an **Nginx web server** using `ENTRYPOINT`. The example is designed for beginners to understand how Dockerfile components work together in a real-world scenario.

---

## 📁 Files Used

```
.
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
