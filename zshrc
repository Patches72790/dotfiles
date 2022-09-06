# source any helper files
source $HOME/dotfiles/sh-utils/index
source $HOME/dotfiles/nnn/nnn.conf

# If you come from bash you might have to change your $PATH.
GO_PATH="/usr/local/go/bin"
NVIM_PATH="/usr/local/nvim/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
JAVA_PATH="/usr/local/opt/openjdk@17/bin"
export PATH="$JAVA_PATH:$GO_PATH:$NVIM_PATH:$LOCAL_BIN_PATH:$CARGO_PATH:$HOME/bin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Path to custom plugins folder
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

# plugins folder
plugins=(
    git
    aliases
    rust
    docker
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias gdec="git log --decorate=full --oneline --graph"
alias nvconfig="cd $HOME/dotfiles/nvim && nvim"
alias nv-notes="cd $HOME/Notes && nvim"
export NV_NOTES_PATH="$HOME/Notes"

# for Opterrix mac only!
if [[ "$(whoami)" == "PXH050" ]]; then
    alias atlas="conda activate atlas-env && nvm use --lts && cd $HOME/Projects/atlas-webapp/app/webapp/app"
    alias opterrix="conda activate opterrix-env && nvm use --lts && cd $HOME/Projects/opterrix/webapp/app"
    alias opt-direct="conda activate opt-direct && nvm use --lts && cd $HOME/Projects/opterrix-direct/application/webapp/app"
fi

# Antlr 4 Aliases
alias antlr4='java -jar /usr/local/lib/antlr-4.9.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.9.2-complete.jar:$CLASSPATH"

# neovim variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export LOCAL_PLUGINS_HOME="$HOME/Projects/nvim-plugins/"
export REACT_EDITOR="none"
alias nv="nvim"

# node env variable
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$(whoami)" == "PXH050" ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/PXH050/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/PXH050/miniconda/etc/profile.d/conda.sh" ]; then
 . "/Users/PXH050/miniconda/etc/profile.d/conda.sh"  # commented out by conda initialize  # commented out by conda initialize
        else
            export PATH="/Users/PXH050/miniconda/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
elif [[ "$(whoami)" == "patroclus" ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/patroclus/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/patroclus/miniconda3/etc/profile.d/conda.sh" ]; then
 . "/home/patroclus/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize  # commented out by conda initialize
        else
 export PATH="/home/patroclus/miniconda3/bin:$PATH"  # commented out by conda initialize  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

[ "$(whoami)" = "PXH050" ] && [ -f "/Users/PXH050/.ghcup/env" ] && source "/Users/PXH050/.ghcup/env" # ghcup-env

[ "$(whoami)" = "patroclus" ] && [ -f "/home/patroclus/.ghcup/env" ] && source "/home/patroclus/.ghcup/env" # ghcup-env
