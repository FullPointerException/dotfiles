export ZSH=$HOME/.oh-my-zsh

export DOWNLOADS=$HOME/Downloads
export DOCUMENTS=$HOME/Documents

ENABLE_CORRECTION="true"
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Disable auto correct of arguments
unsetopt correct_all

# Add neovim to path
export PATH="$PATH:/opt/nvim-linux64/bin"

# Add work stuff to path
export PATH="$PATH:$HOME/.local/bin/work"

# Add gradle
export GRADLE_HOME="$HOME/.local/bin/gradle"
export PATH="$PATH:$GRADLE_HOME/bin"

# Add kotlin
export KOTLIN_HOME="$HOME/.local/bin/kotlinc"
export PATH="$PATH:$KOTLIN_HOME/bin"

# Add android tools
export ANDROID_HOME="$HOME/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export NDK_VERSION=26.3.11579264
export ANDROID_NDK_ROOT="${ANDROID_HOME}/ndk"
export ANDROID_NDK="${ANDROID_NDK/ROOT}/${NDK_VERSION}"
export PATH="$PATH:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator"

# Add golang support
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"

# Add zig support
export PATH="$PATH:$HOME/zig"

# Setup ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Lazy docker alias
alias lazydocker='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.config/lazydocker lazyteam/lazydocker'

# plantuml alias
alias plantumlserver='docker run -d -p 8080:8080 plantuml/plantuml-server'

# draw.io docker alias
alias drawio='docker run -it --rm --name="draw" -d -p 8081:8080 -p 8443:8443 fjudith/draw.io'

# excalidraw alias
alias excalidraw='docker run --rm -dit --name excalidraw -p 8082:80 excalidraw/excalidraw:latest'

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# Add qml language server
export PATH="$PATH:$HOME/Qt/Tools/QtDesignStudio/qt6_design_studio_reduced_version/bin"

# Add just
export PATH="$PATH:$HOME/.local/bin/just"

alias qt-clang-format="$HOME/Qt/Tools/QtCreator/libexec/qtcreator/clang/bin/clang-format"

# Created by `pipx` on 2024-10-31 18:14:13
export PATH="$PATH:/home/jdurham/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Odin support
export PATH="$PATH:$HOME/repos/site/Odin"

