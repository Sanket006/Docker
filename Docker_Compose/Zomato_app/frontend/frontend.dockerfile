# Use nginx base image
FROM nginx:alpine

# Copy frontend code to nginx default html folder
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
