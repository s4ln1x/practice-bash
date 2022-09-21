#!/usr/bin/env bash

# Space size in GB
MIN_DISK_SPACE=3
# Space in MB
MIN_RAM_SPACE=512
# Get available disk size
AVAIL_DISK_SPACE=$(df -h | grep -i "/$" | cut -d ' ' -f 8)
# Remove extra character G
AVAIL_DISK_SPACE=${AVAIL_DISK_SPACE%G}
# Get available ram space
AVAIL_RAM_SPACE=$(free -h | head -n 2 | tail -n 1 | cut -d " " -f 48)
# Remove extra character Gi and floating part
AVAIL_RAM_SPACE=${AVAIL_RAM_SPACE%.*Gi}

# Convert RAM to MB from GB
AVAIL_RAM_SPACE=$((AVAIL_RAM_SPACE*1024))

# Program logic
if [ "${AVAIL_DISK_SPACE}" -lt "${MIN_DISK_SPACE}" ] &&
  [ "${AVAIL_RAM_SPACE}" -lt "${MIN_RAM_SPACE}" ] ; then
  echo "WARNING: low system resource"
elif [ "${AVAIL_DISK_SPACE}" -lt "${MIN_DISK_SPACE}" ]; then
  echo "WARNING: low disk space available"
elif [ "${AVAIL_RAM_SPACE}" -lt "${MIN_RAM_SPACE}" ]; then
  echo "WARNING: low memory available"
else
  echo "all is good"
fi
