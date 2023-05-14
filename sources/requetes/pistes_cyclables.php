<?php

$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
  SELECT DISTINCT pistes_velo.*, types_pistes_velo.nom as type_piste
  FROM pistes_velo
  INNER JOIN types_pistes_velo
    ON types_pistes_velo.id = pistes_velo.type_piste
  INNER JOIN situer_pistes_velo
    ON situer_pistes_velo.piste_velo = pistes_velo.id
  INNER JOIN coordonnees_pistes_velo
    ON coordonnees_pistes_velo.id = situer_pistes_velo.coordonnee
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
      // on recupere les coordonnees de la piste
      $result2 = $db->query("SELECT coordonnees_pistes_velo.latitude AS latitude, coordonnees_pistes_velo.longitude AS longitude FROM coordonnees_pistes_velo INNER JOIN situer_pistes_velo ON situer_pistes_velo.coordonnee = coordonnees_pistes_velo.id WHERE piste_velo = ".$row['id'].";");
      $row = array_merge($row, array("coordonnees" => array()));
      while ($row2 = $result2->fetch_assoc()) {
          $row['coordonnees'][] = array("latitude" => $row2['latitude'], "longitude" => $row2['longitude']);
      }

      $result2->free();
      // on ajoute la station courante à la liste des stations
      $pistes_velo[] = $row;
  }
  // on libere la memoire
  $result->free();
  echo json_encode($pistes_velo);
} else {
  echo "Error executing query: " . $db->error;
}

$db->close();
?> 
