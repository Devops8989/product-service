# ---------- Stage 1: Build ----------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency files first (for layer caching)
COPY package*.json ./

# Install all dependencies (dev + prod)
RUN npm ci

# Copy source code
COPY . .

# Build (if you have a build step, else skip)
# RUN npm run build

# ---------- Stage 2: Runtime ----------
FROM node:18-alpine AS runtime

# Set working directory
WORKDIR /app

# Create non-root user
RUN addgroup -S app && adduser -S -G app app

# Copy only necessary files from builder stage
COPY --from=builder /app/node_modules ./node_modules
