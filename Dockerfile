# Serve the static site with nginx
FROM nginx:latest

# Copy our page into the nginx web root
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

