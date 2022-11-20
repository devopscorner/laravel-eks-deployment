#!/bin/sh

set -e

TITLE="HELM PACKAGE SCRIPT"          # script name
VER="2.2"                            # script version

HELM_VERSION="1.4.0-rc"
HELM_TEMPLATE="api \
  backend \
  configmap \
  frontend \
  secretref \
  stateful \
  svcrole
"
HELM_REPO_PATH="s3://devopscorner-helm-chart/lab"
HELM_REPO_NAME="devopscorner-lab"

COL_RED="\033[22;31m"
COL_GREEN="\033[22;32m"
COL_BLUE="\033[22;34m"
COL_END="\033[0m"

get_time() {
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
}

print_line0() {
  echo "$COL_GREEN=====================================================================================$COL_END"
}

print_line1() {
  echo "$COL_GREEN-------------------------------------------------------------------------------------$COL_END"
}

print_line2() {
  echo "-------------------------------------------------------------------------------------"
}

logo() {
  clear
  print_line0
  echo "$COL_RED'########:'########:'########:::'#######:::'######::::'#####:::'########:::'#######:: $COL_END"
  echo "$COL_RED..... ##:: ##.....:: ##.... ##:'##.... ##:'##... ##::'##.. ##:: ##.... ##:'##.... ##: $COL_END"
  echo "$COL_RED:::: ##::: ##::::::: ##:::: ##: ##:::: ##: ##:::..::'##:::: ##: ##:::: ##:..::::: ##: $COL_END"
  echo "$COL_RED::: ##:::: ######::: ########:: ##:::: ##: ##::::::: ##:::: ##: ##:::: ##::'#######:: $COL_END"
  echo "$COL_RED:: ##::::: ##...:::: ##.. ##::: ##:::: ##: ##::::::: ##:::: ##: ##:::: ##::...... ##: $COL_END"
  echo "$COL_RED: ##:::::: ##::::::: ##::. ##:: ##:::: ##: ##::: ##:. ##:: ##:: ##:::: ##:'##:::: ##: $COL_END"
  echo "$COL_RED ########: ########: ##:::. ##:. #######::. ######:::. #####::: ########::. #######:: $COL_END"
  echo "$COL_RED........::........::..:::::..:::.......::::......:::::.....::::........::::.......::: $COL_END"
  print_line1
  echo "$COL_BLUE# $TITLE :: ver-$VER $COL_END"
  echo "$COL_GREEN# HELM CHART          :: ver-$HELM_VERSION $COL_END"
  echo "$COL_GREEN# HELM REPO PATH      :: $HELM_REPO_PATH $COL_END"
  echo "$COL_GREEN# HELM REPO NAME      :: $HELM_REPO_NAME $COL_END"
}

header() {
  logo
  print_line0
  get_time
  echo "$COL_RED# BEGIN PROCESS..... (Please Wait)  $COL_END"
  echo "$COL_RED# Start at: $DATE  $COL_END"
}

footer() {
  echo ""
  print_line0
  get_time
  echo "$COL_RED# Finish at: $DATE  $COL_END"
  echo "$COL_RED# END PROCESS.....  $COL_END\n"
}

remove_old() {
  for TEMPL in $HELM_TEMPLATE
  do
    msg_remove $TEMPL
    rm -f $TEMPL-*.tgz
    echo "- DONE -"
  done
}

packaging() {
  for TEMPL in $HELM_TEMPLATE
  do
    msg_package $TEMPL
    helm package $TEMPL
    echo "- DONE -"
  done
}

msg_remove() {
  echo ""
  print_line2
  get_time
  echo "$COL_BLUE[ $DATE ] ##### Remove Old Package : $1 "
  echo "$COL_GREEN[ $DATE ]       rm -f $1-*.tgz $COL_END"
  get_time
  print_line2
}

msg_package() {
  echo ""
  print_line2
  get_time
  echo "$COL_BLUE[ $DATE ] ##### Packaging Helm : $1 "
  echo "$COL_GREEN[ $DATE ]       helm package $1 $COL_END"
  get_time
  print_line2
}

main() {
  header
  remove_old
  packaging
  footer
}

### START HERE ###
main $@
