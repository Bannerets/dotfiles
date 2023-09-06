set -l dotfiles ~/dotfiles

set fish_greeting

source $__fish_config_dir/colors.fish

# The default is Alt-e / Alt-v
bind \cx\ce edit_command_buffer

alias ls "ls -FA"
alias exa "exa --all -l --git"

# gpg symmetric encrypt
alias gpgenc "gpg -c --s2k-mode 3 --s2k-digest-algo sha512 --s2k-count 65011712 --s2k-cipher-algo aes256"

# light nvim
alias lvi "nvim --cmd 'let g:min_mode = 1'"

# "private" mode
alias lvi-p "nvim --cmd 'let g:min_mode = 1' -i NONE --cmd 'set noswapfile'"

abbr -ag getdate "date \"+%Y_%m_%d\""

abbr -ag qfind "find . -name"

abbr -ag e "echo"

abbr -ag f "ls | grep -i"

abbr -ag totarbz2 "tar cjvf"
abbr -ag fromtarbz2 "tar xjvf"
abbr -ag totargz "tar czvf"
abbr -ag fromtargz "tar xzvf"

abbr -ag sha256sum "shasum -a 256"

abbr -ag gs "git status"

abbr -ag ra "ranger"

abbr -ag hi "highlight"

abbr -ag npmplease "rm -rf node_modules/ package-lock.json && npm install"
abbr -ag pnpmflat "pnpm install --shamefully-flatten"
abbr -ag npmr "npm run"

abbr -ag youtube-music "youtube-dl --extract-audio --audio-format vorbis"

abbr -ag nixi "nix profile install"

abbr -ag vimr "vimr --cur-env"

abbr -ag start-postgres "pg_ctl -D /usr/local/var/postgres start"
abbr -ag stop-postgres "pg_ctl -D /usr/local/var/postgres stop"

abbr -ag start-redis "redis-server /usr/local/etc/redis.conf"

set -x LANG en_US.UTF-8

set -x CLICOLOR 1
set -x LSCOLORS gxBxhxDxfxhxhxhxhxcxcx
# set -x LSCOLORS GxFxCxDxBxegedabagaced
set -x LS_COLORS $LSCOLORS

set -x VISUAL vim

set -x GPG_TTY (tty)
set -x LESSCHARSET utf-8
set -x INPUTRC ~/.inputrc

set -xp PATH ~/.local/bin

set -xp PATH $dotfiles/global-scripts

if test -d ~/.cargo
  set -xp PATH ~/.cargo/bin
end

source ~/.opam/opam-init/init.fish > /dev/null 2>&1 || true

set -x HOMEBREW_NO_AUTO_UPDATE 1

if test -r $dotfiles/vendor/.iterm2_shell_integration.fish
  source $dotfiles/vendor/.iterm2_shell_integration.fish
end
