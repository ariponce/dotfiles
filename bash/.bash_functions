function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# Restart a service
function srvrestart {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: srvrestart <service_name>"
    else
        echo "Restarting $1..."
        sudo systemctl restart $1
    fi
}

# Show a service status
function srvstat {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: srvstat <service_name>"
    else
        sudo systemctl -l status $1
    fi
}

# Go up params directories
function up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

function allow {
  sudo chmod -R 775 ${2:-.}
}


function grab {
  sudo chown -R ${USER}:${1} ${2:-.}
}

function colorz {
  T='gYw'   # The test text

  echo -e "\n                 40m     41m     42m     43m\
       44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
}

function mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

function logview() {
    sudo tail -n200 $1
}

function topcommands() {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -nr | head
}


testingenv() {
    if [ -f .env ] && [ -f .env.testing ]; then
        mv .env .env.local
        mv .env.testing .env
     else
         echo "No .env or .env.testing file"
         die 1
     fi
}

localenv() {
    if [ -f .env ] && [ -f .env.local ]; then
        mv .env .env.testing
        mv .env.local .env
    else
        echo "No .env or .env.local file"
        die 1
    fi
}

wtf() {
    man $2
}

## WIKIPEDIA SEARCH FUNCTION ##
wikipediaSearch() {
	echo -n -e "\n============================================\n\tWelcome to WikiPedia Search"; echo ""; i=1 ; for line in $(lynx --dump "http://en.wikipedia.org/w/index.php?title=Special%3ASearch&profile=default&search=$1&fulltext=Search" | grep http://en.wikipedia.org/wiki | cut -c7-); do echo $i $line; lines[$i]=$line ;  i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

## ARCHWIKI SEARCH FUNCTION ##
archSearch() {
	echo -n -e "\n============================================\n\tWelcome to Arch Wiki Search"; echo ""; i=1 ; for line in $(lynx --dump "https://wiki.archlinux.org/index.php?title=Special%3ASearch&profile=default&search=$1" | grep https://wiki.archlinux.org/ | cut -c7-); do echo $i $line; lines[$i]=$line ; i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

#cd to dir of defined file | Usage: cdf <file>
cdf () {
  cd "$(dirname "$(locate -i "$*" | head -n 1)")" ;
}

#web search tool | Usage: gsearch <value>
	function gsearch {
	Q="$@";
	GOOG_URL='https://www.google.co.uk/search?tbs=li:1&q=';
	AGENT="Mozilla/4.0";
	stream=$(curl -A "$AGENT" -skLm 20 "${GOOG_URL}${Q//\ /+}" | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||');
	echo -e "${stream//\%/\x}";
}

#Is server up ? | Usage: down4me <www.foo.com>
down4me() {
	curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';
}

#internetinfo | Usage: ii
function ii()   # get current host related info
{
    echo -e "\n${RED}Kernel Information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    echo -e "\n${RED}Disk Usage :$NC " ; df -Th
    echo -e "\n${RED}LAN Information :$NC" ; netinfoLAN
    echo
}

#netinfo - shows LAN network information for your system (part of ii)
function netinfoLAN (){
	echo "---------------------------------------------------"
	/sbin/ifconfig enp3s0 | awk /'inet/ {print $2}'
	echo "---------------------------------------------------"
}

#Search files & directories | Usage: search <file/dirs>
search() {
	find . -iname "*$@*" | less;
}

phptags () {
    ctags -h ".php" -R                     \
        --exclude="\.svn"                            \
        --totals=yes                                 \
        --tag-relative=yes                           \
        --PHP-kinds=+cf                              \
        --regex-PHP='/abstract class ([^ ]*)/\1/c/'  \
        --regex-PHP='/interface ([^ ]*)/\1/c/'       \
        --regex-PHP='/trait ([^ ]*)/\1/c/'           \
        --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'
}


colorpal() {
for i in {0..255} ; do
	printf "\x1b[38;5;${i}mcolour${i}\n"
done
"]"
}

findhere() {
	grep --include=*.php -nwr $1 ./
}

findinproject() {
	grep --include=*.php -nwr $1 $2
}

hfind() {
	history | grep $1
}

ocinstaller() {
	git clone git@bitbucket.org:nexence-team/october-installer $1
}

tellme() {
	for i in $@; do
		$i;
	done
	notify-send -u normal "Shit's done!"
}

wrapper(){
    start=$(date +%s)
    "$@"
    [ $(($(date +%s) - start)) -le 3 ] || notify-send "Notification" "Long\ running command \"$(echo $@)\" took $(($(date +%s) - start)) seconds to finish"
}

# Cow-spoken fortunes every time you open a terminal
function cowsayfortune {
  NUMOFCOWS=`cowsay -l | tail -n +2 | wc -w`
  WHICHCOW=$((RANDOM%$NUMOFCOWS+1))
  THISCOW=`cowsay -l | tail -n +2 | sed -e 's/\ /\'$'\n/g' | sed $WHICHCOW'q;d'`

   #echo "Selected cow: ${THISCOW}, from ${WHICHCOW}"
   fortune -o | cowsay -f $THISCOW -W 100 | lolcat
}

# vim: set filetype=sh :
