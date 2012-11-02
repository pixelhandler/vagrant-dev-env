export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export NODE_PATH="/usr/local/bin/node:/usr/local/lib/node_modules:/usr/local/lib/jsctags/:$NODE_PATH"

export EDITOR=vim

# https://github.com/rupa/z.git
. /home/vagrant/bin/z.sh
# alias zadd="_z --add \"\$(pwd -P 2>/dev/null)\" 2>/dev/null;"

showBranch(){
    if [$(pwd | grep "projects|www") != ""]; then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/±\1/' | tr "\n" ' '
        hg branch 2> /dev/null | sed -e 's/\(.*\)/☿\1 /'
    fi
}

export PS1='\e[01;32m\u\e[34m@\H \e[01;31m\w \e[32;40m$(showBranch) \n\[\e[30m\]#\[\e[33m\]⚡ \[\e[0m\]'
