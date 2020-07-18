
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Environment Variables:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#---{{{1
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/zsh/oh-my-zsh"
export PDFVIEWER="zathura"
export TERMINAL="xst"
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export BROWSER='qutebrowser'
export PATH="$HOME/.local/cargo/bin:$HOME/.local/bin:$PATH"
#export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_ALT_C_COMMAND='fd -H -i '
export LESSHISTFILE="/dev/null"
export FFF_OPENER="rifle"
#export CCACHE_DIR="$HOME/.cache/ccache"
export CARGO_HOME="$HOME/.local/cargo"
export XDG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
#export GNUPGHOME="$HOME/.config/gnupg"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
#export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME/xmonad"
export XMONAD_DATA_HOME="XDG_DATA_HOME/xmonad"
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME/xmonad"
export HISTSIZE=10000
#---}}}
PROMPT=" %{$fg[yellow]%}%~ %{$reset_color%}%% "



#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Functions:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#---{{{
function acp (){
git add .
git commit -m $1
git push
}
spdl(){ 
URI=$( xsel --clipboard --output | sed 's:playlist:user/Bear/playlist:') 
spotify_dl -l $URI -o ~/media/music/
}
mem() {
free -h | grep -v total | sed 1q | awk '{print $3}'
}
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
fzf-cd(){ cd $(fd -H -t d | fzf --layout reverse --height=50%)}
pathadd(){cp $1 ~/.local/bin}
#---}}}
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Keybinds:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#---{{{
set -o vi
bindkey -s '\C-s' 'se\n'
bindkey -s 'C-h' 'hi\n'
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
#---}}}


#. /usr/share/zsh/site-contrib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#$HOME/source/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/secrets
source ~/.config/alias

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Keybinds:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#---{{{
# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zle -N fzf-cd
#bindkey '^[c'  fzf-cd
bindkey '^[c' fzf-cd-widget
#---}}}

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias bdwm='cd ~/.suckless/dwm && doas make install && cd ~'

source $HOME/.config/broot/launcher/bash/br
