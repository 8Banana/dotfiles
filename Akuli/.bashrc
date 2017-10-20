# i also have the default debian stuff in my real .bashrc, but i didn't
# feel like including it here

PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
alias py=python3.7
alias pip='py -mpip'
alias flake8='py -mflake8'
alias sphinx='rm -rf docs/_build && py -m sphinx docs docs/_build'
alias cov='
	py -m coverage run -m pytest &&
    coverage html &&
    (x-www-browser htmlcov/index.html &>/dev/null &)'

function upload {
    local branch
    local remote

    if [ $# -eq 0 ]; then
        branch=master
    elif [ $# -eq 1 ]; then
        branch=$1
    else
        echo "usage: upload [BRANCH]" >&2
        return 2
    fi

    git push origin $branch && git push --tags origin $branch
}

cat ~/todolist 2>/dev/null


# handy-dandy stuffs
alias a='git add'
alias d='git diff'
alias s='git status'
alias u=upload
alias up='upload && ./publish.py'
function c { git commit -m "$(echo $@)"; }
shopt -s autocd
