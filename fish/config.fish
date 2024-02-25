if status is-interactive
    # Commands to run in interactive sessions can go here
    set -Ux EDITOR nvim
    set -Ux RUSTC_WRAPPER sscache

    fish_add_path -p /Users/tomasguinzburg/.cargo/bin
    starship init fish | source
    zoxide init --cmd cd fish | source

    alias ls exa
    alias ll 'exa --icons -F -H --group-directories-first --git -1 -a'
    alias vim nvim

    function starship_transient_prompt_func
        starship module character
    end

    starship init fish | source
    enable_transience
end

alias vim nvim

set -Ux EDITOR nvim

set -Ux RUSTC_WRAPPER sccache

fish_add_path -p /Users/tomasguinzburg/.cargo/bin

#zoxide
zoxide init --cmd cd fish | source
