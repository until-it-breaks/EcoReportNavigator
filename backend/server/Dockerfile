FROM node:lts-alpine3.21
WORKDIR /usr/src/app
COPY package*.json .
RUN npm install --production
COPY . .
EXPOSE 8080
CMD ["node", "app.js"]