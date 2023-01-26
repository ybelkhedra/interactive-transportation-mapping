import os
import json
import shutil
import datetime
import requests

#Programme qui se connecte au API de openData pour recuperer les arrets de bus, les lignes de bus, les horaires appliquables a chaque arret et les ajoute a la base de donnees

def getJSON(url) :
    reponse = requests.get(url)
    #decode le json
    reponse = reponse.json()
    return reponse
   
arretsData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_arret_p'); 
lignesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_chem_l');
tronconData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_tronc_l');
relationLigneTronconData = getJSON('https://data.bordeaux-metropole.fr/geojson/relations/SV_TRONC_L/SV_CHEM_L?key=177BEEMTWZ');
# horairesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_horai_a');
nomCommercialData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_ligne_a');

taille = len(arretsData['features'])
LISTE_ARRETS = []
# Pour chaque arrets, on affiche les lignes qui passent par cet arrêt, les horaires de passage et les informations generales comme le nom, la localisation, etc.
for i in range (0,taille//8):
    # On recupere les informations generales de l'arret
    arret = arretsData['features'][i]
    arret_id = arret['properties']['gid']
    arret_nom = arret['properties']['libelle']
    print("Traitement de l'arret " + arret_nom + " (" + str(i+1) + "/" + str(taille) + ")" )   
    arret_lat = arret['geometry']['coordinates'][1]
    arret_lon = arret['geometry']['coordinates'][0]
    dico_arret = {'nom':arret_nom,'lat':arret_lat,'lon':arret_lon}
    lignes_arret = []
    # On recupere les lignes qui passent par cet arret en recuperant d'abord les troncons qui passent par cet arret
    for j in range (0,len(tronconData['features'])):
        troncon = tronconData['features'][j]
        troncon_id = troncon['properties']['gid']
        if troncon['properties']['rg_sv_arret_p_nd'] == arret_id or troncon['properties']['rg_sv_arret_p_na'] == arret_id :
            # On recupere les lignes qui passent par ce troncon
            for k in range (0,len(relationLigneTronconData['features'])):
                relationLigneTroncon = relationLigneTronconData['features'][k]
                if relationLigneTroncon['properties']['rs_sv_tronc_l'] == troncon_id :
                    try :
                        ligne_id = relationLigneTroncon['properties']['rs_sv_chem_l']
                    except :
                        ligne_id = relationLigneTroncon['properties']['rg_sv_chem_l']
                    # On recupere les informations generales de la ligne
                    for l in range (0,len(lignesData['features'])):
                        ligne = lignesData['features'][l]
                        if ligne['properties']['gid'] == ligne_id :
                            rs_sv_ligne_a = ligne['properties']['rs_sv_ligne_a']
                            # On recupere le nom commercial de la ligne
                            for m in range (0,len(nomCommercialData['features'])):
                                nomCommercial = nomCommercialData['features'][m]
                                if nomCommercial['properties']['gid'] == rs_sv_ligne_a :
                                    ligne_nom_commercial = nomCommercial['properties']['libelle']
                                    if ligne_nom_commercial not in lignes_arret :
                                        lignes_arret.append(ligne_nom_commercial)
    dico_arret['lignes'] = lignes_arret
    LISTE_ARRETS.append(dico_arret)
    
LISTE_LIGNES = []
for i in range (0,len(lignesData['features'])):
    ligne = lignesData['features'][i]
    ligne_id = ligne['properties']['gid']
    rs_sv_ligne_a = ligne['properties']['rs_sv_ligne_a']
    # On recupere le nom commercial de la ligne
    for m in range (0,len(nomCommercialData['features'])):
        nomCommercial = nomCommercialData['features'][m]
        if nomCommercial['properties']['gid'] == rs_sv_ligne_a :
            ligne_nom_commercial = nomCommercial['properties']['libelle']
    liste_arrets = []
    for j in LISTE_ARRETS :
        if ligne_nom_commercial in j['lignes'] :
            liste_arrets.append(j['nom'])
    dico_ligne = {'nom':ligne_nom_commercial,'arrets':liste_arrets}
    LISTE_LIGNES.append(dico_ligne)
print(LISTE_LIGNES)