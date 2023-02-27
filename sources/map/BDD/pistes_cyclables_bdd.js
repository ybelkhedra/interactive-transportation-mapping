var feature_group_pistes_cyclables_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);
 // ajout du groupe de marqueurs à la carte

function afficherPopupPistesCyclables(piste_cyclable)
{
    var type_piste = "Type piste : " + piste_cyclable.type_piste;
    var info_complementaires = "Informations complémentaires : " + piste_cyclable.info_complementaires;
    
    var popup = type_piste + "<br>" + info_complementaires;
    return popup;
}


function updateBddPisteCyclables(){
    // suppression des marqueurs existants de la carte
    feature_group_pistes_cyclables_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pistes_cyclables_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/pistes_cyclables.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(piste_cyclable) { // pour chaque piste cyclable
            if (piste_cyclable.coordonnees.length == 1) {// si le piste cyclable n'a qu'une seule coordonnée
            var marker = L.marker([piste_cyclable.coordonnees[0].latitude, piste_cyclable.coordonnees[0].longitude]).addTo(feature_group_pistes_cyclables_bdd); // création du marqueur
            marker.bindPopup(afficherPopupPistesCyclables(piste_cyclable)); // ajout du popup
            marker.setStyle({color: 'red'}); // on definie la couleur du marker
            }
            // else if (piste_cyclable.coordonnees.length > 1) { // si le piste cyclable a plusieurs coordonnées
            //     var latlngs = []; // création d'un tableau vide 
            //     piste_cyclable.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
            //         latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
            //     }
            //     );
            //     var polygon = L.polygon(latlngs).addTo(feature_group_pistes_cyclables_bdd); // création du polygone
            //     polygon.setStyle({color: 'red'}); // changement de la couleur du polygone
            //     polygon.bindPopup(afficherPopupPistesCyclables(piste_cyclable)); // ajout du popup
            // }
            // La piste cyclable est une ligne et pas un polygone
        });
        
    })
    .catch(error => console.error(error)); 
}

// updateBddPisteCyclables(); // affichage des pistes cyclables de la bdd