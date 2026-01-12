FROM nginx:alpine

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Remove default static files
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter Web build
COPY build/web /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
