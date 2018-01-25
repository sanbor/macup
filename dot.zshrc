# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# compinit will not automatically find new executables in the $PATH. For example, after you install something.
# make rehash to happen automatically
zstyle ':completion:*' rehash true

# Don't wait until the session is closed to write the history
setopt share_history

# Let's you do 5*7 without quoting, otherwise if the file glob doesn't expand to a file throws an error
unsetopt nomatch

# Remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE

# PROMPT='[%n@%m %~]$ '

# Make time look like bash instead of the zsh version
disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output
# or  TIMEFMT=$'\nreal\t%*Es\nuser\t%*Us\nsys\t%*Ss'

#fix annoying zsh word jump behaviour
bindkey '^[^[[C' forward-word # alt right arrow to jump word
bindkey '^[^[[D' backward-word # alt left arrow to jump backwards word
autoload -U select-word-style
select-word-style bash

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/19.1.0:$PATH

# Use vim
export VISUAL=vim
export EDITOR="$VISUAL"

# alias
alias ll='gls --color -lh'
alias la='ll -art'
alias d="docker-compose"

# Show current branch in current submodule
setopt prompt_subst
source $(brew --prefix)/etc/bash_completion.d/git-prompt
export RPROMPT=$'$(__git_ps1 "%s")'

