function enviroment() {
    echo "..:: Setting the environment variables for Golang"

    # Determine the OS
    case "$(uname -s)" in
        Linux)
            DEFAULT_GOROOT="$PWD/go"
            ;;
        Darwin)
            DEFAULT_GOROOT="/usr/local/go"
            ;;
        *)
            echo "Unsupported OS"
            exit 1
            ;;
    esac

    # Set GOROOT and GOPATH if they are not set
    if [[ -z "$GOPATH" ]] || [[ -z "$GOROOT" ]]; then
        SETTING_GOROOT="export GOROOT=$DEFAULT_GOROOT"
        SETTING_PATH='export PATH=$PATH:$GOROOT/bin:$GOPATH/bin'

        echo "save in .zshrc file" 
        echo "" >>~/.zshrc
        echo "# [start] Golang settings, remove after change the installation folder." >>~/.zshrc
        [[ -n "$SETTING_GOROOT" ]] && echo $SETTING_GOROOT >>~/.zshrc
        [[ -n "$SETTING_GOPATH" ]] && echo $SETTING_GOPATH >>~/.zshrc
        echo $SETTING_PATH >>~/.zshrc
        echo "# [end]" >>~/.zshrc
        echo "" >>~/.zshrc

        echo "save in .bashrc file" 
        echo "" >>~/.bashrc
        echo "# [start] Golang settings, remove after change the installation folder." >>~/.bashrc
        [[ -n "$SETTING_GOROOT" ]] && echo $SETTING_GOROOT >>~/.bashrc
        [[ -n "$SETTING_GOPATH" ]] && echo $SETTING_GOPATH >>~/.bashrc
        echo $SETTING_PATH >>~/.bashrc
        echo "# [end]" >>~/.bashrc
        echo "" >>~/.bashrc

        echo $SHELL

        SHELL_NAME=$(basename "$SHELL")

        if [ "$SHELL_NAME" = "zsh" ]; then
            echo "source ~/.zshrc"
            # source ~/.zshrc
            exec zsh -c "source ~/.zshrc; zsh"
        elif [ "$SHELL_NAME" = "bash" ]; then
            echo "source ~/.bashrc"
            source ~/.bashrc
        else
            echo "Unknown shell: $SHELL_NAME. Please manually source the appropriate file."
        fi

    else
        echo "Environment variables already set."
    fi
}

enviroment