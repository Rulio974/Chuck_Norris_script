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



function grep_ligne {

	nb_ligne=$(grep "." facts.txt | wc -l) 

}


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
			
			boolu=true
			arg_u="${OPTARG}"
			if [ -z $"arg_u" ]
			then
				echo "   - Il manque le pseudo."
				exit 1
			fi


			
		    ;;
		"n")
			
			booln=true
			arg_n="${OPTARG}"
			if [ -z $"arg_n" ]
			then
				echo "   - Il manque le numéro de ligne."
				exit 1
			fi
			grep_ligne
			


			#si l'argument n est pas un nombre, on quitte
			if ! [[ $arg_n =~ $number ]] || [[ $arg_n = 0 ]]
			then
				echo "   - Le numéro de ligne n'est pas cohérent."
				exit 1
			fi


			#verifie le numero de ligne
			if [[ $arg_n > $nb_ligne ]]
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


#Si les deux flags sont vrais, on remplace
#Sinon, on exit 


if [ $booln = true ] && [ $boolu = true ]
then 
	
	echo "Chuck Norris est remplace par '$arg_u' a la ligne $arg_n "
	#cat facts.txt | awk  '{ sub(/'$CN'/,"Jules");print}' 
	sed ''$arg_n' s/Chuck Norris/'$arg_u'/' facts.txt
elif [ $booln = false ] && [ $boolu = false ]; then echo ""

else
	echo " - Les options u et n doivent être activées ensemble !"

fi







exit 0
