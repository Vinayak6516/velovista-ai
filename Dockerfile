# Use a lightweight Nginx base
FROM nginx:alpine

# Install the utility needed to substitute environment variables in the config file
# This is necessary for Cloud Run to dynamically set the port.
RUN apk add --no-cache gettext

# Remove default Nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your Nginx config and HTML page
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Expose port is optional but good practice for documentation
EXPOSE 8080

# CRITICAL: Substitute the ${PORT} variable from the environment 
# into the config and start Nginx.
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/nginx.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
