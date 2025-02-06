# Use the official Node.js image as a base
FROM node:16 AS build

# Set the working directory
WORKDIR /public

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Use NGINX to serve the app
FROM nginx:alpine

# Copy built files from the previous stage
COPY --from=build /public/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
