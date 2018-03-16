function termbin {
    if [ $# -ne 1 ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    else
        nc termbin.com 9999 < "$1"
    fi
}

function termbin-dir {
    if [ $# -eq 1 ]; then
        dir="$1"
    else
        dir="."
    fi
    name="$(basename $(realpath $dir))"
    if [ -z "$name" ]; then
        echo "Could not get path." >&2
        return 1
    else
        tar c ../$name | gzip | base64 -w0 | nc termbin.com 9999
    fi
}
