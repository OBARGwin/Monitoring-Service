# ==============================
# Stage 1: Build FastCGI server
# ==============================
FROM debian:bookworm-slim AS builder

# Устанавливаем нужные инструменты для сборки
RUN apt-get update && \
    apt-get install -y \
        gcc \
        make \
        libfcgi-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем исходники
COPY fastcgi_server.c Makefile /app/

# Собираем
RUN make

# ==============================
# Stage 2: Runtime
# ==============================
FROM nginx:1.25.3

# Создаем пользователя
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Устанавливаем минимальные зависимости для запуска
RUN apt-get update && \
    apt-get install -y \
        spawn-fcgi \
        libfcgi0ldbl \
    && rm -rf /var/lib/apt/lists/**

# Рабочая директория
WORKDIR /app

# Копируем собранный бинарник с предыдущего этапа
COPY --from=builder /app/fastcgi_server /app/fastcgi_server

# Копируем конфиг Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Настраиваем кэш Nginx
RUN mkdir -p /var/cache/nginx && \
    chown -R appuser:appgroup /var/cache/nginx /app

# Порты
EXPOSE 8080 81

# Проверка здоровья
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD curl -f http://localhost:8080 || exit 1

# Переключаемся на пользователя
USER appuser

# Команда запуска
CMD sh -c "spawn-fcgi -n -p 8080 ./fastcgi_server & nginx -g 'daemon off;'"