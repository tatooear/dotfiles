#/bin/zsh
# -*- shell-script -*-

#export HOME=/home/

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
bindkey "^?" backward-delete-char

export LANG=ja_JP.UTF-8

export LESS="-RNS"
#export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
#export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
export LESSOPEN=""

export PAGER="less"

export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=36:ln=32:bn=32:se=01;33"

#export GTAGSLABEL="exuberant-ctags"

#export ANDROID_HOME=/home/tatooear/android-sdk-linux/
#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386/

#export PATH=$PATH:/home/tatooear/android-sdk-linux/tools/:/home/tatooear/android-sdk-linux/platform-tools/

#export PATH=$PATH:/home/owner/program/android/android-sdk-linux/tools
#export HOME=/var/tmp/toku

eval `dircolors ~/.dir_colors`

#autoload -U compinit
#compinit

autoload colors
colors

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

alias grep="grep --color=always"
alias fgrep="fgrep --color=always"
alias egrep="egrep --color=always"
alias zgrep="zgrep --color=always"
alias lgrep="lgrep --color=always"
alias rsync="rsync -av"
alias scp="scp -rp"
alias ack="ack --color"
alias ag="ag -r --color"
alias zmv="noglob zmv -W"
alias vl="/usr/share/vim/vim73/macros/less.sh"
alias diff="colordiff --strip-trailing-cr"
alias sdiff="sdiff --strip-trailing-cr"

alias ls="ls --color=always --time-style=+'%Y/%m/%d %H:%M'"
alias la="ls -lah"
alias ltr="ls -ltarh"
alias ll="ls -lh"
alias sls="ls -lahS"
alias em="emacs"
alias rr="rm -rf"
alias rm="rm -i"
alias cp="cp -ip"
alias mv="mv -i"
alias bd="cd -"
alias mk="mkdir"
alias op="cygstart"
alias en="emacsclient -n"
alias ed="emacs --deamon"
alias dvp="tar xfzv"
alias cmp="tar cfzv"
alias hi="history -nir 0"

alias -g L="| less"
alias -g T="| tail"
alias -g G="| grep"
alias -g N="| nkf -w"
alias -g W="| wc -l"
alias -g H="| --help | less"
alias -g XG="| xrags grep"

#source ~/.zsh.d/ssh.zsh

function ecmp () { tar czvf $1 --exclude $2 }
function tl () { tar czlf - $1 | tar tzvf - | less }
function jl () { less $1 | nkf -w | less }
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
function gg () { cygstart "https://www.google.co.jp/search?q=${1}&ie=utf-8&oe=utf-8&hl=ja" }
function alc () { cygstart "http://eow.alc.co.jp/search?q=${1}"}

function dired () {
 WPWD=`cygpath -am $PWD`
 emacsclient -e "(dired \"$WPWD\")"
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

function ptem () {
   emacsclient -n $(pt "$@" | peco --query "$LBUFFER" | awk -F : '{print "+" $2 " " $1}')
}

function agem () {
   emacsclient -n $(ag "$@" | peco --query "$LBUFFER" | awk -F : '{print "+" $2 " " $1}')
}

zstyle ':mime:*' browser-style running x
zstyle ':mime:*' x-browsers

zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## peco

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^s' peco-select-history

function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^r' peco-cdr
