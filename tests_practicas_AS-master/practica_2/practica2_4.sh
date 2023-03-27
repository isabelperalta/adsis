#!/bin/bash
#819535, Peralta Gonzalez, Isabel, M, 3, B
#818903, Martínez Vicens, Ismael, M, 3, B

echo -n "Introduzca una tecla: "
read tecla

case ${tecla:0:1} in
	[0-9])
		echo "${tecla:0:1} es un numero" ;;
	[a-zA-Z])
		echo "${tecla:0:1} es una letra" ;;
	*)
		echo "${tecla:0:1} es un caracter especial" ;;
esac
