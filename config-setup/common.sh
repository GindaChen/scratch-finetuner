export LANG=en_US.UTF-8

alias tcc="tmux has-session 2>/dev/null && tmux -CC attach || tmux -CC"

function git_add_and_push() {
    local file="$1"
    local commit_message="$2"
    git lfs track "$file"
    git add "$file"
    git commit -m "$commit_message"
    git push
}

# Relative paths to activate environments
# example: HERE_ACTIVATE_PATH="./env"
HERE_ACTIVATE_PATH=""

function hereactivate() {
    local default_paths=("./env" "./.env" "./venv" "./.venv")
    local custom_paths=()

    if [[ -n "${HERE_ACTIVATE_PATH}" ]]; then
        IFS=':' read -ra custom_paths <<< "${HERE_ACTIVATE_PATH}"
    fi

    for path in "${custom_paths[@]}" "${default_paths[@]}"; do
        if [[ -d "${path}" ]]; then
            if command -v mamba &> /dev/null; then
                mamba activate "${path}"
            elif command -v conda &> /dev/null; then
                conda activate "${path}"
            elif [[ -f "${path}/bin/activate" ]]; then
                source "${path}/bin/activate"
            else
                echo "Error: Unable to activate environment at ${path}"
                return 1
            fi
            return 0
        fi
    done

    echo "Error: No valid environment found"
    return 1
}
alias lmodels='ls ~/.cache/huggingface/hub/ | grep -v "^tmp" | sed "s/^models--//; s/--/\//g"'