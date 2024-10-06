if status is-interactive

    # cd ~/workspace/
    # Set editor to NVim
    set -Ux EDITOR nvim

    # Replace cd with zoxide for easier navigation
    zoxide init --cmd cd fish | source

    # Set up fzf key bindings
    # fzf --fish | source # Incompatible with fzf.fish
    fzf_configure_bindings --directory=\ct --git_log=\ch --git_status=\e\ch --processes=\cp --history=\cr

    # Transient prompt customization (I just use default)
    # function starship_transient_prompt_func
    #     starship module character
    # end

    # Use bat as man pager
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"

    function starship_transient_rprompt_func
      starship module time
    end

    starship init fish | source
    enable_transience
 
    # Yazi shell wrapper
    function ya
      set tmp (mktemp -t "yazi-cwd.XXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end

    #Lower env logs
    function amz-staging-logs
      aws-vault exec a6z-development -- aws ecs execute-command --task $(aws-vault exec a6z-development -- aws ecs list-tasks --cluster awsinfra-staging-3 --region eu-west-3 --service-name awsinfra-staging-3-web | jq -r '.taskArns[0]' | awk -F'/' '{print $NF}') --region eu-west-3 --cluster awsinfra-staging-3 --container awsinfra-staging-3-web --interactive --command 'sops exec-env /app/.environments/staging-amenitiz-3.enc.env "bundle exec rails console"'
    end

    alias ls="eza -a --color=always --long --git"
    abbr -a ll 'ls --icons -F -H --group-directories-first --git -1 -a'
    abbr -a tree 'ls -T --group-directories-first'
    abbr -a wrk 'cd ~/workspace/'
    abbr -a conf 'cd ~/.config'
    abbr -a amz 'cd ~/Workspace/amenitiz'
    abbr -a amz-run 'bundle install && rake db:migrate && yarn install --force && bin/dev'
    abbr -a amz-test-migrate 'RAILS_ENV=test rake db:migrate'
    abbr -a amz-test 'bundle install && amz-test-migrate && yarn install --force && rspec ~/Workspace/amenitiz'
    alias awsotp 'op item get tguinzburg --totp'
    alias amz-config 'op item get tguinzburg --totp | pbcopy; and aws-vault exec a6z-development -- make config/application.yml'
    alias pbclear 'pbcopy < /dev/null'
    alias vim nvim
    alias stripe-debug 'op item get stripe-read-only-billing --fields password | pbcopy'

    mise activate fish | source
    if not set -q ZELLIJ
      zellij attach default -c
    end
else
  mise activate fish --shims | source
end

set fish_greeting
set XDG_HOME $HOME/.config
set ZELLIJ_CONFIG_DIR $XDG_HOME/zellij
set DOCKER_HOST unix://$HOME/.colima/default/docker.sock

# Use sccache to speed up rust compilation
set -Ux RUSTC_WRAPPER sccache
fish_add_path -p /usr/local/bin
# Add cargo binaries to path
fish_add_path -p /Users/tomasguinzburg/.cargo/bin
fish_add_path /opt/homebrew/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tomasguinzburg/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/tomasguinzburg/Downloads/google-cloud-sdk/path.fish.inc'; end
