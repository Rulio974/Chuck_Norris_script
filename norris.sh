#!/bin/bash

function help {
        echo "Script Chuck Norris."
        echo "Vous avez 5 options :"

        echo " -e : simple echo pour aider à comprendre getopts."
        echo " -h : affiche l'aide."
        echo " -t : affiche le nombre total de Chuck Norris facts disponibles."
        echo " -u : désigne le pseudo à utiliser pour remplacer Chuck Norris."
        echo " -n : désigne le numéro de la ligne à utiliser pour récréer un fait."
        
        echo "Attention : "
        echo " - Les options u et n doivent être activées ensemble !"
        echo " - La commande wc se base sur les retours charriots à la fin des lignes : "
        echo "   - Il y a une astuce pour compter le nombre de lignes avec wc sans craindre la dernière ligne."
        echo "   - Vous pouvez utiliser d'autres commandes."
        echo " - Les messages d'erreurs suivants doivent être utilisés : "
        echo "   - Le numéro de ligne n'est pas cohérent."
        echo "   - Il manque le numéro de ligne."
        echo "   - Il manque le pseudo."
}



#compteur nombre ligne
nb_ligne=0

#Creation de deux flags bool
boolu=false
booln=false 

#Format digit
number='^[0-9]+$'


#fonction qui recupere les nombre de lignes (sans le retour chariot) du fichier facts.txt
#se base sur le nombre de points
function grep_ligne {


	nb_ligne=$(grep "." facts.txt | wc -l) 

}

#gestion des options avec getopts
while getopts "the:u:n:" option
do
	case "$option" in
		"e")
			echo "${OPTARG}"
			;;
		"h")
			help
			;;
		"t")
		   grep_ligne
		   echo "$nb_ligne"


		    ;;
		"u")
			
			boolu=true 		# le flag a true
			arg_u="${OPTARG}"	# recupere l argument suivant -u
			if [ -z $"arg_u" ]	# verifie que l'argument n est pas null
			then
				echo "   - Il manque le pseudo."
				exit 1
			fi


			
		    ;;
		"n")
			
			booln=true		# le flag a true
			arg_n="${OPTARG}"	# Recupere l argument suivant -n
			if [ -z $"arg_n" ]	# verifie que l argument n est pas null
			then
				echo "   - Il manque le numéro de ligne."
				exit 1
			fi
			grep_ligne
			


			# verifie que l argument est un nombre positif
			if ! [[ $arg_n =~ $number ]] || [[ $arg_n = 0 ]] 
			then
				echo "   - Le numéro de ligne n'est pas cohérent."
				exit 1
			fi


			# verifie que le numero de ligne est inferieur
			# au nombre de ligne max
			if [ $arg_n -gt $nb_ligne ]
			then
				
				echo "   - Le numéro de ligne n'est pas cohérent."
				exit 1;
			fi


		    ;;

		*)
		    help
		    ;;


	esac
done


if [ $booln = true ] && [ $boolu = false ]
then 
	echo "   - Il manque le pseudo."
	exit 1
fi

if [ $booln = false ] && [ $boolu = true ]	 
then
	echo "   - Il manque le numéro de ligne."
	exit 1

fi


# Verifie 

if [ $booln = true ] && [ $boolu = true ]
then 
	
	echo "Chuck Norris est remplace par '$arg_u' a la ligne $arg_n "
	#cat facts.txt | awk  '{ sub(/'$CN'/,"Jules");print}' 
	sed ''$arg_n' s/Chuck Norris/'$arg_u'/' facts.txt
elif [ $booln = false ] && [ $boolu = false ]; then echo ""



fi


exit 0
