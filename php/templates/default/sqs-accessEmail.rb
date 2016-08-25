#!/bin/bash
# Versao 0.1
#set -x

DAEMON_PATH="/srv/www/<%= @app_name %>/current"

DAEMON=sqs-accessEmail

NAME=sqs-accessEmail
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

case "$1" in
start)
	printf "%-10s" "Iniciando $NAME..."
	#Entra na pasta
	cd $DAEMON_PATH
	#Executa o comando de start
        su - deploy -c "/srv/www/<%= @app_name %>/current/artisan queue:work sqs --sleep=10 --daemon --quiet --tries=3 --env=local --queue='accessEmail' &" 

echo "start - `date`" >> /var/log/sqs-accessEmail.log

	sleep 5;
	#PID do processo pai
	PID=`ps -ef | grep  accessEmail | grep sqs | grep -v grep | awk {'print $2'}`
	echo $PID > $PIDFILE

	#echo "Salvo PID" $PID " to " $PIDFILE
        if [ -z $PID ]; then
            printf "%s\n" "Fail"
        else
            echo $PID > $PIDFILE
            printf "%s\n" "Ok"
        fi
;;
status)
echo "status - `date`" >> /var/log/sqs-accessEmail.log
        printf "%-5s" "Checking $NAME..."
        if [ -f $PIDFILE ]; then
	PID=`ps -ef | grep  accessEmail | grep sqs | grep -v grep | awk {'print $2'}`
	PID=$PID+`ps -ef | grep  accessEmail | grep sqs | grep -v grep | awk {'print $2'} >> $PIDFILE`
            if [ -z "$PID" ]; then
                printf "%s\n" "Processo morto mas o pid existe"
            else
                echo "running"
            fi
        else
            printf "%s\n" "service not running"
        fi
;;
stop)
        printf "%-5s" "Parando $NAME"
echo "stop - `date`" >> /var/log/sqs-accessEmail.log

PID=`ps -ef | grep  accessEmail | grep sqs | grep -v grep | awk {'print $2'}`
            kill -QUIT $PID && rm -rf $PIDFILE && printf "%s\n" "Ok"
;;

restart)
        /etc/init.d/sqs-accessEmail stop
	sleep 10;
        /etc/init.d/sqs-accessEmail start
;;

*)
        echo "Usage: $0 {status|start|stop|restart}"
        exit 1
esac
