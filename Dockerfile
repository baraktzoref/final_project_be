FROM node:10-alpine
WORKDIR /usr/src/app
COPY package*.json /app
RUN npm install

COPY . .
EXPOSE 3001
CMD [ "node", "server.js" ]
