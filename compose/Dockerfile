FROM node:alpine

RUN npm install express mongodb

CMD node /app/app.js
COPY --chown=node:node app.js /app/
