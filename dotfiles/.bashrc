export EDITOR=vim

export NODE_PATH="/usr/local/bin/node:/usr/local/lib/node_modules:/usr/local/lib/jsctags/:$NODE_PATH"

PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
#PATH="/usr/local/bin:$PATH"

# rbenv
eval "$(rbenv init -)"
if which rbenv > /dev/null;
then
  export GEM_PATH=.bundle
  export RBENV_ROOT=/usr/local/var/rbenv
  PATH=$PATH:$HOME/.rbenv/shims:$HOME/bin
  PATH=.bundle/bin:$PATH
fi

export PATH=$PATH

# z script https://github.com/rupa/z.git
#. ~/bin/z/z.sh
. /usr/local/bin/z.sh
# alias zadd="_z --add \"\$(pwd -P 2>/dev/null)\" 2>/dev/null;"

showBranch(){
    if [$(pwd | grep "projects|www") != ""]; then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/±\1/' | tr "\n" ' '
        hg branch 2> /dev/null | sed -e 's/\(.*\)/☿\1 /'
    fi
}

export PS1='\e[01;32m\u\e[34m@\H \e[01;31m\w \e[32;40m$(showBranch) \n\[\e[30m\]#\[\e[33m\]⚡ \[\e[0m\]'

# Alias
alias be="bundle exec"
alias tr="touch ~/.pow/restart.txt"
alias ss="python -m SimpleHTTPServer"

# Git 
alias co='git checkout'
alias pull='git pull'
alias pullup='git pull upstream master'
alias push='git push'
alias ga='git add .'
alias gs='git status'
alias gb='git branch'
alias gf='git fetch'
alias gc='git commit -am'
alias gr='git rebase'
alias gt='git tag'
alias go='git remote -v'

alias sq=squash
alias cb=current_branch
alias pushf=force_push

# ember-cli
alias nom='rm -rf node_modules vendor && npm cache clear && npm install && bower install'

squash(){
  git rebase -i HEAD~$1
}

current_branch(){
  gb 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

hist(){
  git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short -$1
}

last(){
  git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short -1
}

changed(){
  git show --pretty="format:" --name-only $1
}

sync(){
  gf --all && co master && pull && gs && last
}

blam(){
  push origin $(cb) $@
}

syncup(){
  gf --all && co master && pullup && blam && gs && last
}

force_push(){
  branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
  if [ $branch == "master" ]; then
    echo "*** [Policy] never force push master"
  else
    echo "*** Force push branch: $branch to origin"
    push --force origin $branch
  fi
}
