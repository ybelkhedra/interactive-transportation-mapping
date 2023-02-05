import os
import json
import shutil
import datetime
import requests
from tqdm import tqdm



#Programme qui se connecte au API de openData pour recuperer les arrets de bus, les lignes de bus, les horaires appliquables a chaque arret et les ajoute a la base de donnees

def getJSON(url):
    try:
        response = requests.get(url, timeout=90, stream=True)
    except:
        print("Erreur lors du téléchargement de : " + str(url))
        return getJSON(url)

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
    return response

##afficher le % de progression du telechargement
print("Telechargement des donnees...")
arretsData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_arret_p')
with open('arrets.json', 'w') as outfile:
    json.dump(arretsData, outfile)
# arretsData = json.loads(open('arrets.json').read())
print("Telechargement des arrets termine !")
lignesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_chem_l')
with open('lignes.json', 'w') as outfile:
    json.dump(lignesData, outfile)
# lignesData = json.loads(open('lignes.json').read())
print("Telechargement des lignes termine !")
tronconData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_tronc_l')
with open('troncons.json', 'w') as outfile:
    json.dump(tronconData, outfile)
# tronconData = json.loads(open('troncons.json').read())
print("Telechargement des troncons termine !")
relationLigneTronconData = getJSON('https://data.bordeaux-metropole.fr/geojson/relations/SV_TRONC_L/SV_CHEM_L?key=177BEEMTWZ')
with open('relationLigneTroncon.json', 'w') as outfile:
    json.dump(relationLigneTronconData, outfile)
print("Telechargement des relations ligne-troncon termine !")
horairesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_horai_a')
with open('horaires.json', 'w') as outfile:
    json.dump(horairesData, outfile)
# horairesData = json.loads(open('horaires.json').read())
print("Telechargement des horaires termine !")
CoursesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_cours_a')
with open('courses.json', 'w') as outfile:
    json.dump(CoursesData, outfile)
print("Telechargement des courses termine !")
nomCommercialData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_ligne_a')
with open('nomCommercial.json', 'w') as outfile:
    json.dump(nomCommercialData, outfile)
print("Telechargement des noms commerciaux termine !")


def is_in_dico(ligne,vehicule,liste_arret):
    for i in range(0,len(liste_arret)):
        if (ligne == liste_arret[i]['nom'] and vehicule == liste_arret[i]['vehicule']):
            return i
    return -1
    

taille = len(arretsData['features'])
LISTE_ARRETS = []
nb_erreur=0
nb_0_ligne = 0
# Pour chaque arrets, on affiche les lignes qui passent par cet arrêt, les horaires de passage et les informations generales comme le nom, la localisation, etc.
for i in range (0,taille):
    try : 
        # On recupere les informations generales de l'arret
        arret = arretsData['features'][i]
        arret_id = arret['properties']['gid']
        arret_nom = arret['properties']['libelle']
        print("Traitement de l'arret " + arret_nom + " (" + str(i+1) + "/" + str(taille) + ") id : "+str(arret_id) )   
        arret_lat = arret['geometry']['coordinates'][1]
        arret_lon = arret['geometry']['coordinates'][0]
        if ( arret_lat < 44.81 and arret_lat > 44.76 and arret_lon < -0.579 and arret_lon > -0.65):
            arret_vehicule = arret['properties']['vehicule']
            arret_type = arret['properties']['type']
            dico_arret = {'nom':arret_nom,'gid':arret_id,'lat':arret_lat,'lon':arret_lon,'vehicule':arret_vehicule}
            lignes_arret = []
            aller = []
            retour = []
            # On recupere les lignes qui passent par cet arret en recuperant d'abord les troncons qui passent par cet arret
            for j in range (0,len(tronconData['features'])):
                troncon = tronconData['features'][j]
                troncon_id = troncon['properties']['gid']
                if (troncon['properties']['rg_sv_arret_p_nd'] == arret_id or troncon['properties']['rg_sv_arret_p_na'] == arret_id) :
                    #le troncon passe par l'arret
                    #on recupere la ligne correspondante
                    for k in range (0,len(relationLigneTronconData['features'])):
                        if (relationLigneTronconData['features'][k]['properties']['rs_sv_tronc_l'] == troncon_id) :
                            ligne_id = relationLigneTronconData['features'][k]['properties']['rs_sv_chem_l']
                            #on a la ligne, on recupere les informations generales de la ligne
                            for l in range (0,len(lignesData['features'])):
                                if (lignesData['features'][l]['properties']['gid'] == ligne_id) :
                                    ligne = lignesData['features'][l]
                                    ligne_rs_sv = ligne['properties']['rs_sv_ligne_a']
                                    for m in range (0,len(nomCommercialData['features'])):
                                        if nomCommercialData['features'][m]['properties']['gid'] == ligne_rs_sv :
                                            ligne_nom = nomCommercialData['features'][m]['properties']['libelle']
                                            ligne_vehicule = ligne['properties']['vehicule']
                                            ligne_sens = ligne['properties']['sens']
                                            ligne_id = ligne['properties']['gid']
                                            isInDico = is_in_dico(ligne_nom,ligne_vehicule,lignes_arret)
                                            if isInDico == -1 :
                                                if ligne_sens == 'ALLER' :
                                                    dico_ligne = {'nom':ligne_nom,'vehicule':ligne_vehicule, 'aller':[ligne_id], 'retour':[]}
                                                elif ligne_sens == 'RETOUR' :
                                                    dico_ligne = {'nom':ligne_nom,'vehicule':ligne_vehicule, 'aller':[], 'retour':[ligne_id]}
                                                lignes_arret.append(dico_ligne)
                                            else :
                                                if ligne_sens == 'ALLER' :
                                                    lignes_arret[isInDico]['aller'].append(ligne_id)
                                                elif ligne_sens == 'RETOUR' :
                                                    lignes_arret[isInDico]['retour'].append(ligne_id)
                                                                                
            if len(lignes_arret) == 0 :
                nb_0_ligne+=1
                print("L'arret " + arret_nom + " (" + str(i+1) + "/" + str(taille) + ") n'a aucune ligne")
            else :
                dico_arret['lignes'] = lignes_arret
                LISTE_ARRETS.append(dico_arret)
    except :
        nb_erreur+=1
        print("Erreur lors du traitement de l'arret " + arret_nom + " (" + str(i+1) + "/" + str(taille) + ")" )
print("Nombre d'erreurs : " + str(nb_erreur))
print("Nombre d'arrets sans ligne : " + str(nb_0_ligne))



def convertion_gid_arret(gid):
    for arret in arretsData['features']:
        if arret['properties']['gid'] == gid:
            return arret['properties']['libelle']
    return "Erreur"


    
## On enregistre les donnees dans des fichiers json
with open('../donnees/json/resultats_post_traitement/arrets.json', 'w') as outfile:
    json.dump(LISTE_ARRETS, outfile)


with open('../donnees/json/resultats_post_traitement/arrets.json') as json_data:
    arretsDataPostTraitement = json.load(json_data)
taille = len(arretsDataPostTraitement)
for i in range(0,taille):
    print("PostTraitement de l'arret " + str(i+1) + "/" + str(taille) + " : " + arretsDataPostTraitement[i]['nom'])
    arretCourant = arretsDataPostTraitement[i]
    for ligne in arretCourant['lignes']:
        ligne['courses_associees'] = []
        courses_aller = []
        courses_retour = []
        for ligne_sens_aller in ligne['aller']:
            for course in CoursesData['features']:
                if (course['properties']['rs_sv_chem_l'] == ligne_sens_aller) :
                    dico_course = {'gid':course['properties']['gid'], 'arret_depart':convertion_gid_arret(course['properties']['rg_sv_arret_p_nd']), 'arret_arrivee':convertion_gid_arret(course['properties']['rg_sv_arret_p_na']), 'horaires':[]}
                    for h in range(0,len(horairesData['features'])):
                        if (horairesData['features'][h]['properties']['rs_sv_cours_a'] == course['properties']['gid'] and horairesData['features'][h]['properties']['rs_sv_arret_p'] == arretCourant['gid']) :
                            dico_course['horaires'].append({'gid': horairesData['features'][h]['properties']['gid'] , 'heure':horairesData['features'][h]['properties']['hor_estime']})
                    courses_aller.append(dico_course)
        for ligne_sens_retour in ligne['retour']:
            for course in CoursesData['features']:      
                if (course['properties']['rs_sv_chem_l'] == ligne_sens_retour):
                    dico_course = {'gid':course['properties']['gid'], 'arret_depart':convertion_gid_arret(course['properties']['rg_sv_arret_p_nd']), 'arret_arrivee':convertion_gid_arret(course['properties']['rg_sv_arret_p_na']), 'horaires':[]}
                    for h in range(0,len(horairesData['features'])):
                        if (horairesData['features'][h]['properties']['rs_sv_cours_a'] == course['properties']['gid'] and horairesData['features'][h]['properties']['rs_sv_arret_p'] == arretCourant['gid']) :
                            dico_course['horaires'].append({'gid': horairesData['features'][h]['properties']['gid'] ,'heure':horairesData['features'][h]['properties']['hor_estime']})
                    courses_retour.append(dico_course)
        ligne['courses_associees'].append({'aller':courses_aller})
        ligne['courses_associees'].append({'retour':courses_retour})
    arretsDataPostTraitement[i] = arretCourant
        
with open('../donnees/json/resultats_post_traitement/arretsPost.json', 'w') as outfile:
    json.dump(arretsDataPostTraitement, outfile)
        