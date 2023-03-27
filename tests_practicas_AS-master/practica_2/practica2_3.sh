#!/bin/bash
#819535, Peralta Gonzalez, Isabel, M, 3, B
#818903, Martínez Vicens, Ismael, M, 3, B
if [ $# -eq 1 ]
then
	if test -f  $1
	then
        	chmod u+x $1
		chmod g+x $1
		permisos=$( ls -l $1 )
        	echo ${permisos:0:9}
	else
        	echo "$1 no existe"
	fi
else
	echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi
