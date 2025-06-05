#!/bin/bash

TARGET=$1
TIMEOUT=1

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <IP address>"
  exit 1
fi

echo "Scanning $TARGET for banners on ports 1-65535..."
START_TIME=$(date +%s)

for PORT in {1..65535}; do
  (
    BANNER=$(echo | nc -nv -w $TIMEOUT $TARGET $PORT 2>/dev/null)
    if [ -n "$BANNER" ]; then
      echo "[$PORT] $BANNER"
    fi
  ) &
  
  # Throttle concurrency to 100 background jobs at a time
  if (( PORT % 100 == 0 )); then
    wait
  fi
done

wait

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo "Scan complete in $DURATION seconds."
