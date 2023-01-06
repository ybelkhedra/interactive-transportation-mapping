import os
import json
import shutil
import datetime

def detect_array_type(arr):
    if isinstance(arr, list):
        # Le tableau est au moins un tableau simple
        array_type = "simple"
        # Vérifiez si le tableau contient d'autres tableaux
        for item in arr:
            if isinstance(item, list):
                array_type = "array of arrays"
                break
    else:
        array_type = "not an array"
    return array_type

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
    
    
def add_file():
    print("Ajout d'un fichier JSON")
    file = input("Entrez le chemin d'accès complet au fichier JSON : ")
    #tester si le fichier existe
    if os.path.isfile(file):
        #tester si le fichier est un fichier json
        if file.endswith(".json"):
            #tester si le fichier est vide
            if os.stat(file).st_size == 0:
                print("Le fichier est vide")
                add_file()
            else:
                with open(file, "r") as f:
                    data_string = f.read()
                path = get_coordinates_path(data_string)
                if path == None:
                    print("Le fichier JSON n'est pas valide")
                    add_file()
                else:
                    print("Le fichier est valide")
                    ## decoder le fichier json
                    decode = json.loads(data_string)
                    d=decode
                    #jusqu'à la premiere occurence de coordinates dans path (exclu)
                    for i in path:
                        if i == "coordinates":
                            break
                        d = d[i]
                        
                    if detect_array_type(d["coordinates"]) == "simple" :
                        print("Le dictionnaire de coordonnées contient simplement une latitude et une longitude, il s'agit donc d'un point, nous vous sugerrons d'utiliser des markers")
                        shutil.copy(file, "../donnees/json")
                    elif detect_array_type(d["coordinates"]) == "array of arrays" :
                        print("Le dictionnaire de coordonnées contient une liste de coordonnées gps, nous vous sugerrons d'utiliser des polylines")
                        #copier le fichier json dans le dossier donnees/json
                        shutil.copy(file, "../donnees/json")
                    else :
                        print("Le dictionnaire ne semble pas contenir de coordonnées gps sous le format attendu")
                        add_file()
                    return data_string       
        else :
            print("Le fichier n'est pas un fichier JSON")
    else:
        print("Le fichier n'existe pas")
    return None
    

def add_data():
    # Demande si il souhaite importer un fichier json ou si il existe déjà sur le serveur
    importation = input("Souhaitez-vous importer un fichier JSON ? (oui/non) : ")
    if importation == "oui":
        json_string = add_file()
        if json_string == None:
            add_data()      
    # affiche la liste des fichiers json dans le dossier donnees/json
    print("Voici la liste des fichiers JSON disponibles : ")
    for file in os.listdir("../donnees/json"):
        print(file)    
    json_filename = input("Entrez le nom du fichier JSON : ")

    with open("../donnees/json/"+json_filename, "r") as f:
        json_string = f.read()
        
    # Demande à l'utilisateur si il souhaite afficher de simple marqueurs et des polylines
    polylines = input("Souhaitez-vous afficher des markers ou polylines ? (markers/polylines) : ")
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

    if polylines == "markers":
        print("Ajout de markers")
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
    elif polylines == "polylines":
        print("Ajout de polylines")
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
                        //inverser les coordonnées de val.fields.geo_shape.coordinates
                         for (var i = 0; i < val.fields.geo_shape.coordinates.length; i++)
                                val.{coordinates_path_str}[i].reverse();
                        L.polyline(val.{coordinates_path_str}, {{color: '{logo_color}'}}).addTo({layer_id});
                    }});
                }}
            }});
            
        """
        
    #Creation de sauvegarde du fichier map.js et index.html dans /backup_auto
    date = datetime.datetime.now()
    shutil.copy("../index.html", "../backup_auto/index_"+str(date)+".html")
    shutil.copy("../sources/map.js", "../backup_auto/map_"+str(date)+".js")
    
    accord = input("Le programme va effectuer des modifications lourdes dans les fichiers map.js et index.html.\n Pour des raisons de sécurité un backup a été créé dans le dossier backup_auto, appuyer sur n'importe quelle touche pour continuer : ")
    
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
    print("L'ajout des données est terminé !")

def backup():
    #affiche les dates de sauvegarde contenu dans le dossier backup_auto
    for file in os.listdir("../backup_auto"):
        if file.endswith(".html"):
            #affiche la date de sauvegarde situé apres _ et avant .html
            print(file[file.find("_")+1:file.find(".html")])
    #demande à l'utilisateur de choisir une date de sauvegarde
    date_restore = input("Quelle date voulez-vous restaurer ? (Astuce : copier/coller) : ")
    try : 
        shutil.copy("../backup_auto/map_"+str(date_restore)+".js","../sources/map.js")
        shutil.copy("../backup_auto/index_"+str(date_restore)+".html", "../index.html")
    except:
        print("Erreur de restauration")
        print("Verifiez que la date de sauvegarde est correcte")
        backup()
    print("Restauration effectuée")
    menu()
    
    

def menu():
    choix = input("Pour ajouter des données tapez 1, pour revenir à une version anterieur tapez 2 : ")
    if choix == "1":
        add_data()
    elif choix == "2":
        backup()
    else :
        print("Erreur de saisie")
        menu()


menu()