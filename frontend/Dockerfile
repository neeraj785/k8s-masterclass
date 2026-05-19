FROM node:20-slim
WORKDIR /app
RUN npm install express
COPY server.js index.html ./
EXPOSE 3000
CMD ["node","server.js"]