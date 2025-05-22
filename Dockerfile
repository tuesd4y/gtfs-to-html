# syntax=docker/dockerfile:1
FROM node:20

WORKDIR /app

RUN apt update
RUN apt install -y chromium

COPY package.json package-lock.json ./

COPY . .

RUN npm ci

ENTRYPOINT [ "gtfs-to-html" ]