
FROM node:18-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY app.js .
RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 8080
CMD ["node", "app.js"]

