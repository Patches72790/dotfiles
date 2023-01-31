# source any helper files
source $HOME/dotfiles/sh-utils/index
source $HOME/dotfiles/nnn/nnn.conf

# If you come from bash you might have to change your $PATH.
GOBIN="/usr/local/go/bin"
export GOBIN=$GOBIN
GOROOT="/usr/local/go"
NVIM_PATH="/usr/local/nvim/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
JAVA_PATH="/usr/local/opt/openjdk@17/bin"
GHC_PATH="$HOME/.ghcup/bin"
export PATH="$GHC_PATH:$JAVA_PATH:$GOBIN:$GOROOT:$NVIM_PATH:$LOCAL_BIN_PATH:$CARGO_PATH:$HOME/bin:/usr/local/bin:$PATH"
export GOPATH="$HOME/go"

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
    zsh-vim-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration
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
alias lsd="ls -halF"
export NV_NOTES_PATH="$HOME/Notes"

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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# set vim keybindings
bindkey -v
export KEYTIMEOUT=1

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# hook into direnv for nix
eval "$(direnv hook zsh)"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# for mac
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; fi
