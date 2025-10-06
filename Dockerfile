# STEP 1: Use an official Nginx image as the base
FROM nginx:alpine

# 1. Copy the custom Nginx configuration file
# This tells Nginx to listen on the port specified by the $PORT environment variable.
COPY nginx.conf /etc/nginx/nginx.conf

# 2. Remove the default HTML file
RUN rm -rf /usr/share/nginx/html/*

# 3. Copy your custom index.html file into the Nginx web directory
# (Assuming your index.html file is in the same directory as the Dockerfile)
COPY index.html /usr/share/nginx/html/index.html

# 4. Expose is for documentation; Cloud Run determines the external port mapping
EXPOSE 8080

# 5. Define the command to run the web server.
# The 'env' wrapper is crucial: it passes the environment variables (like PORT=8080)
# to Nginx so the server block in nginx.conf can use it.
CMD ["/bin/sh", "-c", "envsubst < /etc/nginx/nginx.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
