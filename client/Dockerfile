FROM node

WORKDIR /app

COPY package.json /app

RUN npm i

COPY . /app

VOLUME [ "/app/node_modules" ]

# RUN addgroup -g 1000 dave && useradd -g dave -s /bin/sh dave

USER node

EXPOSE 8080

CMD ["yarn", "serve"]
