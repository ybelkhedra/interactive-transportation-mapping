
<?php

if (!function_exists("readline")) {
  function readline($prompt = null){
    if($prompt){
      echo $prompt;
    }
    $fp = fopen("php://stdin","r");
    $line = rtrim(fgets($fp, 1024));
    return $line;
  }
}

function detect_array_type($arr) {
    if (is_array($arr)) {
        $array_type = "simple";
        foreach ($arr as $item) {
            if (is_array($item)) {
                $array_type = "array of arrays";
                break;
            }
        }
    } else {
    $array_type = "not an array";
    }
    return $array_type;
}

function get_coordinates_path($json_string) {
    $json_data = json_decode($json_string, true);
    $coordinates_path = array();
    function find_coordinates($data, $path) {
        if (is_array($data)) {
            foreach ($data as $key => $value) {
                if ($key == "coordinates") {
                    array_push($coordinates_path, $path, $key);
                    return;
                } 
                else {
                    find_coordinates($value, array_merge($path, [$key]));
                }
            }
        }
    }
    find_coordinates($json_data, array());
    if (!empty($coordinates_path)) {
        return $coordinates_path;
    } 
    else {
        return NULL;
    }
}

function add_data()
{
    // Affiche la liste des fichiers JSON dans le dossier donnees/json
    echo "Voici la liste des fichiers JSON disponibles : ";
    foreach (scandir("uploads/") as $file) {
        echo $file;
    }
    $json_filename = readline("Entrez le nom du fichier JSON : ");
    $json_string = file_get_contents("uploads/" . $json_filename);

    // Demande à l'utilisateur si il souhaite afficher de simples marqueurs ou des polylignes
    $polylines = readline("Souhaitez-vous afficher des markers ou des polylines ? (markers/polylines) : ");
    $coordinates_path = get_coordinates_path($json_string);
    // Trouve la première occurence de "coordinates" dans $coordinates_path
    //$coordinates_path_str = "";
    //foreach ($coordinates_path as $i) {
    //    if ($i == "coordinates") {
    //        $coordinates_path_str .= $i;
    //        break;
    //    }
    //    $coordinates_path_str .= $i . ".";
    //}
    
    $coordinates_path_str = $coordinates_path;
    
    // Enlève tout ce qui est avant le premier point
    $coordinates_path_str = substr($coordinates_path_str, strpos($coordinates_path_str, ".") + 1);
    // Demande la couleur de logo à l'utilisateur
    $logo_color = readline("Entrez la couleur de logo souhaitée (red, green, etc.) : ");

    // Génère un identifiant unique pour le nouveau layer
    $layer_id = "feature_group_" . bin2hex(random_bytes(16)) . "_" . str_replace(".json", "", $json_filename);
    
    $polylines == "markers";

    if ($polylines == "markers") {
        echo "Ajout de markers";
        // Génère le code à ajouter au fichier map.js
        $code_to_add = '
            $' . $layer_id . ' = L.featureGroup(
                array()
            )->addTo($map_5c3862ba13c7e615013e758f79b1f9bb);
    
            $.ajax({
                url: "/uploads/' . $json_filename . '",
                type: "GET",
                dataType: "json",
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        $latitude = floatval(val.' . $coordinates_path_str . '[1]);
                        $longitude = floatval(val.' . $coordinates_path_str . '[0]);
                        if (is_nan($latitude) || is_nan($longitude)) {
                            return;
                        }
                        // Ajout d\'une polyline sur la carte
                        $polyline_coordinates = array();
                        foreach (val.' . $coordinates_path_str . ' as $coordinates) {
                            $polyline_coordinates[] = array(floatval($coordinates[1]), floatval($coordinates[0]));
                        }
                        L.polyline($polyline_coordinates, array("color" => "' . $logo_color . '"))->addTo($' . $layer_id . ');
                    });
                }
            });';
    } elseif ($polylines == "polylines") {
        echo "Ajout de polylines";
        // Génère le code à ajouter au fichier map.js
        $code_to_add = '

        var {layer_id} = L.featureGroup(
            {{}}
        ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

        $.ajax({{
            url: "/uploads/' . $json_filename . '",
            type: "GET",
            dataType: "json",
            success: function(data) {{
                $.each(data, function(key, val) {{
                    // Récupération des valeurs de latitude et longitude
                    //inverser les coordonnées de val.' . $coordinates_path_str . '
                     for (var i = 0; i < val.' . $coordinates_path_str . '.length; i++)
                            val.' . $coordinates_path_str . '[i].reverse();
                    L.polyline(val.' . $coordinates_path_str . ', {{color: "' . $logo_color . '"}}).addTo(' . $layer_id . ');
                }});
            }}
        }});
        
        ';
    } else {
        echo "Erreur : veuillez entrer markers ou polylines";
    }

    // Creation de sauvegarde du fichier map.js et index.html dans /backup_auto
    $date = new DateTime();
    $copySuccess = copy("index.html", "backup_auto/index_".$date->format('Y-m-d H:i:s').".html");
    $copySuccess = copy("sources/map.js", "backup_auto/map_".$date->format('Y-m-d H:i:s').".js");

    if ($copySuccess) {
    $accord = readline("Le programme va effectuer des modifications lourdes dans les fichiers map.js et index.html.\n Pour des raisons de sécurité un backup a été créé dans le dossier backup_auto, appuyer sur n'importe quelle touche pour continuer : ");
    } else {
    echo "Erreur lors de la création de la sauvegarde des fichiers.";
    exit;
    }

        // Code à ajouter après la ligne "overlays :  {"
    $code_to_add_2 = '"'.str_replace('.json', '', $json_filename).'" : '.$layer_id.',';

    // Ouvre le fichier map.js en mode lecture
    $content = file_get_contents("map.js");

    // Recherche la position de la ligne "overlays :  {"
    $pos = strpos($content, "overlays :  {");

    // Insère le code après cette ligne
    $content = substr_replace($content, $code_to_add_2, $pos+15, 0);

    // Recherche la position de la ligne "function updateMarkersVehicule() {"
    $pos = strpos($content, "function updateMarkersVehicule() {");

    // Insère le code avant cette ligne
    $content = substr_replace($content, $code_to_add, $pos, 0);

    // Ouvre le fichier map.js en mode écriture
    $fp = fopen("map.js", "w");

    // Écrit le nouveau contenu du fichier
    fwrite($fp, $content);

    // Ferme le fichier
    fclose($fp);

    // Génère le code à ajouter au fichier index.html
    $code_to_add = '
        
    <button type="button" class="collapsible">'.str_replace('.json', '', $json_filename).'</button>
    <div class="content">
    <input type="checkbox" class="'.str_replace('.json', '', $json_filename).'Checkbox" checked>
    <label for="'.str_replace('.json', '', $json_filename).'Checkbox">'.str_replace('.json', '', $json_filename).'</label>
    <script>
    if ($(".'.str_replace('.json', '', $json_filename).'Checkbox").is(":checked")) {var '.str_replace('.json', '', $json_filename).'Checkbox = true;} else {var '.str_replace('.json', '', $json_filename).'Checkbox = false;}
    </script>
    <script>
    $(".'.str_replace('.json', '', $json_filename).'Checkbox").click(function(){
    if ('.str_replace('.json', '', $json_filename).'Checkbox===true) {
    layerControlNumber.overlays["'.str_replace('.json', '', $json_filename).'"].remove();
    '.str_replace('.json', '', $json_filename).'Checkbox=false;
    }
    else if ('.str_replace('.json', '', $json_filename).'Checkbox===false) {
    layerControlNumber.overlays["'.str_replace('.json', '', $json_filename).'"].addTo(mapNumber);
    '.str_replace('.json', '', $json_filename).'Checkbox=true;
    }
    });
    </script>
    </div>

    ';

        // Ouvre le fichier index.html en mode lecture
    $content = file_get_contents("../index.html");

    // Recherche la position de la ligne '<button type="button" class="collapsible">Etat du traffic</button>'
    $pos = strpos($content, '<button type="button" class="collapsible">Etat du traffic</button>');

    // Insère le code avant cette ligne
    $content = substr_replace($content, $code_to_add, $pos, 0);

    // Ouvre le fichier index.html en mode écriture
    $fp = fopen("../index.html", "w");

    // Écrit le nouveau contenu du fichier
    fwrite($fp, $content);

    // Ferme le fichier
    fclose($fp);

    echo "L'ajout des données est terminé !";

}

add_data();

?>