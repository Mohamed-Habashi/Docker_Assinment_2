FROM node
WORKDIR /app
COPY . /app
RUN npm install express
RUN npm install n-readlines
EXPOSE 5000
CMD ["node", "test.js"]