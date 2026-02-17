#!/bin/bash

# ==============================
# Configurable Variables
# ==============================

WORDLIST="/usr/share/wordlists/seclists/Discovery/Web-Content/big.txt"
#EXTENSIONS="php,txt,html,bak"
THREADS=40
MATCH_CODES="200,204,301,302,307,401,403"
OUTPUT_DIR="ffuf_results"

# ==============================
# Safety Checks
# ==============================

if [ ! -f "urls.txt" ]; then
    echo "urls.txt not found."
    exit 1
fi

if ! command -v ffuf &> /dev/null; then
    echo "ffuf is not installed."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# ==============================
# Helper: Sanitize folder name
# ==============================

sanitize() {
    echo "$1" | sed 's|https\?://||' | sed 's|[^a-zA-Z0-9]|_|g'
}

# ==============================
# Main Loop
# ==============================

while read -r url; do
    [ -z "$url" ] && continue

    folder_name=$(sanitize "$url")
    target_dir="$OUTPUT_DIR/$folder_name"

    mkdir -p "$target_dir"

    echo "===================================="
    echo "[*] Running ffuf against $url"
    echo "===================================="

    ffuf -u "$url/FUZZ" \
         -w "$WORDLIST" \
#         -e "$EXTENSIONS" \
         -t "$THREADS" \
         -mc "$MATCH_CODES" \
         -of json \
         -o "$target_dir/results.json"

    echo "[+] Results saved to $target_dir"

done < urls.txt

echo "Batch scan complete."
