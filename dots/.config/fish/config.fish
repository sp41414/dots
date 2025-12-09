function fish_prompt -d "Write out the prompt"
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    set fish_greeting
end

starship init fish | source

# TMUX (ctrl + f for tmux-sessionizer)
if not set -q TMUX
    tmux
end
set PATH "$PATH":"$HOME/.local/scripts/"
bind \cf tmux-sessionizer

alias ls 'eza --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias vim nvim

set -gx EDITOR nvim

fish_add_path ~/.cargo/bin

function cd
    builtin cd $argv
    eza --icons
end

fish_add_path $HOME/go/bin/
