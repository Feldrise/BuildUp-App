# Build Up

> Ceci est l'application Build Up, le back end derrière est disponible sur [ce repository](https://github.com/Feldrise/BuildUp)

![Build Up](https://cdn.discordapp.com/attachments/743784793388613663/813463943414284358/Mockup_v2.3.jpg)

## Qu'est-ce que c'est Build Up ?
Build Up est un programme de Coaching Personnalisé gratuit, à destination des 16-30 ans sur 3 mois.

Le prinicipal objectif est de fournir un accompagnement personnalisé aux jeunes entrepreneurs qui n’ont pas toutes les cartes en main pour voir leur(s) projet(s) évoluer.

Nous partons du principe qu’aujourd’hui, un jeune doit pouvoir bénéficier d’un appui humain, matériel et bienveillant dans la viabilisation de son ou ses idées.

## La structure de l'application
### Les pages
L'application repose globalement sur une page principale qui permet de naviguer parmis les autres pages. Il y a 3 vues en fonctions du rôle de l'utilisateur :
 - La vue administrateur
 - La vue Builders
 - La vue Coachs

 ### Les services
 Afin de communiquer avec le Back End, l'application reprend la même architecture de service. La documentation du Back End [se trouve ici](https://api.new-talents.fr/documentation)

 ### Les entités
 De la même manière que les services, l'application reprend les même modèles de données que le Back End a quelques combinaisons prêtes. Par exemple, plutôt que de garder uniquement l'identifiant d'un objet utilisateur, les entités Builder et Coach on directement une entitée utilisateur associée