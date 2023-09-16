#!/bin/bash

function load_dotfiles {
    if [[ -d "$HOME/dotfiles" ]]; then
        echo "Dotfiles directory already exists at $HOME/dotfiles"
        return
    fi

    echo "Preparing to load dotfiles repo."
    echo "Installing prerequisite xclip..."
    sudo apt-get install -y xclip

    # need to setup ssh-keygen first on machine
    ssh-keygen -f $HOME/.ssh/github-key
    xclip -sel c < $HOME/.ssh/github-key
    echo "SSH public keygen copied to clipboard"

    # wait until user presses 'y'
    echo "Waiting until you press 'y' to continue..."
    while [[ true ]]; do
        read -n response 
        echo "Responded with $response"
        if [[ $response == "y" ]]; then
            break
        fi
    done

    # download dotfiles repo
    cd $HOME
    git clone git@github.com:Patches72790/dotfiles.git 
    echo "Successfully loaded dotfiles repo."
}

function install_zsh {
    echo "Installing zsh if not already present"

    # first install zsh and set shell
    my_shell=$(echo $SHELL)
    if [[ $my_shell != *"zsh"* ]]; then
        sudo apt install zsh
        sudo chsh -s $(which zsh)
	echo "Please relogin to reset your default shell."
        exit 1
    fi

    # check for zsh correct installation
    if [[ $my_shell != *"zsh"* ]]; then
        echo "Zsh is not your shell. Either install or relogin to continue."
        exit 1
    fi
        
    sh ./zsh/setup.sh
    source $HOME/.zshrc
}

function install_nvim {
    if [[ -e "/usr/local/nvim/bin/nvim" ]]; then 
        echo "Nvim already installed exiting..."
	    return
    fi

    sh nvim/update-nvim.sh
    sh nvim/setup
}


# node and node version manager
function install_node {
    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh
}

# rust
function install_rust {
    # install rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # update rust
    rustup update
}

function install_fd_and_rg {
    sudo apt-get install fd-find ripgrep
    ln -s $(which fd-find) /usr/local/bin/fd
}

# run installers
#load_dotfiles
#install_zsh
#install_nvim
install_node
install_rust
install_fd_and_rg
