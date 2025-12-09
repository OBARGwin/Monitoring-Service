#!/bin/bash

# ===============================
# Настройки
# ===============================
LOG_FILE="/var/log/fsgi_monitor.log"
BOT_TOKEN="800332****:AAGp9bTz****xUSqXKCYfTDOy6m-*******"
CHAT_ID="102335****"
# ===============================
# Получаем последние 200 строк лога
LOG_CONTENT=$(tail -n 200 "$LOG_FILE")

if [ -n "$LOG_CONTENT" ]; then
    TMP_FILE="/tmp/fsgi_monitor_$(date +%Y-%m-%d_%H-%M).txt"
    echo "$LOG_CONTENT" > "$TMP_FILE"

    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
         -F chat_id="$CHAT_ID" \
         -F document=@"$TMP_FILE" >/dev/null 2>&1

    # Удаляем временный файл
    rm -f "$TMP_FILE"
fi
