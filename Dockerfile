# **************************************

# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Copy env for Prisma during build
COPY .env .env

COPY package*.json ./
RUN npm install -g yarn && yarn install

COPY . .

# Run Prisma migrations
RUN yarn prisma:generate

# Build application
RUN yarn build

# Stage 2: Runtime
FROM node:20-alpine AS runner

WORKDIR /app

COPY package*.json ./
RUN npm install -g yarn && yarn install --production

COPY --from=builder /app/.output ./.output
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["yarn", "start"]
