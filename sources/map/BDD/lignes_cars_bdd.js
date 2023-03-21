var feature_group_lignes_car_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
) // ajout du groupe de marqueurs à la carte

function afficherPopupLignes(ligne)
{
    var id = "Identifiant : " + ligne.id;
    var destination = "Destination : " + ligne.destination;
    var depart = "Depart : " + ligne.depart;
    var car_express = "Car Express:" + ligne.car_express;
    var info_complementaires = "Informations complémentaires : " + ligne.info_complementaires;
    var popup = id + "<br>" + destination + "<br>" + depart + "<br>" + car_express + "<br>" + info_complementaires;
    return popup;
}



function updateBddLignesCar(){
    // suppression des marqueurs existants de la carte
    feature_group_lignes_car_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_lignes_car_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/lignes_cars.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(ligne) { // pour chaque ligne
            console.log(ligne);
            if (ligne.coordonnees.length == 1) {// si le ligne n'a qu'une seule coordonnée
            var marker = L.marker([ligne.coordonnees[0].latitude, ligne.coordonnees[0].longitude]).addTo(feature_group_lignes_car_bdd); // création du marqueur
            marker.bindPopup(afficherPopupLignes(ligne)); // ajout du popup
            }
            else if (ligne.coordonnees.length > 1) { // si le ligne a plusieurs coordonnées
                var latlngs = []; // création d'un tableau vide 
                ligne.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                });
                var polyline = L.polyline(latlngs).addTo(feature_group_lignes_car_bdd); // création de la polyline
                polyline.setStyle({color: 'yellow',weight:5}); // changement de la couleur de la polyline
                polyline.bindPopup(afficherPopupLignes(ligne)); // ajout du popup
            }
        });
        
    })
    .catch(error => console.error(error)); 
}
updateBddLignesCar(); 