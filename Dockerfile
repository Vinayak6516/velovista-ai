# STEP 1: Use an official Nginx image as the base
FROM nginx:alpine

# CRITICAL STEP: Install the utility required to substitute the PORT environment variable.
RUN apk add --no-cache gettext

# 1. Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# 2. Remove the default HTML file
RUN rm -rf /usr/share/nginx/html/*

# 3. Copy your custom index.html file into the Nginx web directory
COPY index.html /usr/share/nginx/html/index.html

# 4. Expose is for documentation; Cloud Run determines the external port mapping
EXPOSE 8080

# 5. Define the command to run the web server.
# 'envsubst' substitutes the ${PORT} variable in nginx.conf 
# and redirects the result to a new default config file Nginx will use.
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/nginx.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
