#!/bin/bash

DEST_DIR="${HOME}/.ssh/keys"
mkdir -p "$DEST_DIR"

op item list --categories sshkey --format json | jq -r '.[] | "\(.id)\t\(.title)"' | while IFS=$'\t' read -r id title; do
    key=$(op item get "$id" --format json | jq -r '.fields[]? | select(.id == "public_key") | .value')
    if [[ -n "$key" && "$key" != "null" ]]; then
        safe_title=$(echo "$title" | tr -cd '[:alnum:]_.-' | tr ' ' '_')
        echo "$key" > "$DEST_DIR/${safe_title}.pub"
        echo "Exported: $safe_title.pub"
    else
        echo "Skipped: $title (no public_key)"
    fi
done
