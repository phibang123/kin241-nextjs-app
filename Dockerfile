# Use nginx to serve static files
FROM nginx:alpine

# Copy the static files from the build stage
COPY out/ /usr/share/nginx/html/

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
