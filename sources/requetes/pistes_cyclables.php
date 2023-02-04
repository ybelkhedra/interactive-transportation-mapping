<?php
// <!-- 
// On fait la liste des pistes_cyclables, avec pour chacun toutes ses informations statiques mais aussi : 
// - la position GPS sous forme de liste de points qui lui sont associés
// - le type de piste (pas besoin de liste car c'est unique)
// -->

$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
  SELECT pistes_velo.*, types_pistes_velo.nom as type_piste, situer_pistes_velo.coordonnee, latitude, longitude
  FROM pistes_velo
  INNER JOIN types_pistes_velo
    ON types_pistes_velo.id = pistes_velo.type_piste
  INNER JOIN situer_pistes_velo
    ON situer_pistes_velo.piste_velo = pistes_velo.id
  INNER JOIN coordonnees_pistes_velo
    ON coordonnees_pistes_velo.id = situer_pistes_velo.coordonnee
")) {
  $pistes_velo = array();
  $temp = array();
  $prev_id = null;
  while ($row = $result->fetch_assoc()) {
    if ($row['id'] != $prev_id) {
      if (!empty($temp)) {
        $piste = array(
            "id" => $prev_id,
            "type_piste" => isset($temp[0]["type_piste"]) ? $temp[0]["type_piste"] : null,
            "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
        );
        foreach ($temp as &$info) {
          unset($info["type_piste"]);
          unset($info["info_complementaires"]);
        }
        $piste["coordonnees"]=$temp;
        $pistes_velo[] = $piste;
        $temp = array();
      }
      $prev_id = $row['id'];
    }
    $temp[] = array(
      "type_piste" => $row["type_piste"],
      "info_complementaires" => $row["info_complementaires"],
      "latitude" => $row["latitude"],
      "longitude" => $row["longitude"]
    );
  }
  //Il doit y avoir un moyen plus efficace d'obtenir le dernier dictionnaire mais pour l'instant je ne le vois pas//
  if ($row['id'] != $prev_id) {
    if (!empty($temp)) {
      $piste = array(
          "id" => $prev_id,
          "type_piste" => isset($temp[0]["type_piste"]) ? $temp[0]["type_piste"] : null,
          "info_complementaires" => isset($temp[0]["info_complementaires"]) ? $temp[0]["info_complementaires"] : null,
      );
      foreach ($temp as &$info) {
        unset($info["type_piste"]);
        unset($info["info_complementaires"]);
      }
      $piste["coordonnees"]=$temp;
      $pistes_velo[] = $piste;
      $temp = array();
    }
    $prev_id = $row['id'];
  }
    echo json_encode($pistes_velo);
}

  $db->close();

    ?>