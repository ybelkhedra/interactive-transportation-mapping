<?php
// <!-- 
// On fait la liste des lignes de cars, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS sous forme de liste de points qui lui sont associés
// - l'arret de depart 
// - celui de destination
// - pas besoin de la liste des arrets !
// -->
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT lignes_cars.*, latitude, longitude
FROM lignes_cars
INNER JOIN situer_lignes_cars
    ON lignes_cars.id = situer_lignes_cars.ligne_car
INNER JOIN coordonnees_lignes_cars
    ON situer_lignes_cars.coordonnee = coordonnees_lignes_cars.id
;
")){
    $lignes_car = array();
    $temp = array();
    $prev_id = null;
    while ($row = $result->fetch_assoc()) {
      if (isset($row)) {
        if ($row['id'] != $prev_id) {
          if (!empty($temp)) {
            $ligne_car = array(
                "id" => $prev_id,
                "car_express" => isset($temp[0]["car_express"]) ? $temp[0]["car_express"] : null,
                "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
                "numero" => isset($temp[0]["numero"]) ? $temp[0]["numero"] : null,
                "depart" => isset($temp[0]["depart"]) ? $temp[0]["depart"] : null,
                "destination" => isset($temp[0]["destination"]) ? $temp[0]["destination"] : null,
            );
            foreach ($temp as &$info) {
              unset($info["car_express"]);
              unset($info["info_complementaires"]);
              unset($info["numero"]);
              unset($info["depart"]);
              unset($info["destination"]);
            }
            $ligne_car["coordonnees"]=$temp;
            $lignes_car[] = $ligne_car;
            $temp = array();
          }
          $prev_id = $row['id'];
        }
        $temp[] = array(
          "car_express" => $row["car_express"],
          "info_complementaires" => $row["info_complementaires"],
          "numero" => $row["numero"],
          "depart" => $row["depart"],
          "destination" => $row["destination"],
          "latitude" => $row["latitude"],
          "longitude" => $row["longitude"]
        );
      }
    }
    if (!empty($temp)) {
      $ligne_car = array(
        "id" => $prev_id,
        "car_express" => isset($temp[0]["car_express"]) ? $temp[0]["car_express"] : null,
        "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
        "numero" => isset($temp[0]["numero"]) ? $temp[0]["numero"] : null,
        "depart" => isset($temp[0]["depart"]) ? $temp[0]["depart"] : null,
        "destination" => isset($temp[0]["destination"]) ? $temp[0]["destination"] : null,
      );
    foreach ($temp as &$info) {
        unset($info["car_express"]);
        unset($info["info_complementaires"]);
        unset($info["numero"]);
        unset($info["depart"]);
        unset($info["destination"]);
      }
      $ligne_car["coordonnees"]=$temp;
      $lignes_car[] = $ligne_car;
    }
    echo json_encode($lignes_car);
  } else {
    echo "Error executing query: " . $db->error;
  }
  
  $db->close();
  ?> 

