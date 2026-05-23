#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

stop_process() {
    local name=$1
    local pidfile=$2

    if [ ! -f "$pidfile" ]; then
        echo "$name: PID fayl yo'q"
        return
    fi

    local pid=$(cat "$pidfile")
    if kill -0 "$pid" 2>/dev/null; then
        kill "$pid"
        sleep 2
        kill -0 "$pid" 2>/dev/null && kill -9 "$pid" && echo "$name majburiy to'xtatildi" || echo "$name to'xtatildi (PID: $pid)"
    else
        echo "$name allaqachon to'xtagan"
    fi
    rm -f "$pidfile"
}

stop_process "main.py" "$SCRIPT_DIR/main.pid"
stop_process "bot.py"  "$SCRIPT_DIR/bot.pid"
