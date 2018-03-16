
function run-cpp {
    if [ -z $1 ]; then
        echo "USAGE: $0 FILENAME"
        return 1
    else
        clang++ -std=c++1z -Ofast -march=native -Wall -Wshadow -Wextra -Weffc++ $1 -o $1.out $@[2,-1] && ./$(basename $1).out
    fi
}

function create-cpp-project {
    if [ -z $1 ]; then
        echo "USAGE: $0 projectname"
        return 1
    else
        mkdir $1 && \
        mkdir $1/{src,obj} && \
        cp ~/Programming/Makefile.cpp.template $1/Makefile
    fi
}
