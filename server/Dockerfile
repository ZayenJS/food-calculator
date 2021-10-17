FROM node:latest

WORKDIR /app

COPY package.json /app

RUN npm i

COPY . /app

VOLUME [ "/app/node_modules" ]

# RUN addgroup -g 1000 dave && useradd -g dave -s /bin/sh dave

USER node

EXPOSE 8000

CMD ["npm", "run", "start:dev"]