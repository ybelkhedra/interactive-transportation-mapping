#!/bin/bash

# Demarrer serveur apache
sudo service apache2 start

# Copier les fichiers *.php du dossier courant dans le dossier /var/www/html, ecraser si necessaire

sudo rm -rf /var/www/html/*

sudo cp *.php /var/www/html

sudo cp *.css /var/www/html

sudo cp -r img /var/www/html

sudo cp *.js /var/www/html

sudo cp *.html /var/www/html

sudo cp *.json /var/www/html

sudo cp *.csv /var/www/html





# Demander a l'utilisateur le nom du fichier a executer
#wslview http://localhost/home.php

echo "visiter http://localhost/connection.php pour voir le resultat"

