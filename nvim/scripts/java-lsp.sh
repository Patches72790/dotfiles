#!/bin/bash

# NOTE TO MYSELF -- data for jdtls is located in $HOME/.cache/nvim/nvim_lsp/jdtls

# NOTE:
# This doesn't work as is on Windows. You'll need to create an equivalent `.bat` file instead
#
# NOTE:
# If you're not using Linux you'll need to adjust the `-configuration` option
# to point to the `config_mac' or `config_win` folders depending on your system.

# determine linux vs mac machine type
machine=""
unameResult="$(uname)"
case "${unameResult}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
esac

# find java loc in linux vs mac
JAVA_LOCATION=""
CONFIG=""

case "${machine}" in
    Linux*)     JAVA_LOCATION="/usr/lib/jvm/java-16-openjdk-amd64/bin/java" CONFIG="config_linux";;
    Mac*)       JAVA_LOCATION="/Library/Java/JavaVirtualMachines/adoptopenjdk-15.jdk/Contents/home/bin/java" CONFIG="config_mac";;
esac

JAR="$HOME/.cache/nvim/nvim_lsp/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle $JAVA_LOCATION \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.cache/nvim/nvim_lsp/jdtls/$CONFIG" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED 

