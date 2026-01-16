## 1. Basic Web App with Nginx and a Simple HTML Page:
```yaml
version: '3'
services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
```
In this example, you’d have a local html folder with your index.html file that gets served by Nginx.

---

## 2. Multi-Container App with a Web App and a Database (e.g., Flask and PostgreSQL):
```yaml
version: '3'
services:
  web:
    image: flask-app:latest
    build: ./flask-app
    ports:
      - "5000:5000"
    depends_on:
      - db
  db:
    image: postgres:alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```
In this case, you’d have a flask-app directory with your Flask code, and it connects to a PostgreSQL database.

---

## 3. WordPress and MySQL Setup:
```yaml
version: '3.1'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: user
      WORDPRESS_DB_PASSWORD: password
      WORDPRESS_DB_NAME: wordpress

  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: user
      MYSQL_PASSWORD: password
```
This sets up a WordPress site connected to a MySQL database.

---

## 4. Node.js App with MongoDB:
```yaml
version: '3'

services:
  web:
    image: node:14
    working_dir: /app
    volumes:
      - ./node-app:/app
    ports:
      - "3000:3000"
    command: "npm start"
    depends_on:
      - mongo

  mongo:
    image: mongo:latest
    volumes:
      - mongo_data:/data/db

volumes:
  mongo_data:
```
Here, you have a Node.js application that connects to a MongoDB database.

---

## 5. Simplified Example: React Frontend, Java Backend, and MariaDB
```yaml
version: '3.8'

services:
  frontend:
    image: node:14
    working_dir: /app
    volumes:
      - ./frontend:/app
    ports:
      - "3000:3000"
    command: "npm start"

  backend:
    image: openjdk:11
    working_dir: /app
    volumes:
      - ./backend:/app
    ports:
      - "8080:8080"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:mariadb://db:3306/mydb
    depends_on:
      - db

  db:
    image: mariadb:10.5
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydb
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```
### Explanation:

**Frontend (React)**:
- image: Uses the Node.js 14 image to run the React app.
- working_dir: Sets the working directory inside the container to /app.
- volumes: Mounts the local frontend folder to /app in the container.
- ports: Exposes the frontend on localhost:3000.
- command: Runs npm start to launch the React app.

**Backend (Java)**:
- image: Uses the OpenJDK 11 image to run the Java backend.
- working_dir: Sets the working directory to /app.
- volumes: Mounts the local backend folder to /app in the container.
- ports: Exposes the backend on localhost:8080.
- environment: Sets the SPRING_DATASOURCE_URL to connect to the MariaDB database.
- depends_on: Ensures the db service starts before the backend.

**Database (MariaDB)**:

- image: Uses the MariaDB 10.5 image.
- environment: Sets up the root password, database name, user, and user password.
- volumes: Uses db_data to persist the database data.

**Volumes**:

- db_data: A named volume to keep the database data persistent across container restarts.
- This setup gives you a straightforward environment where the React frontend communicates with the Java backend, and the backend connects to the MariaDB database.

---

## 6. More complex example that includes a full-stack application with a React frontend, a Node.js backend, and a PostgreSQL database:
```yaml
version: '3.8'

services:
  frontend:
    image: node:14
    working_dir: /app
    volumes:
      - ./frontend:/app
    ports:
      - "3000:3000"
    command: "npm start"
    depends_on:
      - backend

  backend:
    image: node:14
    working_dir: /app
    volumes:
      - ./backend:/app
    ports:
      - "4000:4000"
    environment:
      - DATABASE_URL=postgres://user:password@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - db_data:/var/lib/postgresql/data

  adminer:
    image: adminer
    ports:
      - "8081:8080"

volumes:
  db_data:
```
### In this setup, you have:
- **Frontend**: A React app running on port 3000.
- **Backend**: A Node.js REST API running on port 4000 and connected to the PostgreSQL database.
- **Database**: A PostgreSQL container with persistent storage.
- **Adminer**: A lightweight database management tool accessible on port 8081 to easily manage your PostgreSQL database.

### Let's break down each section of the Docker Compose file in detail:
**1. Version**
```yaml
version: '3.8'
```
- This specifies the version of the Docker Compose file format. Version 3.8 is widely used and compatible with modern Docker setups.

**2. Services**
- This section defines all the containers that will run as part of this application.

**3. Frontend**
```yaml
frontend:
  image: node:14
  working_dir: /app
  volumes:
    - ./frontend:/app
  ports:
    - "3000:3000"
  command: "npm start"
  depends_on:
    - backend
```
- **image**: Uses the Node.js 14 image to run the frontend.
- **working_dir**: This sets the working directory inside the container to /app. This means that any commands we run will be executed in this directory.
- **volumes**: The line - ./frontend:/app means that the local frontend folder on your machine is mounted to the /app directory inside the container. This allows the container to use the latest code from your local frontend folder.
- **ports**: The mapping "3000:3000" means that port 3000 on your local machine is forwarded to port 3000 inside the container, making the React app accessible via localhost:3000.
- **command**: npm start runs the React application when the container starts.
- **depends_on**: This ensures that the backend service is started before the frontend.

**4. Backend**
```yaml
backend:
  image: node:14
  working_dir: /app
  volumes:
    - ./backend:/app
  ports:
    - "4000:4000"
  environment:
    - DATABASE_URL=postgres://user:password@db:5432/mydb
  depends_on:
    - db
```
- **image**: Again, we’re using the Node.js 14 image, but this time for the backend.
- **working_dir**: Sets the working directory inside the container to /app for the backend code.
- **volumes**: The local backend folder is mounted to the /app directory inside the container, allowing the backend code to be updated live.
- **ports**: The mapping "4000:4000" exposes the backend on port 4000.
- **environment**: The DATABASE_URL environment variable provides the connection string for the PostgreSQL database. This tells the backend how to connect to the db service.
- **depends_on**: This ensures that the db service is started before the backend service.

**5. Database (db)**
```yaml
db:
  image: postgres:13
  environment:
    POSTGRES_USER: user
    POSTGRES_PASSWORD: password
    POSTGRES_DB: mydb
  volumes:
    - db_data:/var/lib/postgresql/data
```
- **image**: Uses the PostgreSQL 13 image for the database.
- **environment**: Sets the database user, password, and database name. These environment variables are used to initialize the database.
- **volumes**: The db_data volume is used to persist the database data. This means that even if the container restarts, the data remains intact.

**6. Adminer**
```yaml
adminer:
  image: adminer
  ports:
    - "8081:8080"
```
- **image**: Uses the Adminer image, which is a lightweight database management tool.
- **ports**: The mapping "8081:8080" makes Adminer accessible on localhost:8081, allowing you to easily manage your PostgreSQL database through a web interface.

**7. Volumes**
```yaml
volumes:
  db_data:
```
- This defines the db_data volume, which is used to persist the database data.

### Summarizing the Full Setup

With all these services together, here's how the architecture works:

- **1.Database (db)**: The PostgreSQL container runs with the specified user, password, and database name. Its data is persisted in the db_data volume, so even if the container restarts, your data remains intact.
- **2. Backend (backend)**: The Node.js backend connects to the PostgreSQL database using the DATABASE_URL environment variable. It’s mounted with the local backend code, so any changes you make locally are reflected inside the container.
- **3. Frontend (frontend)**: The React frontend is also mounted from the local frontend code. It communicates with the backend on port 4000. This setup allows for a seamless development experience, where changes to the frontend or backend code are instantly reflected.
- **4. Adminer (adminer)**: This service provides a web-based interface for managing your PostgreSQL database. You can access it via localhost:8081 and perform database operations easily.

### How to Use This Setup

- **Start the environment**: Run docker-compose up in the directory containing your docker-compose.yml file. This will start all the services in the correct order.
- **Stop the environment**: Run docker-compose down to stop and remove the containers.
- **Development**: Make changes to your code in the local frontend and backend folders, and they will be reflected instantly in the running containers.
