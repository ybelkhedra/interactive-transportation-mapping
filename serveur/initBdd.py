# Description: Ce fichier permet d'initialiser la base de données grace aux données de ../donnnees/json/resultats_post_traitement/arretsPost.json
import mysql.connector
import os
import json
import shutil
import datetime
import requests


def enleverCaracteresSpeciaux(mot):
    mot = mot.replace("'"," ")
    return mot

# Connection a la base de donnees
cnx = mysql.connector.connect(user='root', password='@Password0', host='localhost', database='campus')

# Creation du curseur
cursor = cnx.cursor()

# Ouverture du fichier
data = json.loads(open('../donnees/json/resultats_post_traitement/arretsPost.json').read())
#lecture des donnees
for arret in data:
    ## si l'arret n'est pas present dans la table arret alors l'ajouter
    requete = "SELECT * FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(arret['nom'])+"'"
    cursor.execute(requete)
    if len(cursor.fetchall()) == 0:
        #ajout du nom de l'arret dans la table arret
        requete = "INSERT INTO arrets (nom) VALUES ('"+enleverCaracteresSpeciaux(arret['nom'])+"')"
        cursor.execute(requete)
for arret in data:
    #recuperation de l'id de l'arret
    requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(arret['nom'])+"'"
    cursor.execute(requete)
    id_arret = cursor.fetchall()[0][0]
    #recuperation des lignes de l'arret
    for ligne in arret['lignes']:
        nom_ligne = ligne['nom']
        direction =[]
        if len(ligne['courses_associees'][0]['aller']) > 0:
            for course in ligne['courses_associees'][0]['aller']:
                # trouver id de direction
                requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"'"
                cursor.execute(requete)
                # si l'arret n'est pas present alors l'ajouter
                if len(cursor.fetchall()) == 0:
                    requete = "INSERT INTO arrets (nom) VALUES ('"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"')"
                    cursor.execute(requete)
                requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"'"
                cursor.execute(requete)
                id_dir = cursor.fetchall()[0][0]
                direction.append(id_dir)
        if len(ligne['courses_associees'][1]['retour']) > 0:
            for course in ligne['courses_associees'][1]['retour']:
                # trouver id de direction
                requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"'"
                cursor.execute(requete)
                # si l'arret n'est pas present alors l'ajouter
                if len(cursor.fetchall()) == 0:
                    requete = "INSERT INTO arrets (nom) VALUES ('"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"')"
                    cursor.execute(requete)
                requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(course['arret_arrivee'])+"'"
                cursor.execute(requete)
                id_dir = cursor.fetchall()[0][0]
                direction.append(id_dir)
        #si dans la table ligne on ne retrouve pas le couple nom_ligne et direction alors on l'ajoute
        for dir in direction:
            requete = "SELECT * FROM lignes WHERE nom = '"+enleverCaracteresSpeciaux(nom_ligne)+"' AND direction = '"+str(dir)+"'"
            cursor.execute(requete)
            if len(cursor.fetchall()) == 0:
                requete = "INSERT INTO lignes (nom, direction) VALUES ('"+enleverCaracteresSpeciaux(nom_ligne)+"', '"+str(dir)+"')"
                cursor.execute(requete)
            #recuperation de l'id de la ligne
            requete = "SELECT id FROM lignes WHERE nom = '"+enleverCaracteresSpeciaux(nom_ligne)+"' AND direction = '"+str(dir)+"'"
            cursor.execute(requete)
            id_ligne = cursor.fetchall()[0][0]
            #ajout de l'arret dans la table desservir
            # si l'arret et la ligne ne sont pas present dans la table desservir alors les ajouter
            requete = "SELECT * FROM desservir WHERE arret = '"+str(id_arret)+"' AND ligne = '"+str(id_ligne)+"'"
            cursor.execute(requete)
            if len(cursor.fetchall()) == 0:
                requete = "INSERT INTO desservir (arret, ligne) VALUES ('"+str(id_arret)+"', '"+str(id_ligne)+"')"
                cursor.execute(requete)
    #affichage de l'avancement et verification de la base de donnees avec requete de selection
    print("Ajout de l'arret "+str(enleverCaracteresSpeciaux(arret['nom'])) + " dans la base de donnees")
    print("")
            

# Fermeture de la connexion
cnx.commit()
cursor.close()
cnx.close()