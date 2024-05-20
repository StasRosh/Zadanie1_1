# Etap 1: Budowanie aplikacji
FROM node:alpine AS build

WORKDIR /usr/app

# Skopiowanie plików aplikacji
COPY ./package.json ./
RUN npm install

# Skopiowanie pozostałych plików aplikacji
COPY ./index.js ./

# Zdefiniowanie wersji aplikacji jako argumentu budowania
ARG VERSION
ENV APP_VERSION=test.${BASE_VERSION:-v3}

# Etap 2: Budowanie obrazu końcowego
FROM node:alpine

WORKDIR /usr/app

# Skopiowanie plików z etapu 1
COPY --from=build /usr/app .

# Ustawienie domyślnego portu
EXPOSE 8080

# Uruchomienie aplikacji
CMD ["node", "index.js"]
