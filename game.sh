#!/bin/bash
clear

###################################### FUNCIONES DENTRO DEL JUEGO ##########################################

function tirar_dados {
	DADO1=$[1+RANDOM%6]
	DADO2=$[1+RANDOM%6]
	let SUMADADOS=$DADO1+$DADO2
}

function orcoataque {
	DADOATAQUEMOUNSTRO1=$[1+RANDOM%6]
	DADOATAQUEMOUNSTRO2=$[1+RANDOM%6]
	DADOATAQUEMOUNSTRO3=$[1+RANDOM%6]
	let SUMADADOSATAQUEMOUNSTRO=$DADOATAQUEMOUNSTRO1+$DADOATAQUEMOUNSTRO2+$DADOATAQUEMOUNSTRO3
}

function orcodefensa {
	DADODEFENSAMOUNSTRO1=$[1+RANDOM%6]
	DADODEFENSAMOUNSTRO2=$[1+RANDOM%6]
	let SUMADADOSDEFENSAMOUNSTRO=$DADODEFENSAMOUNSTRO1+$DADODEFENSAMOUNSTRO2
}

function trolataque {
	DADOATAQUEMOUNSTRO1=$[1+RANDOM%6]
	DADOATAQUEMOUNSTRO2=$[1+RANDOM%6]
	let SUMADADOSATAQUEMOUNSTRO=$DADOATAQUEMOUNSTRO1+$DADOATAQUEMOUNSTRO2
}

function troldefensa {
	DADODEFENSAMOUNSTRO1=$[1+RANDOM%6]
	let SUMADADOSDEFENSAMOUNSTRO=$DADODEFENSAMOUNSTRO1
}

function esqueletoataque {
	DADOATAQUEMOUNSTRO1=$[1+RANDOM%6]
	let SUMADADOSATAQUEMOUNSTRO=$DADOATAQUEMOUNSTRO1
}

function esqueletodefensa {
	DADODEFENSAMOUNSTRO1=$[1+RANDOM%6]
	DADODEFENSAMOUNSTRO2=$[1+RANDOM%6]
	let SUMADADOSDEFENSAMOUNSTRO=$DADODEFENSAMOUNSTRO1+$DADODEFENSAMOUNSTRO2
}

function ataque {
	DADOEXTRADEFENSAJUGADOR=0
	DADOATAQUEJUGADOR1=$[1+RANDOM%6]
	DADOATAQUEJUGADOR2=$[1+RANDOM%6]
	DADOATAQUEJUGADOR3=$[1+RANDOM%6]
	
	let SUMADADOSATAQUEJUGADOR=$DADOATAQUEJUGADOR1+$DADOATAQUEJUGADOR2+$DADOATAQUEJUGADOR3
			
	if [ $TIPOMOUNSTRO -eq 1 ]; then
		orcodefensa
	fi
			
	if [ $TIPOMOUNSTRO -eq 2 ]; then
		troldefensa
	fi
			
	if [ $TIPOMOUNSTRO -eq 3 ]; then
		esqueletodefensa
	fi
			
	echo "Dados jugador= $SUMADADOSATAQUEJUGADOR"
	echo "Dados mounstro= $SUMADADOSDEFENSAMOUNSTRO"
			
	if [ $SUMADADOSATAQUEJUGADOR -gt $SUMADADOSDEFENSAMOUNSTRO ]; then
		let VIDAMOUNSTRO=$VIDAMOUNSTRO-1
		echo "........................................"
		echo "El mounstro ha muerto. Gana el jugador | (PRESIONA ENTER)"
		read -p "........................................"
	else
		echo "........................................"
		echo "El mounstro se ha defendido | (PRESIONA ENTER)"
		read -p "........................................"
	fi
}

function defensa {
	DADOEXTRADEFENSAJUGADOR=$[1+RANDOM%6]
	let PASOS=$PASOS+5
	echo "........................................"
	echo "El jugador se ha defendido. Ha retrocedido 5 pasos. | (PRESIONA ENTER)"
	read -p "........................................"
}

function turno_mounstro {
	if [ $TURNOMOUNSTRO -eq 1 ] && [ $VIDAMOUNSTRO -eq 1 ]; then
			DADODEFENSAJUGADOR1=$[1+RANDOM%6]
			DADODEFENSAJUGADOR2=$[1+RANDOM%6]
			DADODEFENSAJUGADOR3=$[1+RANDOM%6]
			let SUMADADOSDEFENSAJUGADOR=$DADODEFENSAJUGADOR1+$DADODEFENSAJUGADOR2+$DADODEFENSAJUGADOR3+$DADOEXTRADEFENSAJUGADOR
			
		if [ $TIPOMOUNSTRO -eq 1 ]; then
			orcoataque
		fi
			
		if [ $TIPOMOUNSTRO -eq 2 ]; then
			trolataque
		fi
			
		if [ $TIPOMOUNSTRO -eq 3 ]; then
			esqueletoataque
		fi
			
		echo "Dados jugador= $SUMADADOSDEFENSAJUGADOR"
		echo "Dados mounstro= $SUMADADOSATAQUEMOUNSTRO"
			
		if [ $SUMADADOSATAQUEMOUNSTRO -gt $SUMADADOSDEFENSAJUGADOR ]; then
			let VIDA=$VIDA-1
			echo "........................................"
			echo "El mounstro ha ganado. El jugador ha perdido. Le quedan $VIDA vidas | (PRESIONA ENTER)"
			read -p "........................................"
		else
			echo "........................................"
			echo "El jugador ha ganado la defensa | (PRESIONA ENTER)"
			read -p "........................................"
		fi
			
		let TURNOMOUNSTRO=0
	else
		let TURNOMOUNSTRO=1
	fi
}

function comprobar_vida_jugador {
	if [ $VIDA -eq 0 ]; then
		perdiste
	fi
}

function batalla {
	VIDAMOUNSTRO=1
	TURNOMOUNSTRO=0
	while [ $VIDAMOUNSTRO -gt 0 ]; do
		
		echo "........................................"
		echo "Pasos= $PASOS"
		echo "Vida= $VIDA"
		echo "........................................"
		echo "INTRODUCE: 1 = PARA ATACAR | 2 = PARA DEFENDER"
		read -n 1 -p "........................................ = " ACCIONJUGADOR
		echo
		
		case $ACCIONJUGADOR in
		1)
			ataque
			turno_mounstro
			comprobar_vida_jugador
			;;
		2)
			defensa
			turno_mounstro
			comprobar_vida_jugador
			;;
		*)
			echo
			echo "........................................"
			echo "NO HAS REALIZADO NINGUNA ACCION | (PRESIONA ENTER)"
			read -p "........................................"
			;;
		esac
	done
}

function ganaste {
	echo "........................................"
	echo "	 ¡HAS GANADO! :) | (PRESIONA ENTER PARA FINALIZAR)"
	echo "¿QUIERES VOLVER A INTENTARLO? | 1 = SI | 2 = NO"
	read -n 1 -p "........................................ = " ELECCION
	case $ELECCION in
	1)
		sh ejercicio_7.2b.sh
		exit
		;;
	2)
		echo
		exit
		;;
	*)
		echo
		echo "........................................"
		echo "NO HAS REALIZADO NINGUNA ACCION | (PRESIONA ENTER)"
		read -p "........................................"
		echo
		ganaste
		;;
	esac
}

function perdiste {
	echo "........................................"
	echo "¡HAS PERDIDO! :( ¿QUIERES VOLVER A INTENTARLO?"
	echo "¿QUIERES VOLVER A INTENTARLO? | 1 = SI | 2 = NO"
	read -n 1 -p "........................................ = " ELECCION
	case $ELECCION in
	1)
		sh game.sh
		exit
		;;
	2)
		echo
		exit
		;;
	*)
		echo "........................................"
		echo "NO HAS REALIZADO NINGUNA ACCION | (PRESIONA ENTER)"
		read -p "........................................"
		echo
		perdiste
		;;
	esac
}

###################################### VARIABLES INICIALES ##########################################

PASOS=60
VIDA=4

###################################### AQUI COMIENZA EL VIDEOJUEGO ##########################################

echo "........................................"
echo "¡ COMIENZA EL VIDEOJUEGO"
echo "PASOS INICIALES = $PASOS"
echo "VIDA INICIAL = $VIDA"
echo "(PRESIONA ENTER)"
read -p "........................................"
echo

while [ $PASOS -gt 0 ] && [ $VIDA -gt 0 ]; do
	
	echo "........................................"
	echo "Tira los dados | (PRESIONA ENTER)"
	read -p "........................................"
	echo
	
	tirar_dados
	let PASOS=$PASOS-$SUMADADOS
	
	if [ $PASOS -lt 0 ]; then
		let PASOS=0
	fi 
	
	echo "........................................"
	echo "1º DADO = $DADO1 | 2º DADO = $DADO2 | ¡Has avanzado $SUMADADOS pasos!"
	echo "Pasos restantes: $PASOS | (PRESIONA ENTER)" 
	read -p "........................................"
	echo
	
	APARECEMOUNSTRO=$[0+RANDOM%2] #APARECE UN MOUNSTRO SI SALE UN 1 (YA SEA UN ORCO, UN TROL O UN ESQUELETO) Y NO APARECE SI SALE UN 0
	if [ $PASOS -gt 0 ]; then
	
		if [ $APARECEMOUNSTRO -eq 1 ]; then
		
			TIPOMOUNSTRO=$[1+RANDOM%3] #1-ORCO || 2-TROL || 3-ESQUELETO
		
			if [ $TIPOMOUNSTRO -eq 1 ]; then
			
				echo "........................................"
				echo "¡APARECIO UN MOUNSTRO! ¡ES UN ORCO! | (PRESIONA ENTER)"
				read -p "........................................"
				
			fi
		
			if [ $TIPOMOUNSTRO -eq 2 ]; then
			
				echo "........................................"
				echo "¡APARECIO UN MOUNSTRO! ¡ES UN TROL! | (PRESIONA ENTER)"
				read -p "........................................"
				
			fi
		
			if [ $TIPOMOUNSTRO -eq 3 ]; then
			
				echo "........................................"
				echo "¡APARECIO UN MOUNSTRO! ¡ES UN ESQUELETO! | (PRESIONA ENTER)"
				read -p "........................................"
			
			fi
			
			batalla
		
		else
	
			echo "........................................"
			echo "No aparecio ningun mounstro | (PRESIONA ENTER)"
			read -p "........................................"
			echo
		
		fi
	
	fi

done

ganaste
