#! /bin/sh

#Par: Marek Felšöci (L1S1 CMI Réseaux) et Arnaud Pinsun (L1S1 CMI Images)

#ceci est le script général qui permet d'exécuter toutes les fonctions auxiliaires

#on s'assure que les scripts soient exécutables

chmod 700 afile
chmod 700 aide
chmod 700 interrupt
chmod 700 topn
chmod 700 topn2
chmod 700 priority

#pour pouvoir lancer prochainement les fonctions auxiliaires il faut ajouter l'emplacement des scripts à la liste des emplacement générale (là ou le Shell va chercher les commandes)
currentdir=`pwd`

PATH=$PATH:$currentdir >> $HOME/.bashrc

#on affiche les infos clssiques sur le système courant

echo "Informations sur le système:"

echo "   "  ` cat /proc/version | cut -d "(" -f 1`
temps=`cat /proc/uptime | cut -f 1 -d ' ' | cut -d '.' -f 1` #le temps écoulé depuis le dernier démarrage est indiqué en secondes il faut donc le convertir
jour=`expr  $temps / 86400`
heure=`expr \( $temps - $jour '*' 86400 \) / 3600`
minute=`expr \( $temps - \( $temps / 3600 \) '*' 3600 \) / 60`
seconde=`expr $temps - $jour '*' 86400 - $heure '*' 3600 - $minute '*' 60`
echo "   Le dernier démarrage éffectué: il y a $jour jour(s) $heure heure(s) $minute minute(s) et $seconde seconde(s)"


#ici on recupère et on affiche l'information sur les utilisateur(s) connecté(s)

nbutilisateur=`last -f /var/run/utmp | sort | cut -d ' ' -f 1 | uniq | wc -l`
echo "   Nombre d'utilisateurs connecté(s): `expr $nbutilisateur - 2`" # -2 car il y a une ligne vide ainsi que la ligne utmp

#pour s'assurer du bon fonctionnement on remet préalablement la valeur des variables utilisées à 0

memmax=0
memmin=0
cachemem=0
buffer=0
usedmem=0
user=0
nice=0
system=0
idle=0
irq=0
softirq=0
steal=0
guest=0
guest_nice=0
sum_wanted=0
sum_all=0
sum_intermd=0
sum_final=0
sum_intermd_idle=0
sum_final_idle=0

#ici on recupère les informations sur la RAM utilisée
memmax=`cat /proc/meminfo | head -n 1 | tr -s [:space:] | cut -d " " -f2`
memmin=`cat /proc/meminfo | head -n 2 | tr -s [:space:] | cut -d " " -f2 | tail -n 1`
cachemem=`cat /proc/meminfo | head -n 4 | tr -s [:space:] | cut -d " " -f2 | tail -n 1`
buffer=`cat /proc/meminfo | head -n 3 | tr -s [:space:] | cut -d " " -f2 | tail -n 1`

#on calcule le taux de RAM utilisée en moyenne par toutes les applications lancées au moment même du lancement de ce script
usedmem=`expr $memmax - $memmin - $cachemem - $buffer`

echo "   Utilisation moyenne de la mémoire: $usedmem Ko"

echo "\n"

#on recupère les données nécessaires pour calculer le taux d'utilisation moyenne de CPU depuis le démarrage du système dans le dossier /proc/stat

user=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f2`
nice=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f3`
system=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f4`
idle=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f5`
irq=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f7`
softirq=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f8`
steal=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f9`
guest=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f10`
guest_nice=`cat /proc/stat | head -n 1 | tr -s [:space:] | cut -d " " -f11`

sum_wanted=`expr $user + $nice + $system + $irq + $softirq + $steal + $guest + $guest_nice`

sum_all=`expr $user + $nice + $system + $idle + $irq + $softirq + $steal + $guest + $guest_nice`

sum_intermd=`expr $sum_wanted \* 100`

sum_final=`expr $sum_intermd / $sum_all`

sum_intermd_idle=`expr $idle \* 100`

sum_final_idle=`expr $sum_intermd_idle / $sum_all`

#Après avoir effectué les calculs nécessaires on affiche les valeurs en pourcentage

echo "   Utilisation moyenne de CPU depuis le dernier démarrage: $sum_final %"

echo "   Pourcentage moyenne de CPU non utilisé depuis le dernier démarrage: $sum_final_idle %"

echo "\n"

echo "Processus: liste des 5 premiers processus les plus consommateurs"

./topn 2> /dev/null

echo "Analyse des fichiers et des répertoires: liste des 5 premiers fichier(s)/répertoire(s) les plus grands du répertoire courant"

./afile 2> /dev/null

#Après avoir affiché toutes les données et informations demandées on lance un système d'interaction avec l'utilisateur qui lui permettra de lancer les commandes auxiliaires au choix

echo "Le démarrage du script est terminé. Vous pouvez taper vos commandes. \n Tapez 'aide' pour afficher l'aide. \n Pour terminer le script tapez 'exit'."

echo "\n"

xxx=1

#cette boucle while va s'assurer qu'après l'exécution d'une commande auxiliaire le script ne se termine qu'en tapant la commande 'exit' pour que l'utilisateur ne soit pas obligé de relancer le script avant de saisir chaque commande
while [ $xxx -gt 0 ]
do
	read launch #cette variable recupère la saisie de l'utilisateur et l'exécute par la suite
	
	$launch

	xxx=`expr $xxx + 1`
done
