FROM arm32v7/node
WORKDIR /home/fermin/mongo-rest-api
COPY package*.json ./
RUN npm install --only=production
ARG port=5585
EXPOSE $port
COPY . .
CMD [ "npm", "start"]