FROM --platform=linux/amd64 node:20-alpine AS builder

WORKDIR /app

COPY frontend/package*.json ./

RUN npm install

COPY frontend/ .

RUN npm run build


FROM --platform=linux/amd64 nginx:1.27-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R appuser:appgroup \
    /var/cache/nginx \
    /var/run \
    /var/log/nginx \
    /usr/share/nginx/html \
    /etc/nginx/conf.d

USER 1001

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]