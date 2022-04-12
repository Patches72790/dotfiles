# env variables
fish_add_path -gPp /usr/local/go/bin \
                    /usr/local/nvim/bin \
                    $HOME/.local/bin \
                    $HOME/.cargo/bin \
                    /usr/local/bin \
                    $HOME/bin

set -xg GOPATH $HOME/go
set -xg REACT_EDITOR none
set -xg NVM_DIR $XDG_CONFIG_HOME/nvm

# TODO! SETUP conda and NVM somehow

if status is-interactive
    fish_config prompt choose informative_vcs
end

# general abbreviations for editing
abbr nv 'nvim'

# abbreviations (aliases) for git
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbnm 'git branch --n-merged'
abbr gco 'git checkout'
abbr gcb 'git checkout -b'
abbr gcD 'git branch -D'
abbr gcam 'git commit -am'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
abbr gst 'git status'
abbr glog 'git log --oneline --decorate'
abbr glog 'git log --oneline --decorate --graph'

abbr gm 'git merge'
abbr gl 'git pull'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr grb 'git rebase'
abbr gfa 'git fetch --all --prune --jobs=10'
abbr gf 'git fetch'
abbr gr 'git remote'
abbr gsta 'git stash push'
abbr gstp 'git stash pop'
abbr gstl 'git stash list'
abbr gstc 'git stash clear'
abbr gsts 'git stash show --text'

function set_atlas_env
    if test $USER = "PXH050"
        abbr atlas "conda activate atlas-env && nvm use --lts && cd $HOME/Projects/atlas-webapp/app/webapp/app"
        abbr opterrix "conda activate opterrix-env && nvm use --lts && cd $HOME/Projects/opterrix/application/webapp/app"
        abbr opt-direct "conda activate opt-direct && nvm use --lts && cd $HOME/Projects/opterrix-direct/application/webapp/app"
    end
end

set_atlas_env
