#!/usr/bin/env bash


declare -a __opts=(extglob xpg_echo globstar expand_aliases)
declare -a __msgs=("\nshopt must support:")
for __o in "${__opts[@]}"; do __msgs+="\n  $__o"; done; unset __o
shopt -s "${__opts[@]}" || { echo -e "${__msgs[@]}" 1>&2; exit 1; }
unset __msgs __opts


for x in awk cp egrep fgrep find grep readlink sed \
  sha1sum sha224sum sha256sum sha384sum sha512sum
do
  which "g$x" >/dev/null 2>/dev/null && eval "alias $x=g$x"
done


sp=$(echo -e "[ \t]")
tb=$(echo -e "\t")


function prfx     () { local p="${1//\//\\/}" m; shift; for m in "$@"; do echo -e "$m" | sed -e "s/^/$p/" 1>&2; done; }
function info     () { echo '# info:  ' 1>&2 ; prfx '    ' "$@"; }
function rprt     () { info "$@"; }
function warn     () { prfx 'warn:  ' "$@" 1>&2; }
function barf     () { warn "$@"; return 1; }
function die      () { prfx 'die:  '  "$@" 1>&2; exit 1; }
function a2s      () { local -a s; local a; for a in "$@"; do s+=("'$a'"); done; echo "${s[@]}"; }
function cdod     () { local d="$1" ; cd "$d" || die "Could not:" "  cd '$d'"; }
function nl2se    () { echo '' 1>&2; }
function nl2so    () { echo ''; }
function now      () { date +'%Y%m%dT%H%M%S'; }
function today    () { date +'%Y%m%d'; }
function is_win   () { [ -n "$WINDIR" ]; }
function un_lc    () { uname | tr A-Z a-z; }
function is_lnx   () { [ `un_lc` = linux ]; }
function is_osx   () { [ `un_lc` = darwin ]; }
function mvim     () { command mvim -p "$@"; }
function gvo      () { mvim -M "$@"; }
function nl2se    () { echo "" 1>&2; }
function srm      () { shred -u -n 8 "$@"; }
# function mac_only () { [ ! is_osx ] || die "Only available on Mac OS."; }
# function not_win  () { is_win && die "Only available on Unix."; }
# function win_only () { is_win || die "Only available on Windows/Cygwin."; }
# mac_only
# not_win
# win_only


bin_dir="$(cd "$(dirname "$(readlink -f "$0")")" && pwd -P)"
top_dir="$(dirname "$bin_dir")"


dry=false
# # TODO
dry=true
help=false
out_dir="$PWD"
today=$(date +'%Y%m%d')
verbose=false
while getopts ':O:Yhvy' opt; do # {{{1
  case $opt in
    O)
      out_dir="$OPTARG"
      ;;
    Y)
      dry=false
      ;;
    h)
      help=true
      ;;
    v)
      verbose=true
      ;;
    y)
      dry=true
      ;;
    *)
      die "Invalid option:  $(eval "echo \"'\$$((OPTIND - 1))'\"")"
      ;;
  esac
done
shift $((OPTIND - 1))
$dry && verbose=true




if $help; then # {{{1
  cat <<EOHELP

Script name:

  $0

Description:

  TODO

Usage:

  $0 [-O out_dir] [-Y] [-h] [-v] [-y]

Flags:

  -O out/dir
      Set the output directory.  Defaults to '\$PWD'
  -Y
      Not a dry run.  Use if dry run is defaulted to true.
  -h
      Display this help message, then exit with success.
  -v
      Verbose mode.
  -y
      Dry run.  Automatically enables verbose mode.

EOHELP
  exit 0
fi




# functions # {{{1


function short_rest () {
  local -i r=$(($RANDOM % 5 + 3))
  info "Sleeping for $r seconds"
  sleep $r
}

function ber () {
  $verbose && info "$dry || bundle exec rails $*"
  # $dry || bundle exec rails "$@"
}

function generate () { ber generate "$@"; }
function controller () { generate controller "$@"; }
function resource () { generate resource "$@"; }
function scaffold () { generate scaffold "$@"; }


# defaults # {{{1




# code # {{{1


cdod "$top_dir"


controller home index

# Has models:
scaffold zip_code 'code:string{5}:uniq'
short_rest
scaffold state 'abbreviation:string{2}:uniq' 'name:string'
short_rest
scaffold address 'line_1:string' 'line_2:string' 'city' 'state:references' 'zip_code:references'


# vim: ft=sh fdm=marker fdl=4 sw=2 sts=2 ts=8 et
