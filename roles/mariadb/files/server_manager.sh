#!/usr/bin/env bash
#:***********************************************
#:Program: MariaDB Server start/stop script
#:
#:Author: lian-jihong@qq.com
#:
#:History: 2017-09-21
#:
#:Version: 1.0
#:***********************************************

#printf "##Start/ReStart MariaDB Server\n"
#printf "##Stop MariaDB Server\n"

mode=$1
user=root
passwd=password

function exec_find_pid()
{
  pid_nums=""
  pid_nums=`ps -ef|grep "$1"|grep -v grep|cut -c 9-15`
  echo $pid_nums
}

function exec_kill()
{
    pid_find_a=`exec_find_pid $1`
    if [[ ! $pid_find_a ]];then
        echo ''
    else
      /usr/local/mysql/bin/mysqladmin -u$user -p$passwd 'shutdown'
    fi
}

case $mode in
      'start')
        #Start/ReStart MariaDB Server
            exec_kill 'mysql'
            /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --user=mysql &
      ;;
      'restart')
        #Start/ReStart MariaDB Server
            exec_kill 'mysql'
            /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --user=mysql &
      ;;
      'stop')
        #stop MariaDB Server
            exec_kill 'mysql'
      ;;
      'galera_new_cluster')
        #Applies to initialize the master node for cluster
            exec_kill 'mysql'
            /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf --wsrep-new-cluster --user=mysql &
      ;;
      *)
        echo "Input error"
      ;;
esac