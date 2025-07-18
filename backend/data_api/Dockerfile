FROM node:lts-alpine3.22

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --production

COPY . .

RUN npm install -g tsx

EXPOSE 8080

CMD ["tsx", "src/app.ts"]