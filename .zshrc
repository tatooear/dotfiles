#/bin/zsh
# -*- shell-script -*-

local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
#PROMPT=$'\n'$YELLOW'[${USER}@${HOSTNAME} %~] (%!)'$'\n'$DEFAULT'%(!.#.$) '
#PROMPT=$'\n'$YELLOW'[${USER}@%~] (%!)'$'\n'$DEFAULT'%(!.#.$) '
PROMPT=$YELLOW'[ ${HOSTNAME}%~ ] (%!)'$'\n'$DEFAULT'%(!.#.$) '

#PROMPT="%{${\e[33;40m%]}%}[%n@%/] (%!)
#%(!.#.$) %{${reset_color}%}"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
LISTMAX=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # 単語として扱う文字に / を含めない。 ^W で / の前までのディレクトリ1つ分削除できる

fpath=(~/. ${fpath})
fpath=(~/.zsh.d/zsh-completions $fpath)

export EDITOR="emacsclient -n"
bindkey -e

export LANG=ja_JP.UTF-8

export LESS="-RNS"
#export LESSOPEN="| ~/.source-highlight/src-hilite-lesspipe.sh %s"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
#export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
#export LESSOPEN=""

export PAGER="less"

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=36:ln=32:bn=32:se=01;33"

#export GTAGSLABEL="exuberant-ctags"

#export PATH="$HOME/.anyenv/bin:$PATH"
#export PATH="/c/HashiCorp/Vagrant/bin:$PATH"
#eval "$(anyenv init -)"
#export PATH=$PATH:/home/owner/program/android/android-sdk-linux/tools
#export HOME=/home
#export PATH="$PATH:/c/Go/bin"

#export GOROOT=/usr/bin/go
export GOPATH=/usr/local/share/go
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


eval `dircolors ~/.dir_colors`

autoload -Uz compinit
compinit -u

autoload colors
colors

# autoload -Uz add-zsh-hook
# autoload -Uz vcs_info

# zstyle ':vcs_info:*' enable git svn hg bzr
# zstyle ':vcs_info:*' formats '(%s)-[%b]'
# zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
# zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
# zstyle ':vcs_info:bzr:*' use-simple true

# autoload -Uz is-at-least
# if is-at-least 4.3.10; then
#   # この check-for-changes が今回の設定するところ
#   zstyle ':vcs_info:git:*' check-for-changes true
#   zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
#   zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
#   zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
#   zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
# fi

# RPROMPT="%1(v|%F{green}%1v%f|)"

# source /etc/bash_completion.d/git

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^/" undo
bindkey "^\\" redo
bindkey "^[^B" vi-backward-blank-word
bindkey "^[^F" vi-forward-blank-word
bindkey "^[^U" backward-delete-word
bindkey "^[^K" delete-word
bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする

#export LS_COLORS='di=01;34:ln=01;36:so=32:pi=33:ex=01;32:bd=46;34:cd=01;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#zstyle ':completion:*' list-colors 'di=01;34' 'ln=01;36' 'so=32' 'ex=01;32' 'bd=46;34' 'cd=01;34'
zstyle ':completion:*:default' menu select=1 # 補完侯補をEmacsのキーバインドで動き回る
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*:*:kill:*:processes' menu yes select=2 list-colors '=(#b) #([%0-9]#)*=0=01;31' # kill の候補にも色付き表示
zstyle ':completion:*' completer _oldlist _expand _complete _match _prefix _approximate _list _history _arguments
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'
#あらかじめcdpathを適当に設定しておく
cdpath=(~ ..)
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd
#ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin

autoload -Uz zmv

#limit coredumpsize 0

setopt append_history       # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt always_last_prompt   # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt auto_list            # 補完候補が複数ある時に、一覧表示する
setopt auto_menu            # タブキー連打で補完候補を順に表示
setopt auto_param_keys      # カッコの対応などを自動的に補完
#setopt auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_pushd           # cd 時にOLDDIR を自動的にスタックに積む
setopt correct              # コマンドのスペルチェック
setopt complete_aliases     # エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt complete_in_word     # 語の途中でもカーソル位置で補完
setopt extended_glob        # globを拡張する。
setopt extended_history     # 履歴ファイルに時刻を記録
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt hist_expand          # 補完時にヒストリを自動的に展開する。
setopt hist_ignore_all_dups # 重複するヒストリを持たない
setopt hist_ignore_dups     # 前のコマンドと同じならヒストリに入れない
setopt hist_ignore_space    # 空白ではじまるコマンドをヒストリに保持しない
setopt hist_no_store        # history コマンドをヒストリに入れない
setopt hist_reduce_blanks   # 履歴から冗長な空白を除く
setopt ignore_eof           # Ctrl-D でログアウトするのを抑制する。
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt list_packed          # 補完候補を詰めて表示する
setopt list_types           # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt magic_equal_subst    # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt no_clobber           # リダイレクトで上書きする事を許可しない。
setopt no_flow_control      # C-s, C-qを無効にする。
#setopt noautoremoveslash    # パスの最後に付くスラッシュを自動的に削除しない
setopt nolistbeep
setopt numeric_glob_sort    # 辞書順ではなく数値順でソート
setopt print_eight_bit      # 補完候補リストの日本語を正しく表示
setopt prompt_subst         # エスケープシーケンスを使う。
setopt pushd_ignore_dups    # ディレクトリスタックに、同じディレクトリを入れない
setopt rec_exact
setopt rmstar_wait          # rm * を実行する前に確認される。
setopt share_history        # 複数プロセスで履歴を共有
setopt bang_hist

# alias apt-cyg="apt-cyg -m ftp://ftp.jaist.ac.jp/pub/cygwin -c /package"
# alias cygport="apt-cyg -m ftp://ftp.cygwinports.org/pub/cygwinports"
alias grep="grep --color=always"
alias fgrep="fgrep --color=always"
alias egrep="egrep --color=always"
alias zgrep="zgrep --color=always"
#alias lgrep="lgrep --color=always"
alias rsync="rsync -av"
alias scp="scp -rp"
alias ack="ack --color"
alias ag="ag -r --color"
alias zmv="noglob zmv -W"
#alias vl="/usr/share/vim/vim73/macros/less.sh"
alias diff="colordiff --strip-trailing-cr"
alias sdiff="sdiff --strip-trailing-cr"
#alias tmux="tmux -S /tmp/tmux-197608/defaunlt"

alias ls="ls --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias la="ls -lah --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias ltr="ls -ltarh --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias ll="ls -lh --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias sls="ls -lahS --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias em="emacs"
alias rr="rm -rf"
alias rm="rm -i"
alias cp="cp -ip"
alias mv="mv -i"
alias mk="mkdir -p"
#alias op="cygstart"
alias en="emacsclient -n"
alias ed="emacs --deamon"
alias dvp="tar xfzv"
alias cmp="tar cfzv"
alias hi="history -nir 0"
# alias ud="bd"
alias pd="cd -"
alias peco="peco --initial-filter migemo"

#alias up="source ~/.zsh.d/up.sh"

# SYSTEM=`cygpath -u ${SYSTEMROOT}`/system32
# alias ping="$SYSTEM/ping"
# alias nslookup="$SYSTEM/nslookup.exe"
# unset SYSTEM

alias -g L="| less"
#alias -g R="| richpager"
alias -g T="| tail"
alias -g G="| grep"
alias -g N="| nkf -w"
alias -g W="| wc -l"
alias -g H="| --help | less"
alias -g XG="| xrags grep"
alias -g P="| peco"

#source ~/.zsh.d/ssh.zsh

function ecmp () { tar czvf $1 --exclude $2 }
function tl () { tar czlf - $1 | tar tzvf - | less }
function jl () { less $1 | nkf -w | less }
#function jr () { nkf -w $1 | richpager }
function ff() { find $1 -name $2 -print }
function fxg() { find $1 -name $2 -print | xargs grep $3 }
function frm() { find $1 -name $2 -exec rm {} \; }
function hig() { history -nir 0 | grep $1 | less }
#function hi()  { history -E 1 } # 全履歴の一覧を出力する
function ft()  { find $1 -type f -ctime $2 | xargs ls -ltrah --color=always --time-style=+'%Y/%m/%d %H:%M' | less }
function zls() { zcat $1 | tar tv | less }
function rcp() { find $1 -type d -name $2 -exec cp -r $3 {} \; }
function bcp() { find $1 -name $2 -exec cp '{}' '{}_bk' \; }
function mcp() { find $1 -name $2 | xargs rename $2 $3 }
function ediff () { emacsclient -n --eval "(ediff-files \"$1\" \"$2\")" }
function er () { emacsclient -n --eval "(find-file-read-only \"$1\")" }
function pe () { emacsclient -n $(pt "$@" | peco | awk -F : '{print "+" $2 " " $1}') }
function ae () { emacsclient -n $(ag "$@" | peco | awk -F : '{print "+" $2 " " $1}') }
function cls() { emacsclient -n $(find ./ -maxdepth 1 -type f | sort | peco ) }
function ccd() { cd "$(find . -maxdepth 1 -type d | peco)" }
# function up () { ~/.zsh.d/up.sh $1 }
# function gg () { cygstart "https://www.google.co.jp/search?q=${1}&ie=utf-8&oe=utf-8&hl=ja" }
# function alc () { cygstart "http://eow.alc.co.jp/search?q=${1}"}
# function vup { cd /home/vccw; vagrant up }
# function vlin { cd /home/vccw; vagrant ssh }
# function vsta { vagrant status }
# function vout { cd /home/vccw; vagrant halt }
function rampass {

local LEVEL=$1

case $LEVEL in
 'l1' ) cat /dev/urandom | tr -dc '[:digit:]' | fold -w $2 | head -n 10;;
 'l2' ) cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $2 | head -n 10;;
 'l3' ) cat /dev/urandom | tr -dc '[:alnum:]' | fold -w $2 | head -n 10;;
 'l4' ) cat /dev/urandom | tr -dc 'a-zA-Z0-9_!@#$%&?*+-=/\,.;:(){}[]|~^' | fold -w $2 | head -n 10;;
 'l5' ) cat /dev/urandom | tr -dc '[:graph:]' | fold -w $2 | head -n 10;;
 esac
}

source ~/.zsh.d/ssh.zsh

# function print_known_hosts (){
#   if [ -f $HOME/sever.txt ]; then
#     cat $HOME/sever.txt | cut -d' ' -f1
#   fi
# }
#_cache_hosts=($( print_known_hosts ))
#_cache_hosts=($( _hosts ))

# autoload ~/_ssh
# compdef _ssh ssh

function color256()
{
for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

zstyle ':mime:*' browser-style running x
zstyle ':mime:*' x-browsers


# function chpwd() {
#    #echo -ne "\ek$(basename $(pwd))\e\\"
#    less ~/cd_path_list.txt | awk -F: '{print $2 }' > ~/org_list.txt
#    echo $PWD >> ~/org_list.txt
#    rr ~/cd_path_list.txt
#    sort -u ~/org_list.txt | awk '{ print NR ":" $0}' > ~/cd_path_list.txt
#    rr ~/org_list.txt
#    _reg_pwd_screennum
# }

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
       [[  ${cmd} != (cd) && ${cmd} != (r[mr]) ]]
}

# 補完
#source ~/.zsh.d/incr.zsh

# if [ -f ~/.zsh.d/auto-fu.zsh/auto-fu.zsh ]; then
# source ~/.zsh.d/auto-fu.zsh/auto-fu.zsh
#     function zle-line-init () {
#         auto-fu-init
#     }
#     zle -N zle-line-init
#     zle -N zle-keymap-select auto-fu-zle-keymap-select

#     zstyle ':auto-fu:highlight' input bold
#     zstyle ':auto-fu:highlight' completion fg=black,bold
#     zstyle ':auto-fu:highlight' completion/one fg=red,bold
#     zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
#     zstyle ':auto-fu:var' postdisplay
# fi

# afu+cancel-and-accept-line() {
#     ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
#     zle afu+accept-line
# }
# zle -N afu+cancel-and-accept-line
# bindkey -M afu "^M" afu+cancel-and-accept-line

# source ~/.zsh.d/k/k.sh

source ~/.zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='none'

source ~/.zsh.d/zsh-history-substring-search/zsh-history-substring-search.zsh

#pecoでhistory検索
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^O' peco-select-history

#pecoでhistory検索
function peco-select-bd() {
  cd ..
}
zle -N peco-select-bd
bindkey '^U' peco-select-bd

#pecoでhistory検索
function peco-select-cd() {
  cd
}
zle -N peco-select-cd
bindkey '^T' peco-select-cd

#pecoでhistory検索
function peco-select-hd() {
  cd -
}
zle -N peco-select-hd
bindkey '^@' peco-select-hd

#pecoでkill
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"

# source ~/.zsh.d/zaw/zaw.zsh

# zstyle ':filter-select:highlight' selected fg=yellow,bg=black,standout
# zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに

# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
# zstyle ':chpwd:*' recent-dirs-max 5000
# zstyle ':chpwd:*' recent-dirs-default yes
# zstyle ':completion:*' recent-dirs-insert both

# function zaw-src-cdd () {
#     if [ -r "$CDD_PWD_FILE" ]; then
#         for window in `cat $CDD_PWD_FILE | sed '/^$/d'`; do
#             candidates+=("${window}")
#         done

#         actions=(zaw-src-cdd-cd)
#         act_descriptions=("cdd for zaw")
#     fi
# }

# function zaw-src-cdd-cd () {
#     BUFFER="cd `echo $1 | cut -d ':' -f 2`"
#     zle accept-line
# }

# zaw-register-src -n cdd zaw-src-cdd

# bindkey '^U' zaw-cdd

# function zaw-src-cdr () {
#     setopt local_options extended_glob
#     : ${(A)candidates::=${${(f)"$(cdr -l)"}##<-> ##}}
#     actions=(zaw-src-cdr-cd zaw-src-cdr-insert zaw-src-cdr-prune)
#     act_descriptions=("cd" "insert" "prune")
#     options+=(-m)
# }

# function zaw-src-cdr-cd () {
#     BUFFER="cd $1"
#     zle accept-line
# }

# function zaw-src-cdr-insert () {
#     [[ -z "$LBUFFER" ]] || LBUFFER+=" "
#     [[ "$LBUFFER[-1]" == " " ]] || LBUFFER+=" "
#     LBUFFER+="${(j. .)@}"
# }

# function zaw-src-cdr-prune () {
#     local -aU reply
#     autoload -Uz chpwd_recent_filehandler
#     chpwd_recent_filehandler
#     : ${(A)reply::=${reply:#(${(~j.|.)${~@}})}}
#     chpwd_recent_filehandler $reply
# }

# zaw-register-src -n cdr zaw-src-cdr

# bindkey '^T' zaw-cdr # zaw-cdrをbindkey
# bindkey '^O' zaw-history
# bindkey '^@' zaw

zmodload zsh/parameter

# 上のディレクトリに行く
#source ~/_ud

# function ud()
# {
#    to=$(perl -le '$p=$ENV{PWD}."/";$d="/".$ARGV[0]."/";$r=rindex($p,$d);\
#                   $r>=0 && print substr($p, 0, $r+length($d))' $1)
#    if [ "$to"="" ]; then
#        echo "no such file or directory: $1" 1>&2
#        return 1
#    fi
#    cd $to
# }

# treeからpecoで選択したファイルを開く
# function peco-tree-openfile(){
#   local SELECTED_FILE=$(tree --charset=o -f | peco | tr -d '\||`|-' | xargs echo)
#   BUFFER="emacsclient -n $SELECTED_FILE"
#   zle accept-line
# }
# bindkey "^V" peco-tree-openfile

source ~/.zsh.d/zsh-bd/bd.zsh
#source ~/.zsh.d/cli/cli.sh
source ~/.zsh.d/enhancd/init.sh

# export CDD_PWD_FILE=~/cd_path_list.txt

# function _reg_pwd_screennum() {
#  if [ "$STY" != "" ]; then
#    if [ ! -f "$CDD_PWD_FILE" ]; then
#      echo "\n" >> "$CDD_PWD_FILE"
#    fi
#    #_reg_cdd_pwd "$WINDOW" "$PWD"
#  fi
# }

# function _reg_cdd_pwd() {
#  if [ ! -f "$CDD_PWD_FILE" ]; then
#    echo "\n" >> "$CDD_PWD_FILE"
#    if [ $?=1 ]; then
#      echo "Error: Don't wrote $CDD_PWD_FILE."
#      return 1
#    fi
#  fi
#  sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
#  sed -i".t" -e "1i \\
# $1:$2" "$CDD_PWD_FILE"
# }

# function cdadd {
#  if [ -z "$1" ] || [ -z "$2" ]; then
#    echo "Usage: cdd add name path"
#    echo "Example: cdd add w ~/myworkspace"
#    return 1
#  fi

#  local -A real_path
#  if which realpath >/dev/null 2>&1;then
#    real_path=`realpath $2`
#  else
#    if which ruby >/dev/null 2>&1;then
#      real_path=`ruby -rpathname -e "puts Pathname.new('$2').realpath"`
#    else
#      echo "cdd add require realpath or ruby"
#    fi
#  fi
#  echo "add $1:$real_path"
#  _reg_cdd_pwd "$1" "$real_path"
# }

# function cddel() {
#  if [ -z "$1" ]; then
#    echo "Usage: cdd del name"
#    return 1
#  fi
#  sed -i".t" -e "/^$1:/d" "$CDD_PWD_FILE"
# }


# function cdd() {
#  if [ "$1" = "add" ]; then
#    shift
#    cdadd $@
#    return 0
#  elif [ "$1" = "del" ]; then
#    shift
#    cddel $@
#    return 0
#  fi

#  local -A arg
#  #arg=`echo $1|awk -F':' '{print \$1}'`
#  arg=`echo $1|cut -d':' -f1`
#  #grep "^$arg:" "$CDD_PWD_FILE" > /dev/null 2>&1
#  if grep "^$arg:" "$CDD_PWD_FILE" > /dev/null 2>&1 ;then
#    local -A res
#    res=`grep "^$arg:" "$CDD_PWD_FILE"|sed -e "s/^$arg://;"|tr -d "\n"`
#    echo "$res"
#    cd "$res"
#  else
#    sed -e '/^$/d' "$CDD_PWD_FILE"
#  fi
# }

# compctl -K _cdd cdd
# functions _cdd() {
#  NUM=`echo awk -F: '{print $1 }' ~/cd_path_list.txt`
#  reply=(`grep -v "^$NUM:" "$CDD_PWD_FILE"`)
# }

# shelltitleと組み合わせてbashでステータス行に各ウィンドウで打ったコマンドを表示させる
#for screen
preexec () {

# if [ $TERM="screen" ]; then
#       echo -ne "\ek${1%% *}\e\\"
# fi

#  if [ $TERM="xterm-256color" ]; then
#       echo -ne "\ek${1%% *}\e\\"
      #1="$1 " # deprecated.
      # echo -ne "\ek${${(s: :)1}[0]}\e\\"
      # echo -ne "\ek${${(s: :)1}[0]}\e\\"


       #echo -ne "\ek$(basename $(pwd))\e\\"

      #printf "\ek:$1\e\\"
 # fi
}

precmd() {
    if [ $TERM="screen" ]; then
       echo -ne "\ek$(basename $(pwd))\e\\"
    fi

    if [ $TERM="xterm-256color" ]; then
       #echo -ne "\ek$(basename $(pwd))\e\\"
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    fi
}

# history
# function anything-history() {
#     local tmpfile
#     tmpfile=`mktemp`
#     emacsclientw -nw --eval \
#         "(anything-zsh-history-from-zle \"$tmpfile\" \"$BUFFER\")"
#     if [[ -n "$STY" ]]; then
#         # screen 4.0.3 has a bug that altscreen doesn't work for emacs
#         (( `screen -v | cut -f 3 -d ' ' | cut -f 2 -d.` < 1 )) && zle -I
#     fi
#     zle -R -c
#     if [[ -n "$ANYTHING_HISTORY_DONT_EXEC" ]]; then
#         zle -U "`cat $tmpfile`"
#     else
#         BUFFER="`cat $tmpfile`"
#         [[ -n "$BUFFER" ]] && zle accept-line
#     fi
#     rm $tmpfile
# }
# zle -N anything-history
# bindkey "^H" anything-history

function dired () {
#WPWD=`cygpath -am $PWD`
 emacsclient -e "(dired \"$PWD\")"
}

function cde () {
   EMACS_CWD=`emacsclient -e "
    (expand-file-name
     (with-current-buffer
         (nth 1
              (assoc 'buffer-list
                     (nth 1 (nth 1 (current-frame-configuration)))))
       default-directory))" | sed 's/^"\(.*\)"$/\1/'`

   echo "chdir to $EMACS_CWD"
   cd "$EMACS_CWD"
}

unsetopt automenu
 compdef -d scp
 compdef -d rsync
 compdef -d tar
 compdef -d pkill
# compdef -d git

# function percol_select_history() {
#   local tac_cmd
#   which gtac &> /dev/null && tac_cmd=gtac || tac_cmd=tac
#   BUFFER=$($tac_cmd ~/.zsh_history | sed 's/^: [0-9]*:[0-9]*;//' \
#     | percol --match-method regex --query "$LBUFFER")
#   CURSOR=$#BUFFER         # move cursor
#   zle -R -c               # refresh
# }
# zle -N percol_select_history
# bindkey "^[^R" percol_select_history

# if which percol &> /dev/null; then
#   ## Complete file name by percol
#   autoload -Uz split-shell-arguments
#   autoload -Uz modify-current-argument
#   function complete-filename-by-percol() {
#     local CANDIDATES=""
#     local FILE=""
#     local DIR=""
#     local AMOUNT=""
#     local SELECTED=""
#     local ARG=""
#     local ARG_EXPAND=""
#     local NEW_ARG=""
#     local OLD_CURSOR=$CURSOR
#     local OLD_IFS=$IFS

#     ## Discriminate cursor position
#     split-shell-arguments
#     if [ $(($REPLY % 2)) -eq 0 ]; then # Cursor is on an argument
#       ARG=$reply[$REPLY]
#       CURSOR=$(($CURSOR + ${#reply[$REPLY]} - $REPLY2 + 1)) # Move to next to right end of an argument
#     else
#       zle backward-char
#       split-shell-arguments
#       if [ $(($REPLY % 2)) -eq 0 ]; then # Cursor is on right end of an argument
#         ARG=$reply[$REPLY]
#       fi    # Else argment is empty
#       zle forward-char
#     fi   #### If $ARG is ".", this function might not work well. ####
#     # Expand special keys and $HOME
#     ARG_EXPAND=$(echo -n "$ARG" | sed -e "s@~/@${HOME}/@" -e 's@\\\([[!#$&() ]\)@\1@g' \
#       -e 's@\\\([]*;<>^{|}~]\)@\1@g' -e "s@\\\\'@'@g")

#     ## List files
#     if [ "$ARG_EXPAND" = "" ] || [ -d "$ARG_EXPAND" ]; then # $ARG_EXPAND is a unique directory
#       DIR=${ARG_EXPAND%/}
#       FILE=""
#       CANDIDATES=$(ls -A $DIR 2> /dev/null)
#     else    # Divide an argument into DIR and FILE
#       if echo $ARG_EXPAND | grep '/' &> /dev/null; then
#         DIR=${ARG_EXPAND%/*}
#       else
#         DIR=""
#       fi
#       FILE=${ARG_EXPAND##*/}
#       CANDIDATES=$(ls -d ${ARG_EXPAND}* 2> /dev/null | sed "s@${DIR}/@@")
#     fi
#     AMOUNT=$(echo $CANDIDATES | wc -l)
#     if [ "$CANDIDATES" = "" ]; then # $CANDIDATES has no candidates
#       CURSOR=$OLD_CURSOR
#       zle -M "No candidates."
#       return 2
#     elif [ $AMOUNT -eq 1 ]; then # $CANDIDATES has a unique candidate
#       SELECTED=$CANDIDATES
#     elif [ $AMOUNT -ge 2 ]; then  # $CANDIDATES has many candidates
#       # select by percol
#       SELECTED=$(echo -n $CANDIDATES | percol --match-method migemo)
#       if [ $? -ne 0 ]; then   # When percol fail
#         CURSOR=$OLD_CURSOR
#         zle -R -c
#         return 1
#       fi
#     fi

#     ## Insert file(s) to command line
#     # Escape special keys an $HOME
#     SELECTED=$(echo -n $SELECTED | sed  -e 's@\([[!#&() ]\)@\\\1@g' \
#       -e 's@\([]*;<>^{|}~]\)@\\\1@g' -e "s@'@\\\\'@g" -e "s@${HOME}/@~/@g")
#     DIR=$(echo -n $DIR | sed  -e 's@\([[!"#&() ]}\)@\\\1@g' \
#       -e 's@\([]*;<>^{|}~]\)@\\\1@g' -e "s@'@\\\\'@g" -e "s@${HOME}/@~/@g")
#     # Separate with newline only
#     IFS=""
#     if [ "$DIR" = "" ] && [ "$FILE" = "" ]; then # An argument is empty
#       for file in $(echo -n $SELECTED); do
#         LBUFFER="$LBUFFER$file "
#       done
#     elif [ "$DIR" = "" ]; then
#       for file in $(echo -n $SELECTED); do
#         NEW_ARG="$NEW_ARG$file "
#       done
#       modify-current-argument $NEW_ARG
#       CURSOR=$(($CURSOR + ${#NEW_ARG} - ${#ARG}))
#     else  # $DIR is not empty
#       for file in $(echo -n $SELECTED); do
#         NEW_ARG="$NEW_ARG${DIR}/$file "
#       done
#       modify-current-argument $NEW_ARG
#       CURSOR=$(($CURSOR + ${#NEW_ARG} - ${#ARG}))
#     fi
#     IFS=$OLD_IFS
#     zle backward-delete-char  # Delete a trailing white space
#     zle -R -c
#   }
#   zle -N complete-filename-by-percol
#   bindkey '^J' complete-filename-by-percol
# fi

# function percol-cdr () {
#     local selected_dir=$(cdr -l | awk '{ print $2 }' | percol --query "$LBUFFER")
#     if [ -n "$selected_dir" ]; then
#         BUFFER="cd ${selected_dir}"
#         zle accept-line
#     fi
#     zle clear-screen
# }
# zle -N percol-cdr
# bindkey "^:" percol-cdr

# function peglobal() {
#     global $@ | percol | xargs less
#     }
# # enhancd
# if [ -f "/home/.enhancd/zsh/enhancd.zsh" ]; then
#     source "/home/.enhancd/zsh/enhancd.zsh"
# fi
