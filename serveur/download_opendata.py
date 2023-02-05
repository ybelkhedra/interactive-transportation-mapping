import os
import json
import shutil
import datetime
import requests
from tqdm import tqdm
import mysql.connector



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


def ajout_horairesData(data):
    gid = str(data['properties']['gid'])
    hor_theo = str(data['properties']['hor_theo'])
    hor_app = str(data['properties']['hor_app'])
    hor_real = str(data['properties']['hor_real'])
    rs_sv_arret_p = str(data['properties']['rs_sv_arret_p'])
    rs_sv_cours_a = str(data['properties']['rs_sv_cours_a'])
    mdate = str(data['properties']['mdate'])
    # verifier si l'horaire est deja present dans la base de donnees
    requete = "SELECT * FROM horairesData WHERE gid = "+str(gid)+";"
    cursor.execute(requete)
    try : 
        mdate_present = str(cursor.fetchall()[0][7])
    except:
        mdate_present=""
    # si l'horaire n'est pas present dans la table horairesData alors l'ajouter
    if len(mdate_present) == 0:
        print("Ajout de l'horaire : "+str(gid))
        #ajout de l'horaire dans la horairesData
        requete = "INSERT INTO horairesData (gid, hor_theo, hor_app, hor_real, rs_sv_arret_p, rs_sv_cours_a, mdate) VALUES ("+str(gid)+",'"+hor_theo+"','"+hor_app+"','"+hor_real+"',"+str(rs_sv_arret_p)+","+str(rs_sv_cours_a)+",'"+mdate+"');"
        try :
            cursor.execute(requete)
        except :
            print("Erreur Bdd : "+requete)
    else :
        print("L'horaire : "+str(gid)+" est deja present dans la base de donnees")
        # si l'horaire est deja present dans la table horairesData alors verifier que les donnees sont a jour avec la date mdate
        if str(mdate_present) != convertorHoraire(str(mdate)):
            print("Mise a jour de l'horaire : "+str(gid))
            requete = "UPDATE horairesData SET hor_theo = '"+hor_theo+"', hor_app = '"+hor_app+"', hor_real = '"+hor_real+"', rs_sv_arret_p = "+str(rs_sv_arret_p)+", rs_sv_cours_a = "+str(rs_sv_cours_a)+", mdate = '"+mdate+"' WHERE gid = "+str(gid)+";"
            try :
                cursor.execute(requete)
            except :
                print("Erreur Bdd : "+requete)
    

def ajout_donnee_dbb(data,bdd):
    if bdd == "arretsData":
        ajout_arretsData(data)
    elif bdd == "lignesData":
        ajout_lignesData(data)
    elif bdd == "tronconsData":
        ajout_tronconsData(data)
    elif bdd == "relationsLignesTronconsData":
        ajout_relationsLignesTronconsData(data)
    elif bdd == "horairesData":
        ajout_horairesData(data)
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
telechargerFichierJsonSTREAM('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_horai_a', 'horairesData', 1024)



cursor.close()
cnx.close()