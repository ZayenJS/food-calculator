FROM node:14.16.1-alpine3.13

WORKDIR /app

COPY package.json /app

RUN npm i

COPY . /app

VOLUME [ "/app/node_modules" ]

RUN npm i -g typeorm

# RUN addgroup -g 1000 dave && useradd -g dave -s /bin/sh dave

USER node

ENTRYPOINT [ "typeorm" ]