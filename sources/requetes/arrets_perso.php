<?php


$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT arrets.*, latitude, longitude
FROM arrets
INNER JOIN situer_arrets
    ON arrets.id = situer_arrets.arret
INNER JOIN coordonnees_arrets
    ON situer_arrets.coordonnee = coordonnees_arrets.id
;
")) {
    while ($row = $result->fetch_assoc()) {
        
        $row = array_merge($row, array("ligne" => array()));
        $result2 = $db->query("SELECT lignes.nom as ligne, lignes.id as id_ligne, arrets.nom as direction, direction as dir_id, heure_premier_passage, heure_dernier_passage, frequence, diurne, nocturne FROM (desservir INNER JOIN lignes ON desservir.ligne = lignes.id) INNER JOIN arrets on lignes.direction = arrets.id WHERE arret = ".$row['id'].";");

        while ($row2 = $result2->fetch_assoc()) {

            // $row['ligne'][] = {"nom":$row2['ligne'],"direction":$row2['direction'],"heure_premier_passage":$row2['heure_premier_passage'],"heure_dernier_passage":$row2['heure_dernier_passage'],"frequence":$row2['frequence'],"diurne":$row2['diurne'],"nocturne":$row2['nocturne']};
            $dico_ligne = array("nom" => $row2['ligne'], "direction" => $row2['direction'], "heure_premier_passage" => $row2['heure_premier_passage'], "heure_dernier_passage" => $row2['heure_dernier_passage'], "frequence" => $row2['frequence'], "diurne" => $row2['diurne'], "nocturne" => $row2['nocturne']);
            

            //on ajoute un tableau a dicto_ligne qui contient les horaires de passage
            $dico_ligne = array_merge($dico_ligne, array("horaires" => array()));
            $result3 = $db->query("SELECT DISTINCT horaire FROM horaires WHERE ligne = ".$row2['id_ligne']." AND direction = ".$row2['dir_id']." AND arret = ".$row['id']." and horaire != 'NULL' ORDER BY horaire;");
            while ($row3 = $result3->fetch_assoc()) {
                $dico_ligne['horaires'][] = $row3['horaire'];
            }
            $result3->free();
            
            $row['ligne'][] = $dico_ligne;
        }
        $result2->free();
        $parkings[] = $row;
    }
    $result->free();
}
echo json_encode($parkings);

$db->close();

?>
