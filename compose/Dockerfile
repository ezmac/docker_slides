FROM node:alpine
CMD node /app/app.js
RUN npm install express mongodb
COPY --chown=node:node app.js /app/
