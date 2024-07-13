# Use nginx base image
FROM nginx:alpine

# Copy the HTML file into the nginx web server directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Command to start nginx when container starts
CMD ["nginx", "-g", "daemon off;"]
