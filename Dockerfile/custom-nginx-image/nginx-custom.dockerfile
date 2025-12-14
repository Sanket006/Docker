# Use official NGINX base image
FROM nginx:latest

# Remove default NGINX config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom NGINX config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy custom website files
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Run NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]
