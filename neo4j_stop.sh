#!/bin/bash
THREAD_WEB=$1
# Kill by PID file
if [ -f /tmp/neo4j_$THREAD_WEB.pid ]; then
    cat /tmp/neo4j_$THREAD_WEB.pid | xargs kill -9 2>/dev/null
    rm -f /tmp/neo4j_$THREAD_WEB.pid
fi
# Kill any process still holding the port (catches Java child processes)
ss -Htnlp "sport = :$THREAD_WEB" 2>/dev/null | grep -oP 'pid=\K[0-9]+' | xargs -r kill -9 2>/dev/null
sleep 1
