#!/bin/bash

function load_dotfiles {
    echo "Preparing to load dotfiles repo."
    echo "Installing prerequisite xclip..."
    sudo apt-get install -y xclip

    # need to setup ssh-keygen first on machine
    ssh-keygen -f github
    xclip -sel c < $HOME/.ssh/github
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
    fi

    # check for zsh correct installation
    if [[ $(echo $SHELL) != *"zsh"* ]]; then
        echo "Zsh is not your shell. Either install or relogin to continue."
        exit 1
    fi
        
    # oh my zsh install
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # setup symlink for zsh
    ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
    source $HOME/.zshrc
}

function install_nvim {
    if [[ -e "/usr/local/nvim/bin/nvim" ]]; then 
        echo "Nvim already installed exiting..."
	return
    fi
    # nvim install
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    # move app image to bin folder
    sudo mkdir -p /usr/local/nvim/bin
    sudo mv nvim.appimage /usr/local/nvim/bin/nvim

    # setup config file
    ln -s $HOME/dotfiles/nvim $XDG_CONFIG_HOME/nvim
}


# node and node version manager
function install_node {
    # install nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh

    # source zsh
    source $HOME/.zshrc
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
#install_node
#install_rust
install_fd_and_rg
