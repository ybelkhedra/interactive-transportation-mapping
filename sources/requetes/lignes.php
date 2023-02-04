<?php
// <!-- 
// On fait la liste des lignes, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS sous forme de liste de points qui lui sont associés
// - le type de ligne qui lui sont associés
// - la direction (arret) qui lui sont associés
// -->
$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
  SELECT lignes.*, types_lignes.nom as type_ligne, situer_lignes.coordonnee, latitude, longitude
  FROM lignes
  INNER JOIN types_lignes
    ON types_lignes.id = lignes.type
  INNER JOIN situer_lignes
    ON situer_lignes.ligne = lignes.id
  INNER JOIN coordonnees_lignes
    ON coordonnees_lignes.id = situer_lignes.coordonnee
")) {
  $lignes = array();
  $temp = array();
  $prev_id = null;
  while ($row = $result->fetch_assoc()) {
    if ($row['id'] != $prev_id) {
      if (!empty($temp)) {
        $ligne = array(
            "id" => $prev_id,
            "nom" => isset($temp[0]["nom"]) ? $temp[0]["nom"] : null,
            "direction" => isset($temp[0]["direction"]) ? $temp[0]["direction"] : null,
            "type" => isset($temp[0]["type"]) ? $temp[0]["type"] : null,
            "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
        );
        foreach ($temp as &$info) {
          unset($info["nom"]);
          unset($info["direction"]);
          unset($info["type"]);
        }
        $ligne["coordonnees"]=$temp;
        $lignes[] = $ligne;
        $temp = array();
      }
      $prev_id = $row['id'];
    }
    $temp[] = array(
      "nom" => $row["nom"],
      "direction" => $row["direction"],
      "type" => $row["type_ligne"],
      "latitude" => $row["latitude"],
      "longitude" => $row["longitude"]
    );
  }
  //Il doit y avoir un moyen plus efficace d'obtenir le dernier dictionnaire mais pour l'instant je ne le vois pas//
  if (!empty($temp)) {
    $ligne = array(
        "id" => $prev_id,
        "nom" => isset($temp[0]["nom"]) ? $temp[0]["nom"] : null,
        "direction" => isset($temp[0]["direction"]) ? $temp[0]["direction"] : null,
        "type" => isset($temp[0]["type"]) ? $temp[0]["type"] : null,
        "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
    );
    foreach ($temp as &$info) {
      unset($info["nom"]);
      unset($info["direction"]);
      unset($info["type"]);
    }
    $ligne["coordonnees"]=$temp;
    $lignes[] = $ligne;
    $temp = array();
  }

  echo json_encode($lignes);

}
  $db->close();
  




    ?>