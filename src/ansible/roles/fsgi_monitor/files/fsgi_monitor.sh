#!/bin/bash

SERVICE_NAME="server"   # systemd unit сервиса
URL="http://localhost:81"
LOG_FILE="/var/log/fsgi_monitor.log"
INTERVAL=30

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

while true; do
    if curl -s --head --request GET "$URL" | grep "200 OK" > /dev/null; then
        log "OK - The application is available"
    else
        log "ERROR - The application is not available, trying to restart service..."
        # Перезапускаем systemd сервис
        systemctl restart "$SERVICE_NAME"
        log "Service $SERVICE_NAME restarted"
    fi
    sleep "$INTERVAL"
done