# syntax=docker/dockerfile:1
FROM node:20 AS builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:20

WORKDIR /app

RUN apt update
RUN apt install -y chromium

COPY package.json package-lock.json ./

RUN npm ci --omit=dev --ignore-scripts

COPY --from=builder /app/dist ./dist

CMD [ "node", "dist/bin/gtfs-to-html.js" ]