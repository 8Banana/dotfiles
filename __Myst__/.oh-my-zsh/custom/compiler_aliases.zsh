function run-cpp {
    # Compile a C++17 program file using clang++.
    # You can also pass further arguments and they will be given as well, after
    # the filename and the `-o $1.out` argument.

    if [ -z $1 ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    else
        clang++ -std=c++17 -Ofast -march=native -Wall -Wshadow -Wextra -Weffc++ $1 -o $1.out $@[2,-1] && ./$(basename $1).out
    fi
}
