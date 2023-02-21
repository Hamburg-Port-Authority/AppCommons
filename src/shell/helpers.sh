function errorEcho {
    echo "${1}" 1>&2
    exit 1
}

function errorUsage {
    echo "${1}" 1>&2
    echo ""
    usage
    exit 1
}

function logVerbose {
    if [ ! -z "$VERBOSE" ]; then
        echo "${1}"
    fi
}

SCRIPT_DIR="$(cd "$(dirname "$0")" ; pwd -P)"
PWD="$(pwd -P)"