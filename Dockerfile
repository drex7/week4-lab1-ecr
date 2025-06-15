# **************************************

# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# # Inject .env at build time (needed for Prisma)
# ARG DATABASE_URL
# ENV DATABASE_URL=$DATABASE_URL

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

# Run Prisma migrations

# Build application
RUN --mount=type=secret,id=db-url-id,env=DATABASE_URL \ 
		yarn build

# Stage 2: Runtime
FROM node:20-alpine AS runner

WORKDIR /app

# Use modules from builder to avoid reinstall
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.output ./.output
COPY --from=builder /app/.nuxt ./.nuxt
COPY --from=builder /app/package.json ./	 
COPY --from=builder /app/prisma ./prisma

EXPOSE 3000

CMD ["yarn", "start"]
