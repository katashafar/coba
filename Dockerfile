# Menggunakan Node.js sebagai base image
FROM node:16

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json .
RUN npm install

# Salin semua file ke dalam container
COPY . .

# Build aplikasi untuk production
RUN npm run build

# Gunakan NGINX untuk serve build React
FROM nginx:1.21-alpine
COPY --from=0 /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
