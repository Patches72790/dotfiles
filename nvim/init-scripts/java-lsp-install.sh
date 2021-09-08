#!/bin/bash

JDT_CONFIG_HOME="$HOME/.cache/nvim/nvim_lsp/jdtls"
JDT_LS_FILE="jdt-language-server-latest.tar.gz"

mkdir -p $JDT_CONFIG_HOME
cd $JDT_CONFIG_HOME

if [[ -f "$JDT_LS_FILE" ]]; then
    echo "JDT Language server already exists."
    exit 2
fi

# download latest jdt language server
curl -fO https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz

if [[ $? -eq 0 ]]; then
    tar xvzf jdt-language-server-latest.tar.gz
    echo "JDT Language server successfully installed."
else
    exit 1
fi
