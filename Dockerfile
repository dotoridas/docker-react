FROM node:alpine as builder

RUN npm config set proxy http://172.16.8.250:3128 

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html