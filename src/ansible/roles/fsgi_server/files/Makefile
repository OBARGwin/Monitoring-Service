CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS = -lfcgi

TARGET = fastcgi_server
SRC = fastcgi_server.c
PORT = 8080

# Выполняется при дефолтнома щапуске make без опций
all: $(TARGET)

# Компиляция
$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

# Запуск сервера
run: $(TARGET)
	spawn-fcgi -p $(PORT) -n ./$(TARGET)

# Остановка сервера
stop:
	@pkill -f ./$(TARGET) || echo "No running $(TARGET) process found"

# Перезапуск сервера
restart: stop run

clean:
	rm -f $(TARGET)
