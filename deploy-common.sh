#!/usr/bin/env bash
# Common functions for deploy scripts

# these have to be present in deploy scripts
export CLICOLOR=1
git config --global http.sslVerify false

report_heading () {
    message="$1"
    echo -e "\e[0;31m[✭] ${message} [✭]\e[0m"
}

write_message () {
    message="$1"
    mkdir -p /tmp/report_progress_message
    echo "${message}" > /tmp/report_progress_message/message.txt
}

remove_message () {
    rm -rf /tmp/report_progress_message/
}

report_progress () {
  message=$1
  echo
  echo -e "\e[0;36m[..] ${message}\e[0m"
  write_message "${message}"
}

report_done () {
  message=$(</tmp/report_progress_message/message.txt)
  echo -e "\e[0;32m[✔︎]\e[0m \e[0;36m${message} ... \e[0m\e[0;32m[DONE]\e[0m"
  remove_message
}

get_os () {
  uname_s="$(uname -s)"
  if echo $uname_s | grep 'Darwin' >/dev/null
  then
    baseos='osx'
  else
    baseos='linux'
  fi
  echo $baseos
}
