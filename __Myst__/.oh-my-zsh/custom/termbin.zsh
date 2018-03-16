function termbin {
    # Upload a given filename to termbin.

    if [ $# -ne 1 ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    else
        nc termbin.com 9999 < "$1"
    fi
}

function termbin-stdin {
    # Upload stdin's contents to termbin.

    termbin /dev/stdin
}

function termbin-dir {
    # Upload a directory to termbin by creating a tarball out of it, gzipping
    # it, and finally converting it to base 64.
    # If no argument is passed, defaults to the current directory.
    # Useful if you don't want to use a file-sharing service.

    if [ $# -eq 1 ]; then
        dir="$1"
    else
        dir="."
    fi

    name="$(basename $(realpath $dir))"
    if [ -z "$name" ]; then
        echo "Could not get path of $dir" >&2
        return 1
    else
        # TODO: Warn if final base64 size is greater than termbin size limit.
        tar c ../$name | gzip | base64 -w0 | nc termbin.com 9999
    fi
}
