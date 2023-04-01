import os
import json
import shutil
import datetime
import requests
from tqdm import tqdm
import mysql.connector

def ajout_donnee_dbb(element):
    ## inserer les donnees dans la base de donnees gid INT NOT NULL, IDENT TEXT NOT NULL,
    # Creation de la requete
    sql = "INSERT INTO ident (gid, ident) VALUES (%s, %s)"
    # Creation du tuple
    val = (element['properties']['gid'], element['properties']['ident'])
    # Execution de la requete
    cursor.execute(sql, val)
    


# Connection a la base de donnees
cnx = mysql.connector.connect(user='root', password='@Password0', host='localhost', database='campus')

# Creation du curseur
cursor = cnx.cursor()

url = "https://data.bordeaux-metropole.fr/geojson/features/SV_ARRET_P?key=177BEEMTWZ&attributes=[%22GID%22,%22IDENT%22]"

reponse = requests.get(url, timeout=90)
print("Telechargement du fichier JSON terminé")
if reponse.status_code == 200:
    data = json.loads(reponse.text)
    i=0
    for element in data['features']:
        # if i > 1:
        #     break
        ajout_donnee_dbb(element)
        # commit des donnees dans la base de donnees
        cnx.commit()
        i+=1
    print("Insertion des données terminée")    
else:
    print("Erreur de téléchargement du fichier JSON")
    