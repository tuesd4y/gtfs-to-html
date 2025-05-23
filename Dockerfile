# syntax=docker/dockerfile:1
FROM node:24

WORKDIR /app

RUN apt update
RUN apt install -y chromium

COPY package.json package-lock.json ./

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

RUN npm ci

COPY . .

RUN npm run build
RUN npm link

ENTRYPOINT [ "/app/dist/bin/gtfs-to-html.js" ]