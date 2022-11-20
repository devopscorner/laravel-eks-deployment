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

push_package() {
  for TEMPL in $HELM_TEMPLATE
  do
    msg_push $TEMPL
    helm s3 push $TEMPL*.tgz $HELM_REPO_NAME --force
    echo "- DONE -"
  done
}

msg_push() {
  echo ""
  print_line2
  get_time
  echo "$COL_BLUE[ $DATE ] ##### Push Package Helm : $1 "
  echo "$COL_GREEN[ $DATE ]       helm s3 push $1 $HELM_REPO_NAME --force $COL_END"
  print_line2
}

helm_update() {
  echo ""
  print_line2
  get_time
  echo "$COL_BLUE[ $DATE ] ##### Update Helm Repository : "
  echo "$COL_GREEN[ $DATE ]       helm repo update"
  helm repo update
  echo "- DONE -"
}

main() {
  header
  push_package
  helm_update
  footer
}

### START HERE ###
main $@
