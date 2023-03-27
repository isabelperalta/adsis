#!/bin/bash
#819535, Peralta Gonzalez, Isabel, M, 8, B
#818903, Martínez Vicens, Ismael, M, 8, B

echo -n "Introduzca el nombre del fichero: "

read nombreFichero

if test -f  $nombreFichero
then
	permisos=$( ls -l $nombreFichero )
	echo "Los permisos del archivo $nombreFichero son: ${buffer:1:3}"
else
	echo "$nombreFichero no existe"
fi
