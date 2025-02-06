# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build
RUN npx prisma generate

# Stage 2: Production
FROM node:18-alpine

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma
COPY --from=builder /app/prisma ./prisma

RUN npx prisma generate

EXPOSE 3000

CMD ["node", "dist/main.js"]
