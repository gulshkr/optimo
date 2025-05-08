FROM node:18-alpine AS builder
WORKDIR /app

# 1. Copy package files first for better caching
COPY package*.json ./

# 2. Install dependencies
RUN npm install

# 3. Copy all other files
COPY . .

# 4. Use appropriate env file based on build target
ARG BUILD_ENV=production
COPY .env.${BUILD_ENV} .env.local

# 5. Build the application
RUN npm run build

# Production stage
FROM node:18-alpine
WORKDIR /app

# 6. Copy necessary files from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.env* ./

# 7. Install production dependencies
RUN npm install --only=production

EXPOSE 3000
CMD ["npm", "start"]