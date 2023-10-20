FROM jitesoft/node-yarn:14
WORKDIR /usr/src/app
# Install app dependencies
COPY package*.json ./
RUN yarn install
COPY . .
EXPOSE 3000
CMD [ "node", "--require", "@opentelemetry/auto-instrumentations-node/register", "app.js"]
