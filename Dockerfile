###############################################################################
# 1) BUILD ─ Node 20 + pnpm
###############################################################################
FROM node:20-alpine AS build
WORKDIR /app

# Dependencias base
COPY package*.json pnpm-lock.yaml* ./
RUN npm i -g pnpm && pnpm install --frozen-lockfile

# Código fuente
COPY . .

# ---- Placeholders para New Relic (NO son secretos) ----
ARG VITE_NEW_RELIC_BROWSER_KEY=_NR_KEY_PLACEHOLDER_
ARG VITE_NEW_RELIC_APP_ID=_NR_APPID_PLACEHOLDER_

# Build optimizado (Vite → dist/)
RUN pnpm run build


###############################################################################
# 2) RUNTIME ─ Nginx ultraligero + sustitución de placeholders
###############################################################################
FROM nginx:1.27-alpine

# Herramientas mínimas: bash y sed (gettext para envsubst opcional)
RUN apk add --no-cache bash sed

# Copiamos archivos estáticos compilados
WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .

# Copiamos el entry-point
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
