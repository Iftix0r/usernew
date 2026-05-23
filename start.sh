#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="$SCRIPT_DIR/bot.pid"
LOG_FILE="$SCRIPT_DIR/nohup.log"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        echo "Bot allaqachon ishlamoqda (PID: $PID)"
        exit 1
    fi
fi

cd "$SCRIPT_DIR"

# Virtual env mavjud bo'lsa ishlatish
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
fi

nohup python -u main.py >> "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

echo "Bot ishga tushdi (PID: $(cat $PID_FILE))"
echo "Loglar: $LOG_FILE"
