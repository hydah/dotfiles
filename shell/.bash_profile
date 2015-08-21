export PATH=/build/apps/bin:/dbc/pek2-dbc201/hey/git-hacks/git-post:$PATH
export P4CONFIG=.p4config

export PYTHONPATH=$PYTHONPATH:/bldmnt/toolchain/noarch/vmware-pyvpx-5.5.0/:/bldmnt/toolchain/noarch/paramiko-1.7.6/lib/python2.7/site-packages/:/bldmnt/toolchain/lin32/pycrypto-2.6/lib/python2.7/site-packages/

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
export http_proxy="http://proxy.vmware.com:3128"
