# Use official Node.js image based on Debian Bullseye
FROM node:18-bullseye

# Install system dependencies for canvas
RUN apt-get update && apt-get install -y \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    pkg-config \
    build-essential \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage caching
COPY package*.json ./

# Install node modules (including canvas)
RUN npm install

# Copy the rest of the app source code
COPY . .

# Expose the port your app runs on (adjust if needed)
EXPOSE 3000

# Default command to start your app
CMD ["npm", "start"]
