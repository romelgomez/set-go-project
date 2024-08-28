function get_go_tools() {
    echo "..:: Download Latest Go"
    DL_HOME=https://go.dev

    echo "Finding latest version of Go..."

    # Determine the OS and Architecture
    case "$(uname -s)" in
        Linux)
            ARCH="linux-amd64"
            FILE_TYPE=".tar.gz"
            REGEX_URL="/dl/go([0-9\.]+)\.${ARCH}\.tar\.gz"
            GOTOOL_FILE
            ;;
        Darwin)
            if [ "$(uname -m)" = "arm64" ]; then
                ARCH="darwin-arm64"
            else
                ARCH="darwin-amd64"
            fi
            FILE_TYPE=".pkg"
            REGEX_URL="/dl/go([0-9\.]+)\.${ARCH}\.pkg"
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            ARCH="windows-amd64"
            FILE_TYPE=".msi"
            REGEX_URL="/dl/go([0-9\.]+)\.${ARCH}\.msi"
            ;;
        *)
            echo "Unsupported OS"
            exit 1
            ;;
    esac

    echo "ARCH:  $ARCH"
    echo "REGEX_URL:  $REGEX_URL"

    DL_PATH_URL="$(wget --no-check-certificate -qO- https://go.dev/dl/ | grep -Eo "/dl/go[0-9\.]+\.${ARCH}\.pkg" | head -n 1)"

    echo "DL_PATH_URL:  $DL_PATH_URL"

    latest="$(echo $DL_PATH_URL | grep -Eo 'go[0-9\.]+' | grep -Eo '[0-9\.]+' | head -c -2)"

    echo "Downloading latest Go for ${ARCH}: ${latest}"

    wget --no-check-certificate --continue --show-progress "$DL_HOME$DL_PATH_URL" -P $PWD

    unset DL_PATH_URL

    GOTOOL_FILE="$(find $PWD -name "go*$FILE_TYPE" -type f | head -n 1)"

    echo "LATEST: ${GOTOOL_FILE}"

    if [ "$FILE_TYPE" = ".tar.gz" ]; then
        tar -xzvf $GOTOOL_FILE --directory $PWD
    elif [ "$FILE_TYPE" = ".pkg" ]; then
        sudo installer -pkg $GOTOOL_FILE -target /
    elif [ "$FILE_TYPE" = ".msi" ]; then
        msiexec /i $GOTOOL_FILE /quiet /qn /norestart
    fi
}

get_go_tools