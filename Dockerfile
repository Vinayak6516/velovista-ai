# Use an official Nginx image as the base
FROM nginx:alpine

# Remove the default Nginx HTML page
RUN rm /usr/share/nginx/html/index.html

# Copy your custom HTML file into the Nginx web directory
# The 'index.html' file must be in the same folder as the Dockerfile
COPY index.html /usr/share/nginx/html/

# The Nginx image exposes port 80 by default, but we'll include EXPOSE for documentation
EXPOSE 80

# The default command for the Nginx image runs the web server, so we don't need a CMD
# The container will now serve your index.html file on port 80.
