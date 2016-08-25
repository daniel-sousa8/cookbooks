#!/bin/bash
# Versao 0.1
#set -x

DAEMON_PATH="/srv/www/api/current"

DAEMON=redis-integration

NAME=redis-integration
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

case "$1" in
start)
	printf "%-10s" "Iniciando $NAME..."
	#Entra na pasta
	cd $DAEMON_PATH
	#Executa o comando de start
        su - deploy -c "/srv/www/api/current/artisan queue:work redis --sleep=10 --daemon --quiet --tries=3 --env=local --queue='integration' &" 

echo "start - `date`" >> /var/log/redis-integration.log

	sleep 5;
	#PID do processo pai
	PID=`ps -ef | grep  integration | grep redis |grep -v grep | awk {'print $2'}`
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
echo "status - `date`" >> /var/log/redis-integration.log
        printf "%-5s" "Checking $NAME..."
        if [ -f $PIDFILE ]; then
	PID=`ps -ef | grep  integration | grep redis |grep -v grep | awk {'print $2'}`
	PID=$PID+`ps -ef | grep  integration | grep redis |grep -v grep | awk {'print $2'} >> $PIDFILE`
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
echo "stop - `date`" >> /var/log/redis-integration.log

PID=`ps -ef | grep  integration | grep redis |grep -v grep | awk {'print $2'}`
            kill -QUIT $PID && rm -rf $PIDFILE && printf "%s\n" "Ok"
;;

restart)
        /etc/init.d/redis-integration stop
	sleep 10;
        /etc/init.d/redis-integration start
;;

*)
        echo "Usage: $0 {status|start|stop|restart}"
        exit 1
esac
