#!/bin/bash

# ===============================
# Настройки
# ===============================
LOG_FILE="/var/log/fsgi_monitor.log"
STATE_FILE="/var/tmp/fsgi_monitor.pos"  # хранит последнюю позицию
BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
CHAT_ID="YOUR_CHAT_ID_HERE"
# ===============================

# Создаем файл состояния, если его нет
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"

LAST_POS=$(cat "$STATE_FILE")
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# Если новых строк нет, выходим
[ "$TOTAL_LINES" -le "$LAST_POS" ] && exit 0

# Используем pipe вместо временного файла
tail -n $((TOTAL_LINES - LAST_POS)) "$LOG_FILE" | \
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
     -F chat_id="$CHAT_ID" \
     -F document=@"-" \
     -F filename="fsgi_monitor_$(date +%Y-%m-%d_%H-%M).txt" \
     >/dev/null 2>&1

# Обновляем позицию
echo "$TOTAL_LINES" > "$STATE_FILE"
