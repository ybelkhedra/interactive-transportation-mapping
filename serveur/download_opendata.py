import os
import json
import shutil
import datetime
import requests
from tqdm import tqdm
import mysql.connector
# zipfile.ZipFile
import zipfile



# Connection a la base de donnees
cnx = mysql.connector.connect(user='root', password='@Password0', host='localhost', database='campus')

# Creation du curseur
cursor = cnx.cursor()

def convertorHoraire(mdate):
    mdate = mdate.replace("T"," ")
    #enlever les millisecondes
    mdate = mdate[:-6]
    return mdate

def enleverCaracteresSpeciaux(mot):
    mot = mot.replace("'"," ")
    return mot

def convertorTrueFalse(chaine):
    if chaine == 'True':
        return 1
    else:
        return 0
    
    


def ajout_arretsData(data):
    try :
        gid = str(data['properties']['gid'])
        latitude = str(data['geometry']['coordinates'][1])
        longitude = str(data['geometry']['coordinates'][0])
        libelle = enleverCaracteresSpeciaux(str(data['properties']['libelle']))
        vehicule = enleverCaracteresSpeciaux(str(data['properties']['vehicule']))
        type = enleverCaracteresSpeciaux(str(data['properties']['type']))
        actif = str(convertorTrueFalse(data['properties']['actif']))
        voirie = str(convertorTrueFalse(data['properties']['voirie']))
        mdate = str(data['properties']['mdate'])
        # verifier si l'arret est deja present dans la base de donnees
        
        requete = "SELECT * FROM arretsData WHERE gid = "+str(gid)+";"
        cursor.execute(requete)
        try : 
            mdate_present = str(cursor.fetchall()[0][8])
        except:
            mdate_present=""
        # si l'arret n'est pas present dans la table arret alors l'ajouter
        if len(mdate_present) == 0:
            print("Ajout de l'arret : "+str(libelle))
            #ajout du nom de l'arret dans la table arret
            requete = "INSERT INTO arretsData (gid, latitude, longitude, libelle, vehicule, type, actif, voirie, mdate) VALUES ("+str(gid)+","+str(latitude)+","+str(longitude)+",'"+libelle+"','"+vehicule+"','"+type+"','"+actif+"','"+voirie+"','"+mdate+"');"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)
            id_arret = cursor.lastrowid
        else :
            print("L'arret : "+str(libelle)+" est deja present dans la base de donnees")
            # si l'arret est deja present dans la table arret alors verifier que les donnees sont a jour avec la date mdate
            if str(mdate_present) != convertorHoraire(str(mdate)):
                print("Mise a jour de l'arret : "+str(libelle))
                requete = "UPDATE arretsData SET latitude = "+str(latitude)+", longitude = "+str(longitude)+", libelle = '"+libelle+"', vehicule = '"+vehicule+"', type = '"+type+"', actif = '"+actif+"', voirie = '"+voirie+"', mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
                try :
                    cursor.execute(requete)
                except :
                    print("Erreur Bdd : "+requete)
    except Exception as e:
        print(e)
        print("Erreur fonction ajout_arretsData ")
        return None
    

def ajout_lignesData(data):
    # try :
    gid = str(data['properties']['gid'])
    coordonnees = str(data['geometry']['coordinates'])
    libelle = enleverCaracteresSpeciaux(str(data['properties']['libelle']))
    sens = enleverCaracteresSpeciaux(str(data['properties']['sens']))
    vehicule = enleverCaracteresSpeciaux(str(data['properties']['vehicule']))
    principale = str(convertorTrueFalse(data['properties']['principal']))
    groupe = str(data['properties']['groupe'])
    rs_sv_ligne_a = str(data['properties']['rs_sv_ligne_a'])
    rg_sv_arret_p_nd = str(data['properties']['rg_sv_arret_p_nd'])
    rg_sv_arret_p_na = str(data['properties']['rg_sv_arret_p_na'])
    mdate = str(data['properties']['mdate'])
    # verifier si la ligne est deja presente dans la base de donnees
    requete = "SELECT * FROM lignesData WHERE gid = "+str(gid)+";"
    cursor.execute(requete)
    try : 
        mdate_present = str(cursor.fetchall()[0][10])
    except:
        mdate_present=""
    # si la ligne n'est pas presente dans la table ligne alors l'ajouter
    if len(mdate_present) == 0:
        print("Ajout de la ligne : "+str(libelle))
        #ajout du nom de la ligne dans la table ligne
        requete = "INSERT INTO lignesData (gid, coordonnees, libelle, sens, vehicule, principale, groupe, rs_sv_ligne_a, rg_sv_arret_p_nd, rg_sv_arret_p_na, mdate) VALUES ("+str(gid)+",'"+coordonnees+"','"+libelle+"','"+sens+"','"+vehicule+"','"+principale+"','"+groupe+"','"+rs_sv_ligne_a+"','"+rg_sv_arret_p_nd+"','"+rg_sv_arret_p_na+"','"+mdate+"');"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("La ligne : "+str(libelle)+" est deja presente dans la base de donnees")
        # si la ligne est deja presente dans la table ligne alors verifier que les donnees sont a jour avec la date mdate
        if str(mdate_present) != convertorHoraire(str(mdate)):
            print("Mise a jour de la ligne : "+str(libelle))
            requete = "UPDATE lignesData SET coordonnees = '"+coordonnees+"', libelle = '"+libelle+"', sens = '"+sens+"', vehicule = '"+vehicule+"', principale = '"+principale+"', groupe = '"+groupe+"', rs_sv_ligne_a = '"+rs_sv_ligne_a+"', rg_sv_arret_p_nd = '"+rg_sv_arret_p_nd+"', rg_sv_arret_p_na = '"+rg_sv_arret_p_na+"', mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)
    # except Exception as e:
    #     print(e)
    #     print("Erreur fonction ajout_lignesData ")
    #     return None

def ajout_nomCommercialData(data):
    gid = str(data['properties']['gid'])
    libelle = enleverCaracteresSpeciaux(str(data['properties']['libelle']))
    vehicule = enleverCaracteresSpeciaux(str(data['properties']['vehicule']))
    mdate = str(data['properties']['mdate'])
    # verifier si la ligne est deja presente dans la base de donnees
    requete = "SELECT * FROM nomCommercialData WHERE gid = "+str(gid)+";"
    cursor.execute(requete)
    try : 
        mdate_present = str(cursor.fetchall()[0][3])
    except:
        mdate_present=""
    # si la ligne n'est pas presente dans la table ligne alors l'ajouter
    if len(mdate_present) == 0:
        print("Ajout du nom commercial : "+str(libelle))
        #ajout du nom de la ligne dans la nomCommercialData
        requete = "INSERT INTO nomCommercialData (gid, libelle, vehicule, mdate) VALUES ("+str(gid)+",'"+libelle+"','"+vehicule+"','"+mdate+"');"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("Le nom commercial : "+str(libelle)+" est deja presente dans la base de donnees")
        # si la ligne est deja presente dans la table nomCommercialData alors verifier que les donnees sont a jour avec la date mdate
        if str(mdate_present) != convertorHoraire(str(mdate)):
            print("Mise a jour du nom commercial : "+str(libelle))
            requete = "UPDATE nomCommercialData SET libelle = '"+libelle+"', vehicule = '"+vehicule+"', mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)

def ajout_tronconsData(data):
    gid = str(data['properties']['gid'])
    coordonnees = enleverCaracteresSpeciaux(str(data['geometry']['coordinates']))
    vehicule = enleverCaracteresSpeciaux(str(data['properties']['vehicule']))
    rg_sv_arret_p_nd = str(data['properties']['rg_sv_arret_p_nd'])
    rg_sv_arret_p_na = str(data['properties']['rg_sv_arret_p_na'])
    mdate = str(data['properties']['mdate'])
    # verifier si le troncon est deja presente dans la base de donnees
    requete = "SELECT * FROM tronconsData WHERE gid = "+str(gid)+";"
    cursor.execute(requete)
    try : 
        mdate_present = str(cursor.fetchall()[0][5])
    except:
        mdate_present=""
    # si le troncon n'est pas presente dans la table tronconsData alors l'ajouter
    if len(mdate_present) == 0:
        print("Ajout du troncon : "+str(gid))
        #ajout du troncon dans la tronconsData
        requete = "INSERT INTO tronconsData (gid, coordonnees, vehicule, rg_sv_arret_p_nd, rg_sv_arret_p_na, mdate) VALUES ("+str(gid)+",'"+coordonnees+"','"+vehicule+"',"+str(rg_sv_arret_p_nd)+","+str(rg_sv_arret_p_na)+",'"+mdate+"');"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("Le troncon : "+str(gid)+" est deja presente dans la base de donnees")
        # si le troncon est deja presente dans la table tronconsData alors verifier que les donnees sont a jour avec la date mdate
        if str(mdate_present) != convertorHoraire(str(mdate)):
            print("Mise a jour du troncon : "+str(gid))
            requete = "UPDATE tronconsData SET coordonnees = '"+coordonnees+"', vehicule = '"+vehicule+"', rg_sv_arret_p_nd = "+str(rg_sv_arret_p_nd)+", rg_sv_arret_p_na = "+str(rg_sv_arret_p_na)+", mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)
           
                
def ajout_coursesData(data):
    gid = str(data['properties']['gid'])
    rs_sv_ligne_a = str(data['properties']['rs_sv_ligne_a'])
    rs_sv_chem_l = str(data['properties']['rs_sv_chem_l'])
    rg_sv_arret_p_nd = str(data['properties']['rg_sv_arret_p_nd'])
    rg_sv_arret_p_na = str(data['properties']['rg_sv_arret_p_na'])
    mdate = str(data['properties']['mdate'])
    # verifier si la course est deja presente dans la base de donnees
    requete = "SELECT * FROM CoursesData WHERE gid = "+str(gid)+";"
    cursor.execute(requete)
    try : 
        mdate_present = str(cursor.fetchall()[0][6])
    except:
        mdate_present=""
    # si la course n'est pas presente dans la table coursesData alors l'ajouter
    if len(mdate_present) == 0:
        print("Ajout de la course : "+str(gid))
        #ajout de la course dans la coursesData
        requete = "INSERT INTO CoursesData (gid, rs_sv_ligne_a, rs_sv_chem_l, rg_sv_arret_p_nd, rg_sv_arret_p_na, mdate) VALUES ("+str(gid)+","+str(rs_sv_ligne_a)+","+str(rs_sv_chem_l)+","+str(rg_sv_arret_p_nd)+","+str(rg_sv_arret_p_na)+",'"+mdate+"');"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("La course : "+str(gid)+" est deja presente dans la base de donnees")
        # si la course est deja presente dans la table coursesData alors verifier que les donnees sont a jour avec la date mdate
        if str(mdate_present) != convertorHoraire(str(mdate)):
            print("Mise a jour de la course : "+str(gid))
            requete = "UPDATE CoursesData SET rs_sv_ligne_a = "+str(rs_sv_ligne_a)+", rs_sv_chem_l = "+str(rs_sv_chem_l)+", rg_sv_arret_p_nd = "+str(rg_sv_arret_p_nd)+", rg_sv_arret_p_na = "+str(rg_sv_arret_p_na)+", mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)
                
def ajout_relationsLignesTronconsData(data, gid = 0):
    rs_sv_chem_l = str(data['properties']['rs_sv_chem_l'])
    rs_sv_tronc_l = str(data['properties']['rs_sv_tronc_l'])
    # verifier si la relation est deja presente dans la base de donnees
    requete = "SELECT * FROM relationsLignesTronconsData WHERE rs_sv_chem_l = "+str(rs_sv_chem_l)+" AND rs_sv_tronc_l = "+str(rs_sv_tronc_l)+";"
    cursor.execute(requete)
    if len(cursor.fetchall()) == 0:
        print("Ajout de la relation : "+str(rs_sv_chem_l)+" - "+str(rs_sv_tronc_l))
        #ajout de la relation dans la relationsLignesTronconsData
        requete = "INSERT INTO relationsLignesTronconsData (rs_sv_chem_l, rs_sv_tronc_l) VALUES ("+str(rs_sv_chem_l)+","+str(rs_sv_tronc_l)+");"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("La relation : "+str(rs_sv_chem_l)+" - "+str(rs_sv_tronc_l)+" est deja presente dans la base de donnees")
            

def ajout_donnee_dbb(data,bdd):
    if bdd == "arretsData":
        ajout_arretsData(data)
    elif bdd == "lignesData":
        ajout_lignesData(data)
    elif bdd == "tronconsData":
        ajout_tronconsData(data)
    elif bdd == "relationsLignesTronconsData":
        ajout_relationsLignesTronconsData(data)
    elif bdd == "coursesData":
        ajout_coursesData(data)
    elif bdd == "nomCommercial":
        ajout_nomCommercialData(data)
    


def telechargerFichierJson(url,bdd,size):
    # try : 
    print("Telechargement du fichier JSON en cours...")
    # response = requests.get(url, stream=True)

    # if response.status_code == 200:
    #     i=0
    #     for chunk in response.iter_content(chunk_size=size):
    #         ##ecriture du fichier json
    #         with open("data_tmp.json", "wb") as f:
                
                    
    #             try :
    #                 data = json.loads(chunk.decode("utf-8"))
    #                 ajout_donnee_dbb(data,bdd)
    #                 # commit des donnees dans la base de donnees
    #                 cnx.commit()
    #             except Exception as e:
    #                 i+=1
    #                 print("Erreur lors du chargement du fichier JSON : nb_err =  : "+str(i)+" doit etre inferieur ou egal a 2")
    reponse = requests.get(url, timeout=90)
    print("Telechargement du fichier JSON terminé")
    if reponse.status_code == 200:
        data = json.loads(reponse.text)
        i=0
        for element in data['features']:
            # if i > 1:
            #     break
            ajout_donnee_dbb(element,bdd)
            # commit des donnees dans la base de donnees
            cnx.commit()
            i+=1
    
    elif reponse.status_code == 404:
        print("Fichier JSON non trouvé")
        return None
    elif reponse.status_code == 500:
        print("Erreur serveur")
        return None
    elif reponse.status_code == 503:
        print("Service non disponible")
        return None
    elif reponse.status_code == 504:
        print("Gateway Time-out")
        return None
    elif reponse.status_code == 400:
        print("Mauvaise requête")
        return None
    else :
        print("Erreur inconnue")
        return None
    # except Exception as e:
    #     print(e)
    #     print("Erreur lors du téléchargement du fichier JSON")
    #     telechargerFichierJson(url,bdd,size)

def telechargerFichierJsonSTREAM(url,bdd,size):
    # try : 
    reponse = requests.get(url, stream=True)

    if reponse.status_code == 200:
        try :
            response = requests.get(url, timeout=200, stream=True)
        except:
            print("Erreur lors du téléchargement de : " + str(url))

        total_size = int(response.headers.get("Content-Length", 0))
        block_size = 1024  # 1 Kibibyte
        progress = tqdm(total=total_size, unit="B", unit_scale=True)

        with open("large_file.json", "wb") as f:
            for data in response.iter_content(block_size):
                progress.update(len(data))
                f.write(data)
        progress.close()
        
        # decode le json
        with open("large_file.json", "r") as f:
            response = f.read()
        response = json.loads(response)
        # ajout des donnees dans la base de donnees
        for element in response['features']:
            ajout_donnee_dbb(element,bdd)
            # commit des donnees dans la base de donnees
            cnx.commit()
    
    elif reponse.status_code == 404:
        print("Fichier JSON non trouvé")
        return None
    elif reponse.status_code == 500:
        print("Erreur serveur")
        return None
    elif reponse.status_code == 503:
        print("Service non disponible")
        return None
    elif reponse.status_code == 504:
        print("Gateway Time-out")
        return None
    elif reponse.status_code == 400:
        print("Mauvaise requête")
        return None
    else :
        print("Erreur inconnue")
        return None
    # except Exception as e:
    #     print(e)
    #     print("Erreur lors du téléchargement du fichier JSON")
    #     telechargerFichierJson(url,bdd,size)
    
telechargerFichierJson("https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_arret_p","arretsData",1024)
telechargerFichierJson("https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_ligne_a","nomCommercial",1024)
telechargerFichierJson("https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_chem_l","lignesData",1024)
telechargerFichierJson("https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_tronc_l","tronconsData",1024)
telechargerFichierJson('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_cours_a', 'coursesData', 1024)
telechargerFichierJson('https://data.bordeaux-metropole.fr/geojson/relations/SV_TRONC_L/SV_CHEM_L?key=177BEEMTWZ', 'relationsLignesTronconsData', 1024)


cursor.close()
cnx.close()











def telechargement_data_region():
    # telecherger le fichier zip : https://www.data.gouv.fr/fr/datasets/r/ba4be162-cc7f-4c7c-9d96-376a225e9045
    # puis dezipper et mettre tout les fichiers contenue dans le dossier decompressé dans le dossier ../donnees/txt
    print("Telechargement des données de transport en commun de la région Aquitaine")
    # telecharger le fichier zip
    url = "https://www.data.gouv.fr/fr/datasets/r/ba4be162-cc7f-4c7c-9d96-376a225e9045"
    reponse = requests.get(url, timeout=90)
    print("Telechargement du fichier zip terminé")
    if reponse.status_code == 200:
        # dezipper le fichier zip
        with open("../donnees/txt/gironde-aggregated-gtfs.zip", "wb") as f:
            f.write(reponse.content)
        print("Dezippage du fichier zip terminé")
        # ouvrir le fichier zip
        with zipfile.ZipFile("../donnees/txt/gironde-aggregated-gtfs.zip", 'r') as zip_ref:
            # extraire les fichiers
            zip_ref.extractall("../donnees/txt/")
            print("Extraction des fichiers terminé")
        # supprimer le fichier zip
        os.remove("../donnees/txt/gironde-aggregated-gtfs.zip")
        print("Suppression du fichier zip terminé")
    elif reponse.status_code == 404:
        print("Fichier zip non trouvé")
        return None
    elif reponse.status_code == 500:
        print("Erreur serveur")
        return None
    elif reponse.status_code == 503:
        print("Service non disponible")
        return None
    elif reponse.status_code == 504:
        print("Gateway Time-out")
        return None
    elif reponse.status_code == 400:
        print("Mauvaise requête")
        return None
    else :
        print("Erreur inconnue")
        return None






def ajout_data():
    print("Ajout des données de transport en commun de la région Aquitaine")
    # Connection a la base de donnees
    cnx = mysql.connector.connect(user='root', password='@Password0', host='localhost', database='campus')

    # Creation du curseur
    cursor = cnx.cursor()
    print("Connection a la base de donnees reussie")
    
    
    print("Reinitialisation de la base de donnees nouvelle aquitaine ...")
    #suppresion des donnees dans les tables agency, routes, stops, trips, stop_times
    
#     ALTER TABLE stop_times DROP FOREIGN KEY stop_times_stop_id_stop_stop_id;
# ALTER TABLE trips DROP FOREIGN KEY trips_route_id_routes_route_id;
# ALTER TABLE trips DROP FOREIGN KEY trips_service_id_calendar_service_id;
# ALTER TABLE routes DROP FOREIGN KEY routes_agency_id_agency_agency_id;
# ALTER TABLE calendar_dates DROP FOREIGN KEY calendar_dates_service_id_calendar_service_id;
    try :
        cursor.execute("ALTER TABLE stop_times DROP FOREIGN KEY stop_times_stop_id_stop_stop_id")
        cursor.execute("ALTER TABLE trips DROP FOREIGN KEY trips_route_id_routes_route_id")
        cursor.execute("ALTER TABLE trips DROP FOREIGN KEY trips_service_id_calendar_service_id")
        cursor.execute("ALTER TABLE routes DROP FOREIGN KEY routes_agency_id_agency_agency_id")
        cursor.execute("ALTER TABLE calendar_dates DROP FOREIGN KEY calendar_dates_service_id_calendar_service_id")
    except:
        print("Pas de cle etrangere a supprimer")
    
    cursor.execute("DELETE FROM agency")
    cursor.execute("DELETE FROM routes")
    cursor.execute("DELETE FROM stop")
    cursor.execute("DELETE FROM trips")
    cursor.execute("DELETE FROM stop_times")
    cursor.execute("DELETE FROM shapes")
    cursor.execute("DELETE FROM calendar")
    cursor.execute("DELETE FROM calendar_dates")
    print("Reinitialisation de la base de donnees nouvelle aquitaine reussie")
    
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
    
telechargement_data_region()
ajout_data()