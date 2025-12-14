# Step 1: Use official NGINX base image
FROM nginx:latest

# Step 2: Add custom HTML file to serve
COPY index.html /usr/share/nginx/html/

# Step 3: Expose port 80
EXPOSE 80

# Step 4: Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
