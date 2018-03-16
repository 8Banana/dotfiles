function show-dot-graph() {
    if [ -z "$1" ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    fi

    dot -T png $1 | feh -
}
