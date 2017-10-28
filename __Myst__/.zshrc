# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# GOPATH.
  export GOPATH="$HOME/Programming/GoWorkspace"

# PATHs.
  export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.nvm/versions/node/v5.9.1/bin:$HOME/Documents/kotlinc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
  export PATH="/usr/local/go/bin:$PATH"
  export PATH="$HOME/.cabal/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
  export PATH="$HOME/.cargo/bin:$PATH"

# Oh My ZSH Config.
source $ZSH/oh-my-zsh.sh

# Preferred applications.
# N.B. URxvt looks at a setting in .Xresources for its browser, not at $BROWSER.
export EDITOR='nvim'
export BROWSER='chromium-browser'
export TERMINAL='urxvt'

# Fake being a 256 color xterm, for... reasons.
export TERM=xterm-256color

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias tmux="tmux -2"
alias alert="notify-send -i terminal -t 5 'Alert from Terminal!'"
alias termbin="nc termbin.com 9999"

# Base16 shell colorschemes.
$HOME/Scripts/base16-colorscheme.sh

# Pure Prompt.
# Install with command `npm install --global pure-prompt`.
fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')
autoload -U promptinit; promptinit
prompt pure

# NVM.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
