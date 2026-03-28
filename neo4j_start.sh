#!/bin/bash
THREAD_FOLDER=$1
THREAD_WEB=$2
THREAD_SERVER=$3

mkdir -p ~/neo4j/$THREAD_FOLDER/neo4j
cp -r ~/neo4j-template/. ~/neo4j/$THREAD_FOLDER/neo4j/
bash ~/neo4j/$THREAD_FOLDER/neo4j/change_port.sh ~/neo4j/$THREAD_FOLDER/neo4j/conf/neo4j.conf $THREAD_WEB $THREAD_SERVER
nohup ~/neo4j/$THREAD_FOLDER/neo4j/bin/neo4j-admin server console > ~/neo4j/$THREAD_FOLDER/neo4j.log 2>&1 &
echo $! > /tmp/neo4j_$THREAD_WEB.pid
echo "Neo4j starting on bolt port $THREAD_WEB, PID=$(cat /tmp/neo4j_$THREAD_WEB.pid)"
