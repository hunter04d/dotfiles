# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hunter04d/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  conda-zsh-completion
  alias-tips
  autoupdate
  cargo
  rust
  colorize
  command-not-found
  extract
  fast-syntax-highlighting
  git
  kate
  ng
  tmux
  npm
  nvm
  pip
  sudo
  # web-search # not usefull 
  zsh-autosuggestions
  zsh-navigation-tools
  zsh_reload
  vi-mode
  # zsh-syntax-highlighting
)


fpath+=~/.zshcomp
autoload -U compinit && compinit

#autoload -U bashcompinit && bashcompinit
# snap completion is broken
#source /var/lib/snapd/snap/core/current/usr/lib/snapd/complete.sh
source $ZSH/oh-my-zsh.sh

# cacl plugin
source $ZSH_CUSTOM/plugins/calc/calc.plugin.zsh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8



##############################[nvim: VI ZSH config]##############################
export VISUAL=nvim
# switch to normal mode faster
export KEYTIMEOUT=1

# ctrl + k for normal move, same as nvim
bindkey '^k' vi-cmd-mode


# sane navigation
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
# ctrl + L is bad
bindkey -r '^L'

# fix cursor after editor
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# cursor selection for cmd/insert modes
zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
}


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# History 
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000


# some sane options
setopt appendhistory autocd extendedglob glob_star_short nomatch notify ignore_eof
unsetopt beep

# zstyle :compinstall filename '/home/hunter04d/.zshrc'
# autoload -Uz compinit
# compinit


##############################[ex/cx]##############################
# ex - archive extractor
# usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.tar)       tar xpf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.gz)        gunzip $1    ;;     
      *.rar)       unrar x $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

cx () {
  if [ $1 ] ; then
    case $1 in
      tar.bz) tar cjvf $2.tar.bz2 $2  ;;
      tar.gz) tar czvf $2.tar.gz $2   ;;
      tgz)    tar czvf $2.tgz $2      ;;
      tgz2)   tar cjvf $2.tgz2 $2     ;;
      tar)    tar cpvf $2.tar  $2     ;;
      bz2)    bzip2 -c -9 $2 > $2.bz2 ;;
      gz)     gzip -c -9 -n $2 > $2.gz;;
      zip)    zip -r $2.zip $2        ;;
      Z)      compress -r -c $2 > $2.Z;;
      7z)     7z a $2.7z $2           ;;
      *)      echo "'$1' cannot be packed via cx()" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# tilix config
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

##############################[random functions]##############################

# DEPRECATED
#mount local cifs 
mountRT() {
    sudo mount -t cifs //192.168.1.1/folder /mnt/folder -o vers=1.0,uid=1000,gid=1001, \
        credentials=/home/hunter04d/.rt-ac66u-b1.credentials
}

# fixes icons upon theme change
fixIcons() {
    local current_theme=$(kreadconfig5 --file $HOME/.config/kdeglobals --group Icons --key Theme)
    if [[ $current_theme == Papirus* ]]; then
        # might need to use just Papirus and not current theme
        sudo -E hardcode-tray --apply --conversion-tool RSVGConvert --size 22 --theme $current_theme
    fi
}

# print terminal colors
display-colors() {
	local fgc bgc vals
    vals=("\uf175bg|fg\uf178" ${(l:5:):-{0..7}})
    # background colors
	for bgc in {0..7}; do
        vals+=($bgc)
        # foreground colors
		for fgc in {0..7}; do
			vals+=("%F{$fgc}%K{$bgc}text%k %K{$bgc}%BBOLD%b%k%f")
		done
	done
    print -a -P -C 9 ${vals[@]}
}

# toggle light/dark themes
# function ttheme(); $HOME/ThemeChanger/change-theme.sh

# NOTE to self: **11** is very magical might crash
toggle-mouse() {
    local state=$(xinput list-props 11 | grep 'libinput Scroll Method Enabled' | head -n 1 |tr -d '\n'| tail -c 1)
    #TODO a simpler way to toggle 
    if [[ state = 1 ]]; then
        state=0
        echo -e 'Middle scroll \e[91mdisabled\e[0m'
    else
        state=1
        echo -e 'Middle scroll \e[92menabled\e[0m'
    fi
    xinput set-prop 11 'libinput Scroll Method Enabled' 0, 0, $state
}




##############################[dotnet: dotnet config]##############################
# dotnet completion
_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}
# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
compctl -K _dotnet_zsh_complete dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1


##############################[nodejs: nodejs and nvm config]##############################
# for application that want a path to current selected node/npm
NVM_SYMLINK_CURRENT=true
#PATH="$HOME/.node_modules/bin:$PATH"
#export npm_config_prefix=~/.node_modules
source /usr/share/nvm/init-nvm.sh


##############################[ruby]##############################
#ruby gem config
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

# color ls compinit
source $(dirname $(gem which colorls))/tab_complete.sh

##############################[aliasing]##############################

# git bare repository for dotfiles
alias dotconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ii as in windows
alias ii='dolphin >/dev/null 2>&1'

# cls = clear
alias cls=clear

# manjaro defaults
alias cp="cp -i"            # confirm before overwriting something
alias df='df -h'            # human-readable sizes
alias free='free -m'        # show sizes in MB
alias np='kate PKGBUILD &'
alias more=less

alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# DEPRECATED: should use exa commands instead
# colorls
# alias lc='colorls'
# alias lcl='colorls -A -l'
# alias lcll='colorls -a -l'

# exa

alias lx='ls'
alias lxl='ls -l'
alias ls='exa --icons --git'
alias ll='exa -l --icons --git'
alias la='exa -l -a --icons --git'

# alias expansion on ctrl+space
globalias() {
   zle _expand_alias
   zle expand-word
}
zle -N globalias
bindkey -M emacs "^ " globalias
bindkey -M viins "^ " globalias

##############################[zsh named directories]##############################
# works nicely with p10k
# idea from http://michael.thegrebs.com/2012/08/06/syncing-zsh-named-directories/
typeset -A NAMED_DIRS=(
    e           /mnt/e
    d           /mnt/d
    Web         /mnt/e/Web
    Screenshots /mnt/e/ManjaroScreeneshots
)

for key val in ${(kv)NAMED_DIRS}; do
    if [[ -d ${val} ]]; then
        hash -d $key=${val}
    else
        #echo "Unset $key to $NAMED_DIRS[$key]"
        unset "NAMED_DIRS[$key]"
    fi
done
unset key val

function lsdirs(); print -a -C 2 ${(kv)NAMED_DIRS}

##############################[variables]##############################
VIRTUAL_ENV_DISABLE_PROMPT=1

# DEPRECATED: USING p10k now,
# Powerlevel9k config
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode virtualenv background_jobs status command_execution_time)

# POWERLEVEL9K_STATUS_OK=false

# #context config
# DEFAULT_USER='hunter04d'
# POWERLEVEL9K_ALWAYS_SHOW_USER=true
# # dir colours
# POWERLEVEL9K_DIR_HOME_BACKGROUND='117'
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='075'
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='075'
# POWERLEVEL9K_DIR_ETC_BACKGROUND='006'

# # dir config
# POWERLEVEL9K_SHORTEN_DIR_LENGTH='2'
# POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_first_and_last'

# POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='075'
# POWERLEVEL9K_ANACONDA_FOREGROUND='015'

# POWERLEVEL9K_VI_INSERT_MODE_STRING=''
# POWERLEVEL9K_VI_COMMAND_MODE_STRING='[N]'

# zsh autosuggest config
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hunter04d/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hunter04d/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hunter04d/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hunter04d/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
