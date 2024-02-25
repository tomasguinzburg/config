if status is-interactive
    # Set editor to NVim
    set -Ux EDITOR nvim

    # Replace cd with zoxide for easier navigation
    zoxide init --cmd cd fish | source

    # Prompt customization
    function starship_transient_prompt_func
        starship module character
    end

    starship init fish | source
    enable_transience

    alias ls exa
    abbr -a ll 'ls --icons -F -H --group-directories-first --git -1 -a'
    abbr -a tree 'ls -T --group-directories-first'
    abbr -a wrk 'cd ~/workspace/'
    alias vim nvim

    #Zellij autostart, but with compact mode
    #eval (zellij setup --generate-auto-start fish | string collect)
    if set -q ZELLIJ
    else
      zellij --layout compact
    end
end

set fish_greeting

# Use sccache to speed up rust compilation
set -Ux RUSTC_WRAPPER sscache
# Add cargo binaries to path
fish_add_path -p /Users/tomasguinzburg/.cargo/bin

# Init mise (asdf clone)
if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end
