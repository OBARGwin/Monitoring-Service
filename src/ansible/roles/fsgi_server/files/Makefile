CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS = -lfcgi

TARGET = fastcgi_server
SRC = fastcgi_server.c
PORT = 8080

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

run: $(TARGET)
	spawn-fcgi -p $(PORT) -n ./$(TARGET)

stop:
	@pkill -f ./$(TARGET) || echo "No running $(TARGET) process found"

restart: stop run

clean:
	rm -f $(TARGET)
