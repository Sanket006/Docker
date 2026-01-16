# 📚 A Dockerfile typically has a few key components:

## 1. FROM: This specifies the base image to use. It’s the starting point for your container, like `ubuntu`, `node`, `python`, etc.
  
## 2. WORKDIR: This sets the working directory inside the container. All subsequent instructions will run in this directory.
  
## 3. COPY and ADD: These instructions copy files and directories from your host into the container. `COPY` is more straightforward, while `ADD` can handle remote URLs and unpack compressed files.

## 4. RUN: This executes commands inside the container during the build process. It’s often used to install packages or dependencies.

## 5. ENV: This sets environment variables inside the container, which can be useful for configuration.

## 6. EXPOSE: This indicates the ports that the container will listen on at runtime.

## 7. CMD and ENTRYPOINT: These define the default command that runs when the container starts. `CMD` can be overridden, while `ENTRYPOINT` is more fixed.

## 8. VOLUME: This creates a mount point with a specific path and marks it as a volume, allowing data to persist outside the container.

---

# 1. Node.js Web Application
```dockerfile
# Use the official Node.js image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
```
---

# 2. Python Flask API
```dockerfile
# Use the official Python image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app
CMD ["flask", "run", "--host=0.0.0.0"]
```

---

# 3. Java Spring Boot Application
```dockerfile
# Use the official OpenJDK image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file into the container
COPY target/myapp.jar /app/myapp.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
CMD ["java", "-jar", "/app/myapp.jar"]
```

---

# 4. Nginx Web Server
```dockerfile
# Use the official Nginx image
FROM nginx:alpine

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy website files
COPY html/ /usr/share/nginx/html/

# Expose the port
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
```

---

# 5. Redis Database
```dockerfile
# Use the official Redis image
FROM redis:latest

# Expose the default Redis port
EXPOSE 6379

# Command to run Redis server
CMD ["redis-server"]
```

---

# 6. Python Django Application
```dockerfile
# Use the official Python image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django application code
COPY . .

# Expose the port Django runs on
EXPOSE 8000

# Command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

---

# 7. Java Maven Application
```dockerfile
# Use the official Maven image to build the app
FROM maven:3.8.6-openjdk-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml ./
COPY src /app/src

# Package the application
RUN mvn clean package

# Use a smaller base image to run the app
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the packaged JAR file from the builder
COPY --from=builder /app/target/myapp.jar /app/myapp.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
CMD ["java", "-jar", "/app/myapp.jar"]
```

---

# 8. MySQL Database
```dockerfile
# Use the official MySQL image
FROM mysql:8.0

# Set environment variables for MySQL root password and database name
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=mydatabase

# Expose the default MySQL port
EXPOSE 3306

# Command to run MySQL server
CMD ["mysqld"]


9. Golang Web Application
# Use the official Golang image
FROM golang:1.20

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod tidy

# Copy the rest of the application code
COPY . .

# Build the Go app
RUN go build -o myapp .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app
CMD ["./myapp"]
```

---

# 10. Ruby on Rails Application
```dockerfile
# Use the official Ruby image
FROM ruby:3.1

# Install dependencies for Rails
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the Rails application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
```

---

# 11. PHP and Apache
```dockerfile
# Use the official PHP image with Apache
FROM php:8.1-apache

# Copy the application code to the Apache document root
COPY src/ /var/www/html/

# Expose the default Apache port
EXPOSE 80

# The Apache server will run in the foreground by default
CMD ["apache2-foreground"]
```
OR
```dockerfile
# Use the official PHP image with Apache
FROM php:8.1-apache

# Set working directory (Apache document root)
WORKDIR /var/www/html

# Copy PHP application source code to Apache document root
COPY src/ .

# Expose Apache HTTP port
EXPOSE 80

# Start Apache in foreground (default behavior)
CMD ["apache2-foreground"]

```

---

# 12. Elasticsearch
```dockerfile
# Expose the default Elasticsearch port
EXPOSE 9200 9300

# Set environment variables for Elasticsearch
ENV discovery.type=single-node

# Command to run Elasticsearch
CMD ["elasticsearch"]
```

---

# 13. MongoDB Database
```dockerfile
# Use the official MongoDB image
FROM mongo:5.0

# Expose the default MongoDB port
EXPOSE 27017

# Command to run MongoDB
CMD ["mongod"]
```

---

# 14. Redis with Custom Configuration
```dockerfile  
# Use the official Redis image
FROM redis:latest

# Copy custom Redis configuration file
COPY redis.conf /usr/local/etc/redis/redis.conf

# Expose the default Redis port
EXPOSE 6379

# Command to run Redis with the custom configuration
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
```

# 15. Python FastAPI Application
```dockerfile
# Use the official Python image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI application code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to run the FastAPI app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

# 16. Apache HTTP server
```dockerfile
# 1. FROM – Base image with Apache installed
FROM httpd:2.4

# 2. LABEL – Metadata (optional but good practice)
LABEL maintainer="devops@example.com"
LABEL description="Apache Web Server Docker Image"

# 3. WORKDIR – Set working directory
WORKDIR /usr/local/apache2/htdocs/

# 4. COPY – Copy website files to Apache document root
COPY html/ .

# 5. EXPOSE – Apache listens on port 80
EXPOSE 80

# 6. CMD – Start Apache in foreground
CMD ["httpd", "-D", "FOREGROUND"]
```

---

# 17. A simple Python Flask application for this example.
```dockerfile
# 1. FROM: Use the official Python image as the base
FROM python:3.9-slim

# 2. WORKDIR: Set the working directory inside the container
WORKDIR /app

# 3. COPY: Copy the requirements file and the application code into the container
COPY requirements.txt ./
COPY . .

# 4. RUN: Install the dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 5. ENV: Set an environment variable
ENV FLASK_ENV=production

# 6. EXPOSE: Expose the port the Flask app will run on
EXPOSE 5000

# 7. VOLUME: Create a volume for persistent data (if needed)
VOLUME ["/app/data"]

# 8. CMD: Define the default command to run the Flask app
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
```
In this example, we’ve covered all the key components: FROM, WORKDIR, COPY, RUN, ENV, EXPOSE, VOLUME, and CMD.

---

# 18. An example of a Dockerfile using the official Nginx image with an ENTRYPOINT:
```dockerfile
# 1. FROM: Use the official Nginx image as the base
FROM nginx:alpine

# 2. COPY: Copy custom Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# 3. EXPOSE: Expose the default Nginx port
EXPOSE 80

# 4. ENTRYPOINT: Set the entry point for the container
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# 5. CMD: Optionally, you can provide default arguments (though ENTRYPOINT takes precedence)
CMD ["-c", "/etc/nginx/nginx.conf"]
```
In this example, the ENTRYPOINT is set to run Nginx in the foreground, which means the container will keep running as long as Nginx is active.
