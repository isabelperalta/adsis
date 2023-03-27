#!/bin/bash
#819535, Peralta Gonzalez, Isabel, M, 3, B
#818903, Martínez Vicens, Ismael, M, 3, B

for archivo in "$@"
do
	if test -f $archivo
		then more $archivo
	else
		echo "$archivo no es un fichero"
	fi
done
