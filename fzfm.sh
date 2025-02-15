#!/usr/bin/env bash

# Configuration variables with defaults
MEDIA_OPENER="wslview"
TEXT_EDITOR="nvim"
LIST_COMMAND="eza"
PREVIEW_COMMAND="batcat"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check and set up dependencies
setup_dependencies() {
    # Check for fzf as it's required
    if ! command_exists "fzf"; then
        echo "Error: fzf is required but not installed"
        exit 1
    fi

    # Check and set list command (eza or ls)
    if ! command_exists "$LIST_COMMAND"; then
        echo "Warning: $LIST_COMMAND not found, falling back to ls"
        LIST_COMMAND="ls"
        LIST_ARGS="-1A --color=always"  # ls arguments
    else
        LIST_ARGS="-1a --icons --color=always"  # eza arguments
    fi

    # Check and set preview command
    if ! command_exists "$PREVIEW_COMMAND"; then
        echo "Warning: $PREVIEW_COMMAND not found, falling back to cat"
        PREVIEW_COMMAND="cat"
    fi

    # Check and set text editor
    if ! command_exists "$TEXT_EDITOR"; then
        echo "Warning: $TEXT_EDITOR not found, falling back to nano"
        command_exists "nano" && TEXT_EDITOR="nano" || {
            echo "Error: No suitable text editor found"
            exit 1
        }
    fi

    # Check and set media opener
    if ! command_exists "$MEDIA_OPENER"; then
        if command_exists "xdg-open"; then
            echo "Warning: $MEDIA_OPENER not found, falling back to xdg-open"
            MEDIA_OPENER="xdg-open"
        elif command_exists "open"; then
            echo "Warning: $MEDIA_OPENER not found, falling back to open"
            MEDIA_OPENER="open"
        else
            echo "Warning: No suitable media opener found, multimedia files won't be opened"
            MEDIA_OPENER=""
        fi
    fi
}

# Check and open file based on mime type
open_file() {
    local file="$1"
    local mime_type=$(file --mime-type -b "$file")
   
    case "$mime_type" in
        text/*|application/json|application/xml|application/javascript|application/x-shellscript)
            $TEXT_EDITOR "$file"
            clear
            ;;
        image/*|video/*|audio/*|application/pdf)
            if [[ -n "$MEDIA_OPENER" ]]; then
                $MEDIA_OPENER "$file" &>/dev/null &
            else
                echo "No media opener available. Cannot open $file"
                read -n 1 -s -r -p "Press any key to continue..."
                clear
            fi
            ;;
        *)
            if [ -B "$file" ]; then
                $TEXT_EDITOR "$file"
                clear
            else
                if [[ -n "$MEDIA_OPENER" ]]; then
                    $MEDIA_OPENER "$file" &>/dev/null || {
                        $TEXT_EDITOR "$file"
                        clear
                    }
                else
                    $TEXT_EDITOR "$file"
                    clear
                fi
            fi
            ;;
    esac
}

# Main function
fzfm() {
    setup_dependencies

    local list_command="$LIST_COMMAND $LIST_ARGS"

    while true; do
        selection=$( (echo ".."; eval "$list_command") | fzf \
            --ansi \
            --reverse \
            --height 100% \
            --info right \
            --prompt "󰥨 Search: " \
            --pointer ">" \
            --marker "󰄲" \
            --border "rounded" \
            --border-label=" 󱉟 $(pwd)/ " \
            --border-label-pos center \
            --color 'fg:#cdd6f4,fg+:#cdd6f4,bg+:#313244,border:#a5aac3,pointer:#cba6f7' \
            --bind "right:accept" \
            --bind "enter:accept" \
            --bind "shift-up:preview-up" \
            --bind "shift-down:preview-down" \
            --bind "ctrl-r:reload($list_command)" \
            --preview-window="right:65%" \
            --preview "
                file={}
                if [[ \"\$file\" == \"..\" ]]; then
                    echo \"󰌌 Move up to parent directory\"
                elif [[ -d \"\$file\" ]]; then
                    echo \"󰉋 Folder: \$file\"
                    echo \"\"
                    $list_command \"\$file\" 2>/dev/null
                elif [[ -f \"\$file\" ]]; then
                    echo \"󰈙 File: \$file\"
                    echo \"\"
                    $PREVIEW_COMMAND --style=numbers --color=always --line-range :500 \"\$file\" 2>/dev/null || cat \"\$file\"
                else
                    echo \"Invalid selection: \$file\"
                fi
            ")

        [[ -z "$selection" ]] && break

        if [[ "$selection" == ".." ]]; then
            cd .. || break
        elif [[ -d "$selection" ]]; then
            cd "$selection" || break
        elif [[ -f "$selection" ]]; then
            open_file "$selection"
        else
            break
        fi
    done
}

# Allow configuration through environment variables
[[ -n "$FZFM_MEDIA_OPENER" ]] && MEDIA_OPENER="$FZFM_MEDIA_OPENER"
[[ -n "$FZFM_TEXT_EDITOR" ]] && TEXT_EDITOR="$FZFM_TEXT_EDITOR"
[[ -n "$FZFM_LIST_COMMAND" ]] && LIST_COMMAND="$FZFM_LIST_COMMAND"
[[ -n "$FZFM_PREVIEW_COMMAND" ]] && PREVIEW_COMMAND="$FZFM_PREVIEW_COMMAND"

clear
fzfm