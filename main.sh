#!/bin/bash

set -x

# cd into script directory because this is invoked by systemd
# (this does nothing if calling this from script directory)
SCRIPT_DIR=$(dirname $(realpath $0))
cd $SCRIPT_DIR

URL_FILE=README.md

while true ; do
    OLD_URL=$(cat "$URL_FILE")
    NGROK_URL="$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[].public_url' | sort )"

    if [ -e "$URL_FILE" ]; then
        rm "$URL_FILE" && touch "$URL_FILE"
    else
        touch "$URL_FILE"               
    fi
    
    echo "# Current URL" >> "$URL_FILE"
    echo "\`\`\`" >> "$URL_FILE"
    echo "$NGROK_URL" >> "$URL_FILE"
    echo "\`\`\`" >> "$URL_FILE"

    NEW_URL=$(cat "$URL_FILE")
    
    if [ "$NEW_URL" != "$OLD_URL" ] ; then        
        git add "$URL_FILE"
        git commit -m "updated - $(date)"
        git push       
    fi

    sleep 300
done
