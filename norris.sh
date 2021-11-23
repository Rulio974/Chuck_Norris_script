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
				echo "   - Il manque le pseudo#!/bin/bash


function help {
        echo "Script Chuck Norris."
        echo "Vous avez 5 options :"

        echo " -e : simple echo pour aider à comprendre getopts."
        echo " -h : affiche l'aide."
        echo " -t : affiche le nombre total de Chuck Norris facts disponibles."
        echo " -u : désigne le pseudo à utiliser pour remplacer Chuck Norris."
        echo " -n : désigne le numéro de la ligne à utiliser pour récréer un fait."
        echo " -l : affiche une nouvelle fact au hasard."
        echo " -r : Remet a zero les facts."
        echo " -s : Enregistre la fact aléatoire dans la liste officielle."
        
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

#Creation de trois flags 
boolu=false
booln=false 
bools=false
booll=false

#Format digit
number='^[0-9]+$'

n_fact=""




#fonction qui recupere les nombre de lignes (sans le retour chariot) du fichier facts.txt
#se base sur le nombre de points
function grep_ligne {


	nb_ligne=$(grep "." facts.txt | wc -l) 

}

#gestion des options avec getopts
while getopts "srthe:u:n:al" option
do
	case "$option" in
		"s")
			bools=true


			;;

		"l")
			booll=true

			;;


		"a")
			echo "Tapez le fact a ajouter"
			read input_fact

			echo "$input_fact">>facts.txt

			;;
		"e")
			echo "${OPTARG}"
			;;
		"h")
			help
			;;

		"r")
			echo "Voulez vous remettre les facts a zero ? Y or N "
			read input


			if [[ $input = 'Y' ]]
			then
				cp facts_2.txt facts.txt
				echo "facts.txt a ete reinitialise !"

			fi
				

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
	sed ''$arg_n' s/Chuck Norris/'$arg_u'/' facts.txt

elif [ $booln = false ] && [ $boolu = false ]; then echo ""



fi

if [ $booll = true ]
then 
	curl -s http://chucknorrisfacts.fr > web_page.txt 		# Recupere contenu page web
	html2text web_page.txt > web_page_text.txt  			# Transformer le contenu en texte
	cat -t web_page_text.txt 1> /dev/null				# Supprime les caracreres speciaux et invisibles
	grep -i "Chuck Norris" web_page_text.txt > new_facts.txt
	sed '/Chuck Norris Facts -Fr/d' new_facts.txt 1> /dev/null
	n_fact=$(shuf -n 1 new_facts.txt)
	echo "$n_fact"

fi

if [ $booll = true ] && [ $bools = true ]
then
	echo "Voulez vous enregister cette facts ? Y or N "
	read input_save
	if [ $input_save != 'Y' ]
	then
		exit 1
	fi


	test=$(grep "$n_fact" facts.txt) 	# verifie que la fact n'a pas déjà été enregsitre
	if [ -z "$test" ] 			
	then
		echo "$n_fact" >> facts.txt 	# enregistre la fact dans le fichier facts.txt
		echo "fact enregistre !"
	else
		echo "Cete fact a deja ete enregistre ! "
		exit 1;
	fi



elif [ $booll = false ] && [ $bools = true ]
	then
		echo "Manque une fact au hasard (-l)."

fi



exit 0

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
