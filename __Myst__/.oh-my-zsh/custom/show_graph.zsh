function show-dot-graph() {
    # Given a dot graph filename as an argument, convert it to a PNG and show
    # it using `feh`.

    if [ -z "$1" ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    fi

    dot -T png $1 | feh -
}
