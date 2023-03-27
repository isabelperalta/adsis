#!/bin/bash
#775227, Loscertales Litauszky, Guillermo, M, 3, B
#816473, Lizama Moreno, Jesus, M, 3, B

#Este script lee el archivo pasado como segundo parametro y añade o borra los usuarios alli especificados
#
#El archivo tiene que tener el formato:
#				nombre1,contraseña1,nombrecompleto1
#				nombre2,contraseña2,nombrecompleto2
#				...
#				...
#	Si se van a borrar usuarios tambien se puede usar:
#				nombre1
#				nombre2
#				...
#OPCIONES:
#		-a: Anadir ususarios
#		-s: Borrar usuarios
##
if [ "$UID" -ne 0 ]
then
	echo Este script necesita privilegios de administracion
	exit 1
elif	[ $# -ne 2  ]
then
	echo Numero incorrecto de parametros
else
	if [ "$1" = "-a" ]
	then
		#OPCION ANADIR USUARIOS
		
		#Leer el archivo
		OldIFS=$IFS
		IFS=,
		cat "$2" | while read nombre password nombrecomp 
		do
			if [ "$nombre" = "" -o  "$password" = "" -o "$nombrecomp" = "" ]
			then
				echo Campo invalido
				exit
			else
			##Anadir usuario
			useradd -c "$nombrecomp" -m -k /etc/skel -U -K UID_MIN=1815 "$nombre" 2>/dev/null
				if [ $? = 0 ]
				then
					#Si useradd no es erroneo, se cambia el password y se modifica el numero de dias que
					#la cuenta puede estar inactiva
					echo "$nombre":"$password" | chpasswd
					usermod -f 30 "$nombre"
					echo  "$nombrecomp" ha sido creado
				else
					echo El usuario "$nombre" ya existe
				fi
			fi
		done
		IFS=$OldIFS
	elif [ "$1" = "-s" ]
	then
		#OPCION BORRAR USUARIOS
		
		##opcion -p para que cree el directorio padre(/extra) y ademas si ya esta creado el directorio no saca error
		mkdir -p /extra/backup
		OldIFS=$IFS
		IFS=,
		cat "$2" | while read nombre ignorar ignorar
		do
		#Leer el home del usuario a borrar desde el archivo passwd
		userhome=$(grep "$nombre" /etc/passwd | cut -d ":" -f6) #: delimitador entre palabras y lee la sexta
		#Comprimir y mover el home
		if tar -cf "$nombre".tar "$userhome" 2>/dev/null  && mv "$nombre".tar /extra/backup 
		then
		#borrar el usuario
		userdel -r "$nombre" 2>/dev/null
		fi
		done
		IFS=$OldIFS
	else
		echo Opcion invalida >&2
	fi
fi






