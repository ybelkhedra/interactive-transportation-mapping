import os
import json
import shutil
import datetime
import requests
from tqdm import tqdm
import mysql.connector




def ajout_data():
    print("Ajout des données de transport en commun de la région Aquitaine")
    # Connection a la base de donnees
    cnx = mysql.connector.connect(user='root', password='@Password0', host='localhost', database='campus')

    # Creation du curseur
    cursor = cnx.cursor()
    print("Connection a la base de donnees reussie")
    
    # ouvrir le fichier txt ../donnees/txt/agency.txt
    print("Ajout des données de agency.txt")
    with open('../donnees/txt/agency.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                agency_id = line[0].split(':')[2]
                #enlever les guillemets
                agency_id = agency_id.replace('"', '')
                print("agency_id: " + agency_id + "   ...")
                cursor.execute("INSERT INTO agency (agency_id, agency_name, agency_url) VALUES (%s, %s, %s)", (agency_id, line[1], line[2]))
            i+=1
    # on commit les données
    cnx.commit()
    print("Ajout des données de agency.txt reussi")
    
    # ouvrir le fichier txt ../donnees/txt/calendar.txt
    print("Ajout des données de calendar.txt")
    with open('../donnees/txt/calendar.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                service_id = line[0].split(':')[2]
                service_id = service_id.replace('"', '')
                
                cursor.execute("INSERT INTO calendar (service_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday, start_date, end_date) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (service_id, line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9]))
            i+=1
    # on commit les données
    cnx.commit()
    print("Ajout des données de calendar.txt reussi")
    
    
    print("Ajout des données de calendar_dates.txt")
    with open('../donnees/txt/calendar_dates.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                service_id = line[0].split(':')[2]
                service_id = service_id.replace('"', '')
                
                cursor.execute("INSERT INTO calendar_dates (service_id, date) VALUES (%s, %s)", (service_id, line[1]))
            i+=1
    # on commit les données
    cnx.commit()
    print("Ajout des données de calendar_dates.txt reussi")
    
    print("Ajout des données de routes.txt")   
    with open('../donnees/txt/routes.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                route_id = line[0].split(':')[2]
                route_id = route_id.replace('"', '')
                agency_id = line[1].split(':')[2]
                agency_id = agency_id.replace('"', '')
                route_short_name = line[2].replace('"', '')
                
                cursor.execute("INSERT INTO routes (route_id, agency_id, route_short_name, route_long_name) VALUES (%s, %s, %s, %s)", (route_id, agency_id, route_short_name, line[3]))
            i+=1        
    # on commit les données
    cnx.commit()
    print("Ajout des données de routes.txt reussi")
    
    print("Ajout des données de stops.txt")
    with open('../donnees/txt/stops.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                stop_id = line[0].split(':')[2]
                stop_id = stop_id.replace('"', '')
                cursor.execute("INSERT INTO stop (stop_id, stop_name, stop_lat, stop_lon) VALUES (%s, %s, %s, %s)", (stop_id, line[2], line[4], line[5]))
            i+=1
    # on commit les données
    cnx.commit()
    print("Ajout des données de stops.txt reussi")
    
    
    print("Ajout des données de shapes.txt")
    with open('../donnees/txt/shapes.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:

            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                shape_id = line[0].split(':')[2]
                shape_id = shape_id.replace('"', '')
                cursor.execute("INSERT INTO shapes (shape_id, shape_pt_lat, shape_pt_lon, shape_pt_sequence) VALUES (%s, %s, %s, %s)", (shape_id, line[1], line[2], line[3]))
            i+=1
    # on commit les données
    cnx.commit()
    print("Ajout des données de shapes.txt reussi")

    print("Ajout des données de trips.txt")
    with open('../donnees/txt/trips.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                route_id = line[0].split(':')[2]
                route_id = route_id.replace('"', '')
                service_id = line[1].split(':')[2]
                service_id = service_id.replace('"', '')
                trip_id = line[2].split(':')[2]
                #enlever le "-" dans le trip_id
                trip_id = trip_id.replace('-', '')
                trip_id = trip_id.replace('"', '')
                shape_id = line[7].split(':')[2]
                shape_id = shape_id.replace('"', '')
                cursor.execute("INSERT INTO trips (route_id, service_id, trip_id, trip_headsign, trip_short_name ,direction_id, shape_id, wheelchair_accessible, bikes_allowed) VALUES (%s, %s, %s, %s, %s,%s, %s, %s, %s)", (route_id, service_id, trip_id, line[3], line[4],line[5], shape_id, line[8], line[9]))
            i+=1
    # on commit les données
    cnx.commit()   
    print("Ajout des données de trips.txt reussi")    
    
    print("Ajout des données de stop_times.txt")
    with open('../donnees/txt/stop_times.txt', 'r') as f:
        # lire le fichier, pour chaque ligne, les colonnes sont séparées par des virgules
        i=0
        for line in f:
            if (i>0):
                # on sépare les colonnes
                line = line.split(',')
                # on enlève le retour à la ligne
                line[-1] = line[-1].replace('\n', '')
                # on ajoute les données dans la base de données
                trip_id = line[0].split(':')[2]
                # enlever le "-" dans le trip_id
                trip_id = trip_id.replace('-', '')
                trip_id = trip_id.replace('"', '')
                stop_id = line[3].split(':')[2]
                stop_id = stop_id.replace('"', '')
                cursor.execute("INSERT INTO stop_times (trip_id, arrival_time, departure_time, stop_id, stop_sequence) VALUES (%s, %s, %s, %s, %s)", (trip_id, line[1], line[2], stop_id, line[4]))
            i+=1
    # on commit les données
    cnx.commit() 
    print("Ajout des données de stop_times.txt reussi")
    
    print("Fermeture de la connexion")
    # fermer la connexion
    cnx.close()
    print("Connexion fermée")
    
ajout_data()