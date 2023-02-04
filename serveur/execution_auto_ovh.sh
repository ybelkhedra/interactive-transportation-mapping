#!/bin/bash

# la varible date prend la date du jour et l'heure
date=$(date +%Y-%m-%d_%Hh%M)
#on met la date dans le fichier log_add.txt
echo $date >> log.txt
#on lance le script python qui initialise les données dans la base de données
python3 download_opendata.py >> log.txt

