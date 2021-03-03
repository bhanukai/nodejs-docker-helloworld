FROM node:0.10-onbuild

WORKDIR /src

# App
COPY . /src
# Install app dependencies
RUN npm install

EXPOSE 8080

CMD ["npm", "start"]