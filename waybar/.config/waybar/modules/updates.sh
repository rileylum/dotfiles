#!/bin/bash

# Check for pacman updates
# Returns JSON for waybar with class for styling

# Retry logic for startup (network may not be ready)
max_retries=3
retry_delay=5

for ((i=1; i<=max_retries; i++)); do
    updates=$(checkupdates 2>/dev/null)
    exit_code=$?

    # checkupdates returns 0 on success, 1 if no updates, 2 on error
    if [[ $exit_code -le 1 ]]; then
        break
    fi

    # Only retry if this isn't the last attempt
    if [[ $i -lt $max_retries ]]; then
        sleep $retry_delay
    fi
done

count=$(echo "$updates" | grep -c '^' 2>/dev/null || echo 0)

# If no updates, output nothing (module will be hidden)
if [[ $count -eq 0 ]] || [[ -z "$updates" ]]; then
    echo '{"text": "", "class": "updated"}'
    exit 0
fi

# Format tooltip with package list (limit to first 10)
tooltip=$(echo "$updates" | head -10)
if [[ $(echo "$updates" | wc -l) -gt 10 ]]; then
    tooltip="$tooltip
...and more"
fi

# Escape quotes for JSON
tooltip=$(echo "$tooltip" | sed 's/"/\\"/g' | tr '\n' '\\' | sed 's/\\/\\n/g' | sed 's/\\n$//')

echo "{\"text\": \"$count\", \"tooltip\": \"$tooltip\", \"class\": \"has-updates\"}"
