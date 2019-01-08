########################################
if [ -x /usr/bin/dircolors ]; then
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree -C'
fi
########################################
########################################
if [ -x /usr/bin/dircolors ]; then
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias tree='tree -C'
fi
########################################
export PS1="[\e[31m\u\e[0m@\e[33m\h\e[0m \e[36m\w\e[0m]\$ "
#export http_proxy="http://proxy.vmware.com:3128"
#export https_proxy="http://proxy.vmware.com:3128"
function grepv()
{
   vim "+Rgrep $1" .
}
alias vimgrep=grepv
alias vi=vim
PATH=$PATH:/usr/local/bin
export GOPATH=/code/golang:$GOPATH
export GOBIN=$HOME/go

