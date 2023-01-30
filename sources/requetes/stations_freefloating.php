<!-- 
    On fait la liste des stations de freefloating, avec pour chacun toutes ses informations statiques mais aussi : 
- la position GPS sous forme de liste de points qui lui sont associés 
- la liste des vehicules autorisés qui lui sont associés
-->

<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

if ($result = $db->query("
SELECT pt_freefloat.*
FROM pt_freefloat INNER JOIN situer_pt_freefloat on pt_freefloat.id = situer_pt_freefloat.pt_freefloat INNER JOIN coordonnees_pt_freefloat on situer_pt_freefloat.coordonnee = coordonnees_pt_freefloat.id, vehicules_freefloating
;
")) {
    // si la requete a réussi, on va parcourir les résultats
    // chaque ligne de la reponse est stockée dans $row (un tableau associatif)
    while ($row = $result->fetch_assoc()) {
        

        $tab_coord = array_merge($row, array("coordonnees" => array()));
        // on recupere les coordonnees
        $result2 = $db->query("SELECT coordonnees_pt_freefloat.latitude AS latitude, coordonnees_pt_freefloat.longitude AS longitude FROM coordonnees_pt_freefloat INNER JOIN situer_pt_freefloat ON situer_pt_freefloat.coordonnee = coordonnees_pt_freefloat.id WHERE pt_freefloat = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $row['coordonnees'][] = array('latitude' => $row2['latitude'], 'longitude' => $row2['longitude']);
        }

        $tab_vehicule = array_merge($tab_coord, array("vehicules_freefloating" => array()));
        $result2 = $db->query("SELECT vehicules_freefloating.vehicule FROM vehicules_freefloating INNER JOIN autoriser ON vehicules_freefloating.id = autoriser.pt_freefloat WHERE pt_freefloat = ".$row['id'].";");
        
        while ($row2 = $result2->fetch_assoc()) {
            // on ajoute le type d'accroche courant à la liste des types d'accroches de la station courante
            $tab_vehicule['vehicules_freefloating'][] = $row2['vehicules_freefloating'];
        }
        $result2->free();
        // on ajoute la station courante à la liste des stations
        $parkings[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des stations au format json, et on l'affiche
echo json_encode($parkings);

// on ferme la connexion à la base de données
$db->close();

// on termine notre script php
?>

<!-- Voici un exemple de sortie :

[{"id":"1","nb_places":"10","securise":"1","abrite":"1","info_complementaires":"test","type_accroche":["V\u00e9lo classique","V\u00e9lo autre"]}]

on remaque que l'on a bien une liste de stations (ici il y a qu'une seule station dans la liste), 
et que chaque station a un dictionnaire avec toutes les infos statiques à propos de la station,
une des clés de ce dictionnaire est "type_accroche" qui contient une liste des types d'accroches de la station
-->