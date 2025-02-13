# Use the official Node.js 18 image as a base
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and yarn.lock (if it exists)
COPY package.json yarn.lock ./

# Install project dependencies using Yarn (including --omit=dev for production)
RUN yarn install --omit=dev

# Copy the rest of the application source code
COPY . .

# Generate Prisma Client (crucial for Prisma)
RUN yarn prisma generate

# Build the NestJS application for production
RUN yarn build

# Expose the port your NestJS application listens on
EXPOSE 3000

COPY .env .

# Set the command to start your NestJS application in production
CMD ["node", "dist/main.js"]


# Optional: If you want to run Prisma migrations on container startup (use with caution in production)
# # Create a separate script for migrations
# COPY prisma-migrate.sh /usr/src/app/prisma-migrate.sh
# RUN chmod +x /usr/src/app/prisma-migrate.sh
# CMD ["./prisma-migrate.sh"]  # Replace the standard CMD

# Example prisma-migrate.sh (adjust the DATABASE_URL if needed)
# #!/bin/bash
# npx prisma migrate deploy
# node dist/main.js