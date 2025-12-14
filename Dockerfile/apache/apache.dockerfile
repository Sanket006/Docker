# Use official Apache image
FROM httpd:2.4

# Copy custom website to Apache document root
COPY index.html /usr/local/apache2/htdocs/

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["httpd", "-D", "FOREGROUND"]
