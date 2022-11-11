FROM node:latest

WORKDIR /var/www
COPY . /var/www
RUN npm install && npm install -g serve && npm run build
WORKDIR /var/www/build
ENTRYPOINT [ "serve" ]


