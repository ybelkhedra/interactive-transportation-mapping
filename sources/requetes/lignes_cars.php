<?php


  $db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT * FROM trips;
")){

    $trips = array();
    while ($row = $result->fetch_assoc()) {
      $row = array_merge($row, array("ligne_car" => array()));
      if ($result2 = $db->query("SELECT * FROM shapes WHERE shape_id = '".$row["shape_id"]."' ORDER BY shape_pt_sequence;")){
        while ($row2 = $result2->fetch_assoc()) {
          $row["ligne_car"][] = array(
            "latitude" => $row2["shape_pt_lat"],
            "longitude" => $row2["shape_pt_lon"]
          );
        }
      }
      $trips[] = $row;
    }
    // echo json_encode($trips);
    //ecrire le resulat json_encode($trips); dans un fichier
    $fp = fopen('trips.json', 'w');
    fwrite($fp, json_encode($trips));
    fclose($fp);
    
  } else {
    echo "Error executing query: " . $db->error;
  }




  $db->close();
  ?> 

