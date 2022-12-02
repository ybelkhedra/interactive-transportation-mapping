import folium
import requests
import json
map = folium.Map(location=[44.795170, -0.603537], zoom_start=14)

with open('parking_cord.json') as mon_fichier:
    data = json.load(mon_fichier)
    for i in data:
        map.add_child(folium.Marker(location=[i["geometry"]["coordinates"][1], i["geometry"]["coordinates"][0]], popup="C'est un parking !", icon=folium.Icon(color='red')))
        
        
map.save(outfile='map.html')

