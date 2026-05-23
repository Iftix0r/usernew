#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_PID="$SCRIPT_DIR/main.pid"
BOT_PID="$SCRIPT_DIR/bot.pid"

cd "$SCRIPT_DIR"

[ -f "venv/bin/activate" ] && source venv/bin/activate

start_process() {
    local script=$1
    local pidfile=$2
    local logfile=$3

    if [ -f "$pidfile" ]; then
        local pid=$(cat "$pidfile")
        if kill -0 "$pid" 2>/dev/null; then
            echo "$script allaqachon ishlamoqda (PID: $pid)"
            return
        fi
    fi

    nohup python -u "$SCRIPT_DIR/$script" >> "$logfile" 2>&1 &
    echo $! > "$pidfile"
    echo "$script ishga tushdi (PID: $(cat $pidfile))"
}

start_process "main.py" "$MAIN_PID" "$SCRIPT_DIR/nohup.log"
start_process "bot.py"  "$BOT_PID"  "$SCRIPT_DIR/bot_nohup.log"
