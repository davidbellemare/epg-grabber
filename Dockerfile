# Use general node image as builder and install dependencies
FROM node:19 AS build-env
WORKDIR /app
COPY package*.json ./
COPY src/ ./src
COPY bin/ ./bin
COPY sites/ ./sites
RUN npm ci


# # Copy application with its dependencies into distroless image
FROM gcr.io/distroless/nodejs:debug
COPY --from=build-env /app /app
WORKDIR /app
CMD ["bin/epg-grabber.js"]