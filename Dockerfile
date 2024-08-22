# Use an official NGINX image as the base
FROM nginx:alpine

# Copy website files to the NGINX directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
