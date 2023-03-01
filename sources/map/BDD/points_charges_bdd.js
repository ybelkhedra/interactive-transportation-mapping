// var feature_group_pdc = L.featureGroup(
//     {}
// ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);
// DEJA DEFINI DANS API/points_charges.js

// PARTIE DE CODE A MODIFIER ==>


function afficherPopupPointsDeCharges(e) { 
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;
    // CECI EST A MOFIER POUR AFFICHER LES INFORMATIONS DES POINTS DE CHARGES

    // EXEMPLE : PUISSANCE DES PRISES, TYPE DE PRISE, ETC...

    // var vehicules_autorises = [];
    // for (var i = 0; i < e.vehicules.length; i++) {
    //     vehicules.push(e.vehicules[i]);
    // }
    // var vehicules = "Vehicules autorisés : " + vehicules.join(" - ");
    // var popup = nom + "<br>" + infos + "<br>" + vehicules;
    return popup;
}

function updateBddStationsPointsDeCharges() { //a renommer en updateBddPointsCharges
    // suppression des marqueurs existants de la carte
    feature_group_pdc.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pdc.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/points_de_charges.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(pointsDeCharge) {//pour chaque point de charge
            if (pointsDeCharge.coordonnees.length == 1) // si le point de charge n'a qu'une seule coordonnée
            { // on ajoute un marker
                var marker = L.marker([pointsDeCharge.coordonnees[0].latitude, pointsDeCharge.coordonnees[0].longitude], {icon : pdcIcon}).addTo(feature_group_pdc);
                marker.bindPopup(afficherPopupPointsDeCharge(pointsDeCharge)); // on ajoute une popup
                marker.setStyle({color: 'grey'}); // on definie la couleur du marker
            }
            else if (pointsDeCharge.coordonnees.length > 1) // si le point de charge a plusieurs coordonnées
            {
                var latlngs = []; // on crée un tableau de coordonnées
                pointsDeCharge.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]); // on ajoute la coordonnée au tableau
                }
                );
                var polygon = L.polygon(latlngs).addTo(feature_group_pdc); // on ajoute un polygone sur la carte avec les coordonnées du tableau
                polygon.setStyle({color: 'grey'}); // on definie la couleur du polygone
                polygon.bindPopup(afficherPopupPointsDeCharge(pointsDeCharge)); // on ajoute une popup
            }
        });
        
    })
    .catch(error => console.error(error));
}

// updateBddStationsPointsDeCharges();