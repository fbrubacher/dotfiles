spec --color --format specdoc user.rspec
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME=$(/usr/libexec/java_home)
# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"
export JAVA_OPTS=-Xmx768m 

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#. ~/bin/dotfiles/zsh/config
source ~/bin/dotfiles/zsh/aliases
export ARCHFLAGS="-arch x86_64"
export EDITOR='vi'

#this are bindings to restore control-r in vi mode in zsh
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
export RUBYLIB=/Users/federicobrubacher/.gem
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/lib/python2.5/site-packages:/Users/federicobrubacher/.gem/ruby/1.8/bin:HOME/.cabal/bin:/usr/local/mysql/bin:/opt/local/lib/mysql5/bin:/Users/federicobrubacher/Library/android-sdk-mac_86/tools:/opt/local/lib/postgresql84:/opt/local/lib/postgresql84/bin:/usr/local/Cellar/maven/2.2.1/bin:$PATH
export PYTHONPATH=~/src/python/blog:~/src/python/django-trunk/django:/usr/local/Cellar/python/2.7/lib/python2.7:/usr/local/Cellar/python/2.7/lib/python2.7/site-packages:$PYTHONPATH
export CLASSPATH=~/clojure/webbit.jar:~/clojure/clojure-contrib.jar:~/clojure/clojure-http-client/src/clojure_http:~/clojure/clojure-http-client.jar:~/clojure/joda-time-1.6.jar:~/clojure/mysql-connector-java-5.1.13/mysql-connector-java-5.1.13-bin.jar:~/clojure/junit-4.8.1.jar:/Users/federicobrubacher/clojure/mysql-connector-java-5.1.13:/Users/federicobrubacher/src/clojure:/Users/federicobrubacher/src/clojure/github/lancet:/Users/federicobrubacher/src/clojure/github/lancet/examples
export VIMRUNTIME=/usr/share/vim/vim70
open /Library/Application\ Support/iTerm/Scripts/AutoLaunch.scpt
diffit () { svn diff > ~/Desktop/temp.diff; open -a TextMate ~/Desktop/temp.diff; }
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completioninteger 
fi
alias tree="tree -CAFa -I 'CVS|*.*.package|.svn|.git' --dirsfirst"
# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH
export MAGICK_HOME="/usr/bin/imagemagick"
export PATH=$MAGICK_HOME/bin:$PATH
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"
export M2_HOME=/usr/local/Cellar/maven/2.2.1

export PATH=/opt/local/libexec/git-core:/opt/local/sbin:$PATH
export PATH=$M2_HOME/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
 if [[ -s /Users/federicobrubacher/.rvm/scripts/rvm ]] ; then source /Users/federicobrubacher/.rvm/scripts/rvm ; fi
