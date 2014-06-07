
export CLASSPATH=$CLASSPATH:/usr/share/java/*

# User specific aliases and functions
alias ll="ls -la"
alias vi="vim"
alias vundle_inst="git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"

function hex2dec(){
	printf "%d\n" $1	
}

function dec2hex(){
	printf "0x%x\n" $1	
}

function date2timet(){
	date -d "$1" +%s	
}

function timet2date(){
    date -d @$1 +'%Y/%m/%d (%a) %H:%M:%S'	
}

