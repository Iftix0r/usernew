#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="$SCRIPT_DIR/bot.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "PID fayl topilmadi. Bot ishlamayotgan bo'lishi mumkin."
    exit 1
fi

PID=$(cat "$PID_FILE")

if kill -0 "$PID" 2>/dev/null; then
    kill "$PID"
    sleep 2
    if kill -0 "$PID" 2>/dev/null; then
        kill -9 "$PID"
        echo "Bot majburiy to'xtatildi (PID: $PID)"
    else
        echo "Bot to'xtatildi (PID: $PID)"
    fi
else
    echo "Bot allaqachon to'xtagan (PID: $PID)"
fi

rm -f "$PID_FILE"
