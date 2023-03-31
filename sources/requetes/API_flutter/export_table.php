<?php

$nom_table = $_GET['nom_table'];
$nom_fichier = $_GET['nom_fichier'];
$format = $_GET['format'];

# executer le fichier PHP nom_fichier et recuperer le resultat dans $resultat json
exec("php ../$nom_fichier.php", $resultat);

# recuperer le resultat json dans $resultat_json
$resultat_json = json_decode($resultat[0], true);

if ($format == 'geojson') {

    # si dans la liste des clés du resultat json, il y a la clé 'latitude' et 'longitude' ou 'lat' et 'lon'
    if (array_key_exists('latitude', $resultat_json[0]) && array_key_exists('longitude', $resultat_json[0]) || array_key_exists('lat', $resultat_json[0]) && array_key_exists('lon', $resultat_json[0])) {
        # construction de l'export des données dans le format geojson
        $geojson = array(
            'type'      => 'FeatureCollection',
            'features'  => array()
        );

        # pour chaque ligne du resultat json
        foreach ($resultat_json as $row) {
            ##recuperer la liste des clés du resultat json
            $keys = array_keys($row);
            # faire la liste properties du geojson avec les clés du resultat json sauf 'latitude' et 'longitude' ou 'lat' et 'lon'
            $properties = array();
            foreach ($keys as $key) {
                if ($key != 'latitude' && $key != 'longitude' && $key != 'lat' && $key != 'lon') {
                    $properties[$key] = $row[$key];
                }
            }
            # recuperer la latitude et la longitude
            if (array_key_exists('latitude', $row) && array_key_exists('longitude', $row)) {
                $latitude = $row['latitude'];
                $longitude = $row['longitude'];
            } else if (array_key_exists('lat', $row) && array_key_exists('lon', $row)) {
                $latitude = $row['lat'];
                $longitude = $row['lon'];
            }
            # construire la ligne geojson
            $feature = array(
                'type' => 'Feature',
                'geometry' => array(
                    'type' => 'Point',
                    'coordinates' => array(
                        $longitude,
                        $latitude
                    )
                ),
                'properties' => $properties
            );
            # ajouter la ligne dans le geojson
            array_push($geojson['features'], $feature);
        }
        # sinon si dans la liste des clés du resultat json, il y a la clé 'coord' ou coordonnees ou 'coordinates' qui est un tableau
        if (array_key_exists('coord', $resultat_json[0]) || array_key_exists('coordonnees', $resultat_json[0]) || array_key_exists('coordinates', $resultat_json[0]) && is_array($resultat_json[0]['coordinates'])) {
            # construction de l'export des données dans le format geojson
            $geojson = array(
                'type'      => 'FeatureCollection',
                'features'  => array()
            );

            # pour chaque ligne du resultat json
            foreach ($resultat_json as $row) {
                ##recuperer la liste des clés du resultat json
                $keys = array_keys($row);
                # faire la liste properties du geojson avec les clés du resultat json sauf 'coord' ou 'coordonnees' ou 'coordinates'
                $properties = array();
                foreach ($keys as $key) {
                    if ($key != 'coord' && $key != 'coordonnees' && $key != 'coordinates') {
                        $properties[$key] = $row[$key];
                    }
                }
                # recuperer les coordonnees
                if (array_key_exists('coord', $row)) {
                    $coordinates = $row['coord'];
                } else if (array_key_exists('coordonnees', $row)) {
                    $coordinates = $row['coordonnees'];
                } else if (array_key_exists('coordinates', $row)) {
                    $coordinates = $row['coordinates'];
                }
                # construire la ligne geojson
                $feature = array(
                    'type' => 'Feature',
                    'geometry' => array(
                        'type' => 'Point',
                        'coordinates' => array(
                            $coordinates[0],
                            $coordinates[1]
                        )
                    ),
                    'properties' => $properties
                );
                # ajouter la ligne dans le geojson
                array_push($geojson['features'], $feature);
            }
        }
    }

    # afficher le geojson
    echo json_encode($geojson, JSON_NUMERIC_CHECK);
} else if ($format == 'csv'){
    # construction de l'export des données dans le format csv
    # recuperer la liste des clés du resultat json
    $keys = array_keys($resultat_json[0]);
    # construire la ligne d'entete du csv
    $csv = "";
    foreach ($keys as $key) {
        $csv .= $key . ";";
    }
    $csv .= "\n";
    # pour chaque ligne du resultat json
    foreach ($resultat_json as $row) {
        # construire la ligne du csv
        foreach ($keys as $key) {
            $csv .= $row[$key] . ";";
        }
        $csv .= "\n";
    }
    # afficher le csv
    echo $csv;
}
?>