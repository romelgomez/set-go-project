function del_go_tools_download() {
    echo "Removing Download if it exists"

    # Determine the OS and Architecture to set the correct file extension
    case "$(uname -s)" in
        Linux)
            FILE_TYPE="*.tar.gz"
            ;;
        Darwin)
            FILE_TYPE="*.pkg"
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            FILE_TYPE="*.msi"
            ;;
        *)
            echo "Unsupported OS"
            exit 1
            ;;
    esac

    # Find and remove the file if it exists
    local file=$(find $PWD -name "$FILE_TYPE" -type f)
    if [ -n "$file" ]; then
        echo "Found file: $file. Removing it..."
        rm -f $file
    else
        echo "No file to remove."
    fi
}

del_go_tools_download