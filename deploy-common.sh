#!/usr/bin/env bash
# Common functions for deploy scripts

# these have to be present in deploy scripts
export CLICOLOR=1
git config --global http.sslVerify false

report_heading () {
    message="$1"
    echo -e "\e[0;31m[✭] ${message} [✭]\e[0m"
}

report_finished () {
    message="$1"
    echo
    echo -e "\e[0;32m[✭] ${message} [✭]\e[0m"
}

write_message () {
    message="$1"
    mkdir -p /tmp/report_progress_message
    echo "${message}" > /tmp/report_progress_message/message.txt
}

write_time () {
    start_time=$1
    mkdir -p /tmp/report_progress_message
    echo ${start_time} > /tmp/report_progress_message/starttime.txt
}


remove_report_progress () {
    rm -rf /tmp/report_progress_message/
}

report_progress () {
  message=$1
  start_time=$(date +%s)
  echo
  echo -e "\e[0;36m[..] ${message}\e[0m"
  write_message "${message}"
  write_time ${start_time}
}

report_done () {
  message=$(</tmp/report_progress_message/message.txt)
  start_time=$(</tmp/report_progress_message/starttime.txt)
  end_time=$(date +%s)
  echo -e "\e[0;32m[✔︎]\e[0m \e[0;36m${message} ... $(convertAndPrintRuntime ${end_time} ${start_time}) ... \e[0m\e[0;32m[DONE]\e[0m"
  remove_report_progress
}

convertAndPrintRuntime() {
    local totalSeconds=$(($1 - $2))
    local seconds=$((totalSeconds%60));
    local minutes=$((totalSeconds/60%60));
    local hours=$((totalSeconds/60/60%24));
    local days=$((totalSeconds/60/60/24));
    echo -n "finished in a time of "
    (( days > 0 )) && printf '%d days ' $days;
    (( hours > 0 )) && printf '%d hours ' $hours;
    (( minutes > 0 )) && printf '%d minutes ' $minutes;
    (( days > 0 || hours > 0 || minutes > 0 )) && printf 'and ';
    if ! [[ "${seconds}" = "1" ]]; then
        printf '%d seconds\n' $seconds;
    else
        printf '%d second\n' $seconds;
    fi
}

get_os () {
  uname_s="$(uname -s)"
  if echo $uname_s | grep 'Darwin' >/dev/null
  then
    baseos='osx'
  else
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
            baseos='windows'
        else
            baseos='linux'
        fi
  fi
  echo $baseos
}

