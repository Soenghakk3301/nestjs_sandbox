# Use the official Node.js 18 image as a base
FROM node:18-alpine

LABEL maintainer="Soenghakk"

# Set the working directory inside the container
WORKDIR /app


# # Copy package.json and yarn.lock (if it exists)
# COPY package.json yarn.lock ./

# # Install project dependencies using Yarn (including --omit=dev for production)
# RUN yarn install --omit=dev

# # Copy the rest of the application source code
# COPY . .

# # Generate Prisma Client (crucial for Prisma)
# RUN yarn prisma generate

# # Build the NestJS application for production
# RUN yarn build

#install nestjs cli
RUN yarn global add @nestjs/cli@10.1.12

RUN yarn global add ts-node typescript

