import os
import json



import json

def get_coordinates_path(json_string: str) -> list:
    json_data = json.loads(json_string)
    coordinates_path = []
    def find_coordinates(data, path):
        if isinstance(data, dict):
            for key, value in data.items():
                if key == "coordinates":
                    coordinates_path.extend(path + [key])
                    return
                else:
                    find_coordinates(value, path + [key])
        elif isinstance(data, list):
            for i, item in enumerate(data):
                find_coordinates(item, path + [i])
    find_coordinates(json_data, [])
    if coordinates_path:
        return coordinates_path
    else:
        return None




# Demande le nom du fichier JSON à l'utilisateur
json_filename = input("Entrez le nom du fichier JSON : ")

with open("../donnees/json/"+json_filename, "r") as f:
    json_string = f.read()

coordinates_path = get_coordinates_path(json_string)
##trouver la premiere occurence de coordinates dans coordinates_path
coordinates_path_str = ""
for i in coordinates_path:
    if i == "coordinates":
        coordinates_path_str += str(i)
        break
    coordinates_path_str += str(i) + "."
##enlever tous ce qui est avant le premier point
coordinates_path_str = coordinates_path_str[coordinates_path_str.find(".")+1:]


# Demande la couleur de logo à l'utilisateur
logo_color = input("Entrez la couleur de logo souhaitée (rouge, vert, bleu, etc.) : ")

# Génère un identifiant unique pour le nouveau layer
layer_id = "feature_group_" + os.urandom(16).hex() + "_" + json_filename.replace(".json", "")

# Génère le code à ajouter au fichier map.js
code_to_add = f"""
    var {layer_id} = L.featureGroup(
        {{}}
    ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

    $.ajax({{
        url: '../donnees/json/{json_filename}',
        type: 'GET',
        dataType: 'json',
        success: function(data) {{
            $.each(data, function(key, val) {{
                // Récupération des valeurs de latitude et longitude
                var latitude = parseFloat(val.{coordinates_path_str}[1]);
                var longitude = parseFloat(val.{coordinates_path_str}[0]);
                if (isNaN(latitude) || isNaN(longitude)) {{
                    return;
                }}
                // Ajout d'un marker sur la carte
                L.marker([latitude, longitude], {{icon: L.AwesomeMarkers.icon({{icon: 'info-sign', markerColor: '{logo_color}'}})}}).addTo({layer_id});
            }});
        }}
    }});
"""


# Code à ajouter au début de la ligne "overlays :  {"
code_to_add_2 = f'"{json_filename.replace(".json", "")}" : {layer_id},'

# Ouvre le fichier map.js en mode lecture
with open("map.js", "r") as f:
    # Lit le contenu du fichier
    content = f.read()

# Recherche la position de la ligne "overlays :  {"
pos = content.find("overlays :  {")

# Insère le code avant cette ligne
content = content[:pos+13] + code_to_add_2 + content[pos+13:]

# Recherche la position de la ligne "function updateMarkersVehicule() {"
pos = content.find("function updateMarkersVehicule() {")

# Insère le code avant cette ligne
content = content[:pos] + code_to_add + content[pos:]

# Ouvre le fichier map.js en mode écriture
with open("map.js", "w") as f:
    # Écrit le nouveau contenu du fichier
    f.write(content)
    
    
    
#Génère le code à ajouter au fichier index.html
code_to_add = f"""
    <button type="button" class="collapsible">{json_filename.replace(".json", "")}</button>
    <div class="content">
    <input type="checkbox" class="{json_filename.replace(".json", "")}Checkbox" checked>
    <label for="{json_filename.replace(".json", "")}Checkbox">{json_filename.replace(".json", "")}</label>
    <script>
    if ($(".{json_filename.replace(".json", "")}Checkbox").is(':checked')) {{var {json_filename.replace(".json", "")}Checkbox = true;}} else {{var {json_filename.replace(".json", "")}Checkbox = false;}}
    </script>
    <script>
    $(".{json_filename.replace(".json", "")}Checkbox").click(function(){{
    if ({json_filename.replace(".json", "")}Checkbox===true) {{
    layerControlNumber.overlays["{json_filename.replace(".json", "")}"].remove();
    {json_filename.replace(".json", "")}Checkbox=false;
    }}
    else if ({json_filename.replace(".json", "")}Checkbox===false) {{
    layerControlNumber.overlays["{json_filename.replace(".json", "")}"].addTo(mapNumber);
    {json_filename.replace(".json", "")}Checkbox=true;
    }}
    }});
    </script>
    </div>
"""

#Ouvre le fichier index.html en mode lecture
with open("../index.html", "r") as f:
# Lit le contenu du fichier
    content = f.read()

#Recherche la position de la ligne "<button type="button" class="collapsible">Etat du traffic</button>"
pos = content.find('<button type="button" class="collapsible">Etat du traffic</button>')

#Insère le code avant cette ligne
content = content[:pos] + code_to_add + content[pos:]

#Ouvre le fichier index.html en mode écriture
with open("../index.html", "w") as f:
# Écrit le nouveau contenu du fichier
    f.write(content)

