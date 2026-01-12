# Use official Nginx image
FROM nginx:alpine

# 1️⃣ Remove default Nginx content first
RUN rm -rf /usr/share/nginx/html/*

# 2️⃣ Copy Flutter Web build files
COPY build/web /usr/share/nginx/html

# 3️⃣ Expose port 80
EXPOSE 80

# 4️⃣ Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
