# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hunter04d/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

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
  git
  colorize
  npm
  nvm
  ng
  kate
  pip
  command-not-found
  autoupdate
  sudo
  web-search
  extract
  zsh-navigation-tools
  zsh-autosuggestions
  zsh-syntax-highlighting
)
autoload -U compinit
compinit
source $ZSH/oh-my-zsh.sh

# cacl plugin
source $ZSH_CUSTOM/plugins/calc/calc.plugin.zsh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory autocd extendedglob glob_star_short nomatch notify ignore_eof
unsetopt beep

# zstyle :compinstall filename '/home/hunter04d/.zshrc'
# autoload -Uz compinit
# compinit

# dotnet completion
_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
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

#mount local cifs share
mountRT() {
    sudo mount -t cifs //192.168.1.1/folder /mnt/folder -o vers=1.0,uid=1000,gid=1001, \
        credentials=/home/hunter04d/.rt-ac66u-b1.credentials
}

# fixes icons upon theme change
fixIcons() {
    local current_theme=$(kreadconfig5 --file $HOME/.config/kdeglobals --group Icons --key Theme)
    if [[ $current_theme == Papirus* ]]; then
        sudo -E hardcode-tray --apply --conversion-tool RSVGConvert --size 22 --theme $current_theme
    fi
}


colors() {
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
function ttheme(); $HOME/ThemeChanger/change-theme.sh

# NOTE to self: **11** is very magical might crash
toggle-mouse() {
    local state=$(xinput list-props 11 | grep 'libinput Scroll Method Enabled' | head -n 1 |tr -d '\n'| tail -c 1)
    #TODO a simpler way to toggle 
    if [[ state = 1 ]]; then
        state=0
        echo -e 'Middle scroll \e[91mdisabled'
    else
        state=1
        echo -e 'Middle scroll \e[92menabled'
    fi
    echo -e "\e[0m"
    xinput set-prop 11 'libinput Scroll Method Enabled' 0, 0, $state
}

# nodejs, npm and nvm setup
#PATH="$HOME/.node_modules/bin:$PATH"
#export npm_config_prefix=~/.node_modules
source /usr/share/nvm/init-nvm.sh



#ruby gem config
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

# git bare repository for dotfiles
alias dotconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ii='dolphin >/dev/null 2>&1'
alias cls=clear


alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='kate PKGBUILD &'
alias more=less


alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

globalias() {
   zle _expand_alias
   zle expand-word
}
zle -N globalias
bindkey -M emacs "^ " globalias
bindkey -M viins "^ " globalias
# zsh named directories
#idea from http://michael.thegrebs.com/2012/08/06/syncing-zsh-named-directories/

typeset -A NAMED_DIRS
NAMED_DIRS=(
    Web /mnt/e/Web
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

function lsdirs () {
   print -a -C 2 ${(kv)NAMED_DIRS}
}

# custom segment that displays info about current project
prompt_hunter04d_segment() {
   #TODO: setopt and emulate -L zsh     
    local f
    local count=0
    local content
    local fgc=black
    local bgc=yellow
    local temp
    local icon=''
    temp=$(command dotnet sln list 2> /dev/null)
    if [[ $? -eq 0 ]]; then
        bgc=007
        local proj=""
        content="sln: "
        local totalcount=$(echo $temp| tail -n+3 | wc -l)
        local cscount=$(echo $temp | grep -i -c csproj$)
        local fscount=$(echo $temp | grep -i -c fsproj$)
        local vcxcount=$(echo $temp | grep -i -c vcxproj$)
        if [[ $cscount -eq $totalcount ]]; then 
            content+="%F{034}$cscount \uf81a%f" 
        elif [[ $fscount -eq $totalcount ]]; then
            content+="%F{057}$fscount \ue7a7%f"
        elif [[ $vcxcount -eq $totalcount ]]; then
            content+="%F{171}$vcxcount \uefb71%f"
        else
            content+="$totalcount \ue601"
            if [[ $cscount -ne 0 ]] ; then content+=" | %F{034}$cscount \uf81a%f"; fi
            if [[ $cscount -ne 0 ]] ; then content+=" | %F{057}$fscount \ue7a7%f"; fi
            if [[ $vcxcount -ne 0 ]]; then content+=" | %F{171}$vcxcount \ue7a7%f"; fi
        fi
    fi
    temp=(*.(csproj|fsproj)(#qN.))
    if [[ ${#temp} -eq 1 ]]; then
        case $temp in
            *.csproj) icon='\uf81a'; bgc=034; fgc=015;;
            *.fsproj) icon='\ue7a7'; bgc=057; fgc=015;;
        esac
        content="$(xmllint --xpath '/Project/PropertyGroup/TargetFramework/text()' $temp)"
    fi
    if [[ -n $content ]]; then
        "$1_prompt_segment" "$0" "$2" "$bgc" "$fgc" "$icon $content"
    fi
}

VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(hunter04d_segment virtualenv background_jobs status command_execution_time)
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_DIR_HOME_BACKGROUND='117'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='075'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='075'
POWERLEVEL9K_DIR_ETC_BACKGROUND='006'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='075'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
