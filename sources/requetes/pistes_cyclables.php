<!-- 
    On fait la liste des pistes_cyclables, avec pour chacun toutes ses informations statiques mais aussi : 
- la position GPS sous forme de liste de points qui lui sont associés
- le type de piste (pas besoin de liste car c'est unique)
-->

<?php
$db = new mysqli("localhost", "root", "@Password0", "campus");

// On execute notre requete SQL
if ($result = $db->query("
SELECT pistes_velo.id, nom, pistes_velo.info_complementaires, latitude, longitude 
FROM pistes_velo
INNER JOIN situer_pistes_velo
    ON pistes_velo.id = situer_pistes_velo.piste_velo
INNER JOIN coordonnees_pistes_velo
    ON situer_pistes_velo.coordonnee = coordonnees_pistes_velo.id
INNER JOIN types_pistes_velo
    ON types_pistes_velo.id = pistes_velo.type_piste
;
")) {
    while ($row = $result->fetch_assoc()) {
        $pistes_velo[] = $row;
    }
    // on libere la memoire
    $result->free();
}
// on encode la liste des pistes au format json, et on l'affiche
echo json_encode($pistes_velo);

$db->close();

?>