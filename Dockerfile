FROM nginx:alpine

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy nginx config template
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Remove default html
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter Web build
COPY build/web /usr/share/nginx/html

# Replace PORT env variable and start nginx
CMD ["sh", "-c", "envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
