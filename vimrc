# ~/.bashrc

export PS1='\h:\w\$ '
umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -la'
alias l='ll'
alias vi='vim'
alias pstree='pstree -A'

[ -f /etc/bash_completion ] && . /etc/bash_completion
HISTTIMEFORMAT="%d/%m/%Y(%H:%M:%S) # "
