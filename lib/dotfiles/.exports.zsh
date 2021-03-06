export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH
## Use gnu tools instead
if brew > /dev/null 2>&1; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi
export NODE_PATH=/usr/bin/node
export EDITOR=/usr/local/bin/emacs

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTFILE=~/.zsh_history
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom"
