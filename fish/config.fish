# vim keybind
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_key_bindings fish_vi_key_bindings
end

# Set up fzf key bindings
fzf --fish | source

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/nene/miniconda3/bin/conda
    eval /Users/nene/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/nene/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/nene/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /Users/nene/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<

# Added by Antigravity
fish_add_path /Users/nene/.antigravity/antigravity/bin

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
export PATH="$HOME/.local/bin:$PATH"

# git clone and cd
function gcd
    git clone $argv[1]
    if test $status -eq 0
        # Extracts the repo name from the URL
        set repo_name (basename $argv[1] .git)
        cd $repo_name
    end
end

# zoxide
zoxide init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# change default editor
set --export EDITOR nvim

# Hermes Agent command
fish_add_path "$HOME/.local/bin"
