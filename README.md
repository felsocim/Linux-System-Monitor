# Moniteur système Linux

## A propos

Cet ensemble de scripts Shell est le résultat d'un projet réalisé dans le cadre des cours de pratique de systèmes d'exploitation. Le script principal **lsmon** permet d'afficher des informations de base sur le système Linux cible telles que la version du noyau, le temps depuis le dernier démarrage ou encore le taux d'utilisation de la mémoire vive. Une fois l'affichage de ces informations terminé, le script passe dans le mode interactif et permet à l'utilisateur de se servir des scripts auxiliers afin d'obtenir des renseignements plus précis notamment sur l'utilisation des ressources systèmes et le système. L'utilisateur est aussi en mesure d'interrompre un processus ou de lui attribuer une priorité différente.

## Guide d'utilisation

Tout d'abord, lancez le script principal **lsmon** se trouvant dans le réperoire racine du projet en exécutant la commande suivante depuis votre invite de commandes :

`./lsmon`

Si le script ne dispose pas de droit d'exécution, utilisez la syntaxe ci-dessous :

`sh ./lsmon`

Au démarrage, le script affiche un certain nombre d'informations sur le système, puis entre en mode d'interaction avec l'utilisateur. A partir de cet environnement, l'utilisateur peut se servir de plusieurs commandes.

### topn

Affiche la liste des *n* premiers processus du système triés par le *critère* indiqué.

**SYNTAXE** : `topn <n> <critère>`

*Critères valables* :
* cpu (tri par le temps CPU utilisé par le processus)
* prio (tri par priorité)
* vsize (tri par la taille de mémoire virtuelle allouée)
* date (tri par date de lancement)
* tps (tri par temps ecoulé depuis lancement de processus)

### afile

Effectue l'analyse des *n* premiers fichiers de l'emplacement pointé par le chemin absolu indiqué.

**SYNTAXE** : `afile <chemin absolu> <n>`

### interrupt

Tue le processus dont l'identificateur PID est passé en paramètre.

**SYNTAXE** : `interrupt <pid>`

### priority

Change la priorité du processus dont l'identificateur PID est passé en paramètre.

**SYNTAXE** : `priority <priorité> <pid>`

### aide

Affiche la liste des commandes disponibles.

### exit

Termine le script.

## Auteurs

* [**Marek Felsoci**](mailto:marek.felsoci@etu.unistra.fr) - [Université de Strasbourg](unistra.fr)
* **Arnaud Pinsun**

## Licence

Voir le fichier [LICENSE](LICENSE) dans la racine de ce répertoire.
