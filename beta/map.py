import folium ## folium est une bibliothèque qui permet de créer des cartes interactives en s'appuyant sur leaflet.js
import requests ## requests est une bibliothèque qui permet de faire des requêtes http pour les API
import json ## json est une bibliothèque qui permet de manipuler des fichiers json


def color_vehicule(data):
    if data['fields']['vehicule'] == "TRAM":
        return "red"
    else :
        return "blue"

map = folium.Map(location=[44.795170, -0.603537], zoom_start=14, min_zoom=14,max_bounds=True, min_lat=44.795170,max_lat=44.795170,min_lon= -0.603537, max_lon=-0.603537) ## On crée une carte centrée sur Bordeaux


parking_group = folium.FeatureGroup(name="Parking").add_to(map) ## On crée un groupe pour les parkings
with open('parking_cord.json') as mon_fichier: ## On ouvre le fichier json qui contient les coordonnées des parkings
    data = json.load(mon_fichier) ## On charge le fichier json dans la variable data
    for i in data:
        parking_group.add_child(folium.Marker(location=[i["geometry"]["coordinates"][1], i["geometry"]["coordinates"][0]], popup="C'est un parking !", icon=folium.Icon(color='red'))) ## On ajoute un marqueur pour chaque parking        


pdc_group = folium.FeatureGroup(name="Points de charge").add_to(map) 
with open('point_de_charge_cord.json') as mon_fichier:
    data = json.load(mon_fichier)
    for i in data:
        pdc_group.add_child(folium.Marker(location=[i["geometry"]["coordinates"][1], i["geometry"]["coordinates"][0]], popup="C'est un point de charge !", icon=folium.Icon(color='green')))

covoiturage_group = folium.FeatureGroup(name="Covoiturage").add_to(map)
with open('covoiturage_cord.json') as mon_fichier:
    data = json.load(mon_fichier)
    for i in data:
        covoiturage_group.add_child(folium.Marker(location=[i["geometry"]["coordinates"][1], i["geometry"]["coordinates"][0]], popup="C'est un point de covoiturage !", icon=folium.Icon(color='blue')))


autopartage_group = folium.FeatureGroup(name="Autopartage").add_to(map)
with open('autopartage_cord.json') as mon_fichier:
    data = json.load(mon_fichier)
    for i in data:
        autopartage_group.add_child(folium.Marker(location=[i["geometry"]["coordinates"][1], i["geometry"]["coordinates"][0]], popup="C'est un point d'autopartage !", icon=folium.Icon(color='orange')))

dico_chemins = {}
lignes_group = folium.FeatureGroup(name="Lignes de transport").add_to(map)

with open('chemins_lignes.json') as mon_fichier:
    data = json.load(mon_fichier)
    
    for i in data:
        tmp = i['fields']['geo_shape']['coordinates']
        # inverser les coordonnées dans tmp
        for j in tmp:
            j.reverse()
        folium.PolyLine(i['fields']['geo_shape']['coordinates'], color=color_vehicule(i), weight=2.5, opacity=1).add_to(lignes_group)

    
folium.LayerControl().add_to(map) ## On ajoute un contrôle pour activer/désactiver les couche
map.save(outfile='map.html') ## On sauvegarde la carte dans un fichier html

