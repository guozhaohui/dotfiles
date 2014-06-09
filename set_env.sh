
export CLASSPATH=$CLASSPATH:/usr/share/java/*

# User specific aliases and functions
alias ll="ls -la"
alias vi="vim"
alias vundle_inst="git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"

#------------------------------
#Usage:
# hex2dec 0xdb6a
#--------------------------------
function hex2dec(){
    printf "%d\n" $1
}

function dec2hex(){
    printf "0x%x\n" $1
}

#------------------------------
#Usage:
# date2timet 2012-08-28
# date2timet '2012-08-28 00:00:05'
#--------------------------------
function date2timet(){
    date -d "$1" +%s
}

#------------------------------
#Usage:
# timet2date 1346338800
#--------------------------------
function timet2date(){
    date -d @$1 +'%Y/%m/%d (%a) %H:%M:%S'
}


#==============================================================================
# 環境変数MAKETOP設定
#==============================================================================
function set_maketop_pwd() {
    export MAKETOP=`pwd`
    export CROSS_C_ROOT_PATH=${MAKETOP}
}

function set_maketop_cur() {
    export MAKETOP=`pwd | sed -e 's/root\/.*/root/'`
    export CROSS_C_ROOT_PATH=${MAKETOP}
    echo MAKETOP=$MAKETOP

}

#==============================================================================
#タグファイルの作成(ctags)
#==============================================================================
exclude_list="--exclude='*.lo' --exclude='*.o' --exclude='*.am' --exclude='*.in' --exclude='*.la' --exclude='*.lsp' --exclude='*tags' --exclude='XTAGS'"
#------------------------------
# タグファイル生成汎用コマンド
#Usage:
# tags_new dir_name  tag_file_name
#--------------------------------
function tags_new() {
    if [ $# -eq 0 ]; then
       ctags -f ./.tags -R . $exclude_list
    else
       ctags -f $2 -R $1 $exclude_list
    fi
}

#------------------------------
# タグファイルに関連ソースコードのフォルダを追加します
#Usage:
# tags_append dir_name  tag_file_name
#--------------------------------
function tags_append() {
    if [ ! -e $2 ]; then
        echo -n -e "can NOT find $2 to append tags information\n"
        echo 'exit 1'
        return 1
    fi
    ctags -a --tag-relative=yes -f $2 -R $1 $exclude_list
}

#===============================================================================
#CVSROOT設定
#===============================================================================
alias  set_mycvs='export CVSROOT=/opt/disc1/kaku/work/MY_CVS'


#=======================================
#CVSコマンドの拡張。
#=======================================
alias cvsdiff='cvs diff -u -kk'
#------------------------------
# CVSフォルダ内の情報を利用して、ログインする。
#--------------------------------
function cvslogin() {
    if [ ! -e ./CVS/Root ]; then
		echo 'Can NOT find CVS folder. Exit 1'
		return 1
	fi
	root_path=`cat CVS/Root`
	export CVSROOT=$root_path
	cvs login
}

#------------------------------
#DIRのCVS情報を出力
#Usage:
# cvsinfo
#--------------------------------
function cvsinfo() {
   tag_info=""
   if [ ! -e ./CVS/Repository ]; then
      echo 'Can NOT find CVS folder. Exit 1'
      return 1
   fi
   repo_dir_path=`cat ./CVS/Repository`
   if [ -e ./CVS/Tag ]; then
      tag_info=`cat  ./CVS/Tag`
   fi
   tag_info=`echo $tag_info |  sed -e 's/^T//'`

   echo -e "$repo_dir_path\t$tag_info"
}

#------------------------------
#フォルダをバックアップしてから、CVSリポジトリから取り直し
#Usage:
# cvsup setting
#  settingフォルダ名をsetting_bakに変更して、CVSから取り直し
#--------------------------------
function cvsup() {
   tag_info=""
   if [ ! -e $1/CVS/Repository ]; then
      echo 'Can NOT find CVS folder. Exit 1'
      return 1
   fi
   repo_dir_path=`cat $1/CVS/Repository`
   if [ -e $1/CVS/Tag ]; then
      tag_info=`cat $1/CVS/Tag`
      tag_info=`echo $tag_info |  sed -e 's/^T//'`
   fi

   mv $1 $1_bak

   if [ -n "$tag_info" ]; then
      cvs co -d $1 -r $tag_info $repo_dir_path
   else
      cvs co -d $1 $repo_dir_path
   fi
}

#------------------------------
#カレントtermを対象となるps
#freebsd環境では、デフォルトはuserのすべてのプロセスを表示する
#--------------------------------
function pss(){
  term_num=`tty | sed s#/dev/pts/##`
  ps -t $term_num
}

function git_clone() {
   echo Retrieving source code........
   echo BASE   : $1
   echo BRANCH : $2
   echo -n "Is it OK to clone these version? : (y/n)"
   read ans
   if [ $ans != "y" ];then
	     exit 0
   fi

   echo

   git clone ssh://guo.zhaohui@github.com//$1 newarch
   cd newarch
   git checkout -b $2 origin/$2
}
nx=( TEST-src TEST-branch )

alias git_nx="git_clone ${nx[@]}"
