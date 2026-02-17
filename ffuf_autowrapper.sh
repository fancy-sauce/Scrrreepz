#!/bin/bash

# Takes input file named urls.txt and runs ffuf against them.

WORDLIST="/usr/share/wordlists/seclists/Discovery/Web-Content/big.txt"
#EXTENSIONS="php,txt,html,bak"
THREADS=40
MATCH_CODES="200,204,301,302,307,401,403"
OUTPUT_DIR="ffuf_results"


if [ ! -f "urls.txt" ]; then
    echo "urls.txt not found."
    exit 1
fi

if ! command -v ffuf &> /dev/null; then
    echo "ffuf is not installed."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"


sanitize() {
    echo "$1" | sed 's|https\?://||' | sed 's|[^a-zA-Z0-9]|_|g'
}


while read -r url; do
    [ -z "$url" ] && continue

    folder_name=$(sanitize "$url")
    target_dir="$OUTPUT_DIR/$folder_name"

    mkdir -p "$target_dir"


    echo "[*] Running ffuf against $url"


    ffuf -u "$url/FUZZ" \
         -w "$WORDLIST" \
#         -e "$EXTENSIONS" \
         -t "$THREADS" \
         -mc "$MATCH_CODES" \
         -of json \
         -o "$target_dir/results.json"

    echo "[+] Results saved to $target_dir"

done < urls.txt

echo "The FFUFING is complete!"
