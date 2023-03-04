<?php
$url = "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=ci_vcub_p";
$json = file_get_contents($url);
$data = json_decode($json, true);

$filteredData = array();


$nb_places_libres=0;
$nb_velos_disponibles = 0;
$nb_velos_elec_disponibles = 0;
$nb_velos_classiques_disponibles = 0;
$nb_stations = 0;
$nb_stations_totales = 0;

foreach ($data['features'] as $feature) {

    $nb_stations_totales += 1;
    $latitude = floatval($feature['geometry']['coordinates'][1]);
    $longitude = floatval($feature['geometry']['coordinates'][0]);
    
    if (!is_nan($latitude) && !is_nan($longitude) && ($latitude < 44.829622 && $latitude > 44.776781 && $longitude < -0.5535 && $longitude > -0.644965)) {
        $nb_places_libres = $nb_places_libres + intval($feature['properties']['nbplaces']);
        $nb_velos_disponibles += intval($feature['properties']['nbvelos']);
        $nb_velos_elec_disponibles += intval($feature['properties']['nbelec']);
        $nb_velos_classiques_disponibles += intval($feature['properties']['nbclassiq']);
        $nb_stations += 1;
    }
}

//liste des elements
$elements = array();
$elements['nb_places_libres'] = $nb_places_libres;
$elements['nb_velos_disponibles'] = $nb_velos_disponibles;
$elements['nb_velos_elec_disponibles'] = $nb_velos_elec_disponibles;
$elements['nb_velos_classiques_disponibles'] = $nb_velos_classiques_disponibles;
$elements['nb_stations'] = $nb_stations;
$elements['nb_stations_totales'] = $nb_stations_totales;

echo json_encode($elements);
?>