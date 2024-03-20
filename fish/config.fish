if status is-interactive

    cd ~/workspace/
    # Set editor to NVim
    set -Ux EDITOR nvim

    # Replace cd with zoxide for easier navigation
    zoxide init --cmd cd fish | source

    # Prompt customization
    function starship_transient_prompt_func
        starship module character
    end
    # Yazi shell wrapper
    function ya
      set tmp (mktemp -t "yazi-cwd.XXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end

    starship init fish | source
    enable_transience

    alias ls exa
    abbr -a ll 'ls --icons -F -H --group-directories-first --git -1 -a'
    abbr -a tree 'ls -T --group-directories-first'
    abbr -a wrk 'cd ~/workspace/'
    abbr -a amz 'cd ~/Workspace/amenitiz'
    abbr -a amz-run 'bundle install && rake db:migrate && yarn install --force && bin/dev'
    abbr -a amz-test 'RAILS_ENV=test rake db:migrate'
    alias amz-config 'op item get tguinzburg --totp | pbcopy; and aws-vault exec a6z-development -- make config/application.yml'
    alias pbclear 'pbcopy < /dev/null'
    alias vim nvim
    alias stripe-debug 'op item get stripe-read-only-billing --fields password | pbcopy'

    #Zellij autostart, but with compact mode
    #eval (zellij setup --generate-auto-start fish | string collect)
    # if set -q ZELLIJ
    # else
    #   zellij
    # end
end

set fish_greeting
set DOCKER_HOST unix://$HOME/.colima/default/docker.sock

# Use sccache to speed up rust compilation
set -Ux RUSTC_WRAPPER sccache
fish_add_path -p /usr/local/bin
# Add cargo binaries to path
fish_add_path -p /Users/tomasguinzburg/.cargo/bin
fish_add_path /opt/homebrew/bin

# Init mise (asdf clone)
if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end
