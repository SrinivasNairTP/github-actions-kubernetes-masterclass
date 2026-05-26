FROM --platform=linux/amd64 nginx:1.27-alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy frontend static files
COPY index.html /usr/share/nginx/html/
COPY css /usr/share/nginx/html/css
COPY js /usr/share/nginx/html/js

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create required nginx directories and set permissions
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R appuser:appgroup \
    /var/cache/nginx \
    /var/run \
    /var/log/nginx \
    /usr/share/nginx/html \
    /etc/nginx/conf.d

# Switch to non-root user
USER 1001

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]