<!DOCTYPE html>
<html>
<head>
  <title>Ajouter des données à la base de données</title>
</head>
<body>
<?php
 // Récupération des données du formulaire
  $jsonData = $_POST['json-data'];
    $jsonData = json_decode($jsonData, true);
  $dataType = $_POST['data-type'];

  // recuperation info de connection par post
    $servername = "localhost";
    $username = $_POST['user'];
    $password = $_POST['password'];
    $dbname = $_POST['database'];
  if ($conn = new mysqli($servername, $username, $password, $dbname)) {
  } else {
    echo "Connexion échouée";
  }

  // recupere les informations obligatoires pour la table selectionnée
    $sql = "SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$dataType' and COLUMN_NAME!='id';";
    if ($result = $conn->query($sql)) {
        $columns_obligatoire = array();
        $columns_type = array();
        $columns_type2 = array();
        $columns_non_primaire = array();
        while ($row = $result->fetch_assoc()) {
            if ($row['COLUMN_KEY'] != "PRI") {
                array_push($columns_non_primaire, $row['COLUMN_NAME']);
                array_push($columns_type2, $row['DATA_TYPE']);
                if ($row['IS_NULLABLE'] == "NO") {
                    array_push($columns_obligatoire, $row['COLUMN_NAME']);
                    array_push($columns_type, $row['DATA_TYPE']);
                }
            }
        }
    } else {
      echo "Requête échouée";
      echo $conn->error;
    }
    // en fonction des données obligatoire on verifie que les données $jsonData sont valides ou pas
    $valid = true;
    for ($j = 0; $j<count($jsonData);$j++){
        $i = 0;
        foreach ($columns_obligatoire as $column) {
            if ($jsonData[$j][$column] == null) {
                $valid = false;
                echo "erreur : " . $column . ", de type ". $columns_type[$i] ." est obligatoire";
            }
            if ($columns_type[$i] == "int") {
                if (!is_numeric($jsonData[$j][$column])) {
                    $valid = false;
                    echo "erreur : Le type de" . $column . " est invalide. Type requis : " . $columns_type[$i];
                }
            }
            if ($jsonData[$j]["latitude"] == null && $jsonData[$j]["Latitude"] == null && $jsonData[$j]["lat"] == null && $jsonData[$j]["Lat"] == null) {
                $valid = false;
                echo "erreur : latitude manquante, utilisez latitude, Latitude, lat ou Lat";
            }
            if ($jsonData[$j]["longitude"] == null && $jsonData[$j]["Longitude"] == null && $jsonData[$j]["long"] == null && $jsonData[$j]["Long"] == null) {
                $valid = false;
                echo "erreur : longitude manquante, utilisez longitude, Longitude, long ou Long";
            }
        }
        $i++;
    } 
    for ($j = 0; $j < count($jsonData); $j++) {
        $i = 0;
        foreach ($columns_non_primaire as $column) {
            if ($jsonData[$j][$column] != null) {
                if ($columns_type2[$i] == "int") {
                    if (!is_numeric($jsonData[$j][$column])) {
                        $valid = false;
                        echo "erreur2 : Le type de" . $column . " est invalide. Type requis : " . $columns_type2[$i];
                    }
                }
            }
        }
        $i++;
    }


    if ($valid) {
        // si les données sont valides on les ajoute à la table selectionnée
    for ($j = 0; $j < count($jsonData); $j++) {
        $sql = "INSERT INTO $dataType (";
        $i = 0;
        for ($i = 0; $i < count($columns_non_primaire); $i++) {
            if ($i == 0) {
                $sql .= $columns_non_primaire[$i];
            } else {
                $sql .= ", " . $columns_non_primaire[$i];
            }
        }
        $sql .= ") VALUES (";
        $i = 0;
        for ($i = 0; $i < count($columns_non_primaire); $i++) {
            if ($i == 0) {
                $sql .= "'" . $jsonData[$j][$columns_non_primaire[$i]] . "'";
            } else {
                $sql .= ", '" . $jsonData[$j][$columns_non_primaire[$i]] . "'";
            }
        }
        $sql .= ");";
        if ($conn->query($sql) === TRUE) {
            echo "Nouvel enregistrement créé avec succès";
        } else {
            echo "Erreur: " . $sql . "<br>" . $conn->error;
        }
        // ajouter maintenant les données dans la table coordonnees_gps et à la table de correspondance entre les tables et les coordonnees : emplacement_[table]
        $sql = "SELECT id FROM $dataType ORDER BY id DESC LIMIT 1;";
        if ($result = $conn->query($sql)) {
            $id = $result->fetch_assoc()['id'];
            $sql = "INSERT INTO coordonnees_gps (latitude, longitude) VALUES (";
            if ($jsonData[$j]["latitude"] != null) {
                $sql .= $jsonData[$j]["latitude"] . ", " . $jsonData[$j]["longitude"] . "), (";
            } else if ($jsonData[$j]["Latitude"] != null) {
                $sql .= $jsonData[$j]["Latitude"] . ", " . $jsonData[$j]["Longitude"] . "), (";
            } else if ($jsonData[$j]["lat"] != null) {
                $sql .= $jsonData[$j]["lat"] . ", " . $jsonData[$j]["long"] . "), (";
            } else if ($jsonData[$j]["Lat"] != null) {
                $sql .= $jsonData[$j]["Lat"] . ", " . $jsonData[$j]["Long"] . "), (";
            }
            $sql = substr($sql, 0, -3);
            $sql .= ";";
            if ($conn->query($sql) === TRUE) {
                echo "Nouvel enregistrement créé avec succès";
            } else {
                echo "Erreur: " . $sql . "<br>" . $conn->error;
            }
            $sql = "SELECT id FROM coordonnees_gps ORDER BY id DESC LIMIT 1;";
            if ($result = $conn->query($sql)) {
                $id_gps = $result->fetch_assoc()['id'];
                $sql = "INSERT INTO emplacements_$dataType (reference, point) VALUES (";
                $sql .= $id . ", " . $id_gps . "), (";
                $id--;
                $id_gps--;

                $sql = substr($sql, 0, -3);
                $sql .= ";";
                if ($conn->query($sql) === TRUE) {
                    echo "Nouvel enregistrement créé avec succès";
                    //formualaire de retour à ../crud.php avec info de connection
                    echo "<form action='../crud.php' method='post'>
                    <input type='hidden' name='dataType' value='$dataType'>
                    <input type='hidden' name='user' value='$username'>
                    <input type='hidden' name='password' value='$password'>
                    <input type='submit' value='Retour'>
                    </form>";
                } else {
                    echo "Erreur: " . $sql . "<br>" . $conn->error;
                }
            }
        }
    }
    }
?>

</body>