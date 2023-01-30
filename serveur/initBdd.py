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

def presenceHorairesList(ligne, direction, heure, horaires):
    i=0
    for horaire in horaires:
        if horaire['ligne'] == ligne and horaire['direction'] == direction and horaire['heure'] == heure:
            return -2
        elif horaire['ligne'] == ligne and horaire['direction'] == direction:
            return i
        i+=1
    return -1
    

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
        requete = "INSERT INTO arrets (nom, vehicule) VALUES ('"+enleverCaracteresSpeciaux(arret['nom'])+"','"+enleverCaracteresSpeciaux(arret['vehicule'])+"')"
        cursor.execute(requete)
        id_arret = cursor.lastrowid
    else :
        requete = "SELECT id FROM arrets WHERE nom = '"+enleverCaracteresSpeciaux(arret['nom'])+"'"
        cursor.execute(requete)
        id_arret = cursor.fetchall()[0][0]
    #ajout des coordonnees de l'arret dans la table coordonnees_arrets
    requete = "INSERT INTO coordonnees_arrets (latitude, longitude) VALUES ("+enleverCaracteresSpeciaux(str(arret['lat']))+","+ enleverCaracteresSpeciaux(str(arret['lon']))+")"
    cursor.execute(requete)
    #recuperation de l'id des coordonnees de l'arret
    id_coordonnees = cursor.lastrowid
    ## ajout du lien dans la table situer_arrets
    requete = "INSERT INTO situer_arrets (arret, coordonnee) VALUES ("+str(id_arret)+","+str(id_coordonnees)+")"
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
        horaires = []
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
                if course['horaires'] != None:
                    horaire = {"ligne": nom_ligne, "direction": id_dir, "heure": course['horaires']}
                    if presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires) == -1:
                        horaires.append(horaire)
                    elif presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires) >= 0:
                        horaires[presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires)]['heure'] += course['horaires']

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
                if course['horaires'] != None:
                    horaire = {"ligne": nom_ligne, "direction": id_dir, "heure": course['horaires']}
                    if presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires) == -1:
                        horaires.append(horaire)
                    elif presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires) >= 0:
                        horaires[presenceHorairesList(nom_ligne, id_dir, course['horaires'], horaires)]['heure'] += course['horaires']
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
        for hor in horaires:
            ##recuperation de l'id de la ligne
            requete = "SELECT id FROM lignes WHERE nom = '"+enleverCaracteresSpeciaux(hor['ligne'])+"' AND direction = '"+str(hor['direction'])+"'"
            cursor.execute(requete)
            id_ligne = cursor.fetchall()[0][0]
            id_dir = hor['direction']
            #ajout des horaires dans la table horaires
            for h in hor['heure']:
                if h != None:
                    requete = "INSERT INTO horaires (ligne, direction, arret, horaire) VALUES ('"+str(id_ligne)+"', '"+str(id_dir)+"', '"+str(id_arret)+"', '"+enleverCaracteresSpeciaux(str(h))+"')"
                    cursor.execute(requete) 
    #affichage de l'avancement et verification de la base de donnees avec requete de selection
    print("Ajout de l'arret "+str(enleverCaracteresSpeciaux(arret['nom'])) + " dans la base de donnees")
            

# Fermeture de la connexion
cnx.commit()
cursor.close()
cnx.close()