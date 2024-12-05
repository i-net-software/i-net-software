#!/bin/bash

# Load environment variables from .env file in the same directory as the script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "Environment file $ENV_FILE not found. Exiting."
    exit 1
fi

# List of IP addresses to check
if [ -z "${IP_ADDRESSES}" ]; then
    echo "No IP Addreesses given"
    exit 1
fi

FAIL_COUNT_THRESHOLD=3
# CHECK_INTERVAL=10  # seconds between checks

HELPDESK_CONTAINER_NAME="i-net-helpdesk"
STRONGSWAN_CONTAINER_NAME="i-net-helpdesk-strongswan-1"

LOG_FILE="/var/log/vpn_check.log"

# Check connectivity to each IP
fail_count=0
for ip in "${IP_ADDRESSES[@]}"; do
    if ! ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
        fail_count=$((fail_count + 1))
    fi
done

# If all fail for multiple checks, restart the container
if [ "$fail_count" -ge "${#IP_ADDRESSES[@]}" ]; then
    if [ ! -f /tmp/vpn_fail_count ]; then
        echo 1 > /tmp/vpn_fail_count
    else
        count=$(< /tmp/vpn_fail_count)
        count=$((count + 1))
        echo "$count" > /tmp/vpn_fail_count
        if [ "$count" -ge "$FAIL_COUNT_THRESHOLD" ]; then
            echo "$(date): Restarting container $STRONGSWAN_CONTAINER_NAME due to failed connections" >> "$LOG_FILE"
            docker restart "$STRONGSWAN_CONTAINER_NAME"
            echo 0 > /tmp/vpn_fail_count
        fi
    fi
else
    echo 0 > /tmp/vpn_fail_count
fi
