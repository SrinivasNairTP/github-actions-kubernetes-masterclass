FROM --platform=linux/amd64 nginx:1.27-alpine
# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy only required static files
COPY index.html /usr/share/nginx/html/
COPY css /usr/share/nginx/html/css
COPY js /usr/share/nginx/html/js

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

