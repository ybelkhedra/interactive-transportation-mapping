var feature_group_parkings_bdd = L.featureGroup(
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

function updateBddParkings(){
    // suppression des marqueurs existants de la carte
    feature_group_parkings_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_parkings_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/parkings.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(parking) {
            if (parking.coordonnees.length == 1) {
            var marker = L.marker([parking.coordonnees[0].latitude, parking.coordonnees[0].longitude]).addTo(feature_group_parkings_bdd);
            marker.bindPopup(parking.nom + "<br>" + parking.nb_places_max + " places aux maximum <br>"+ parking.nb_places_handicapes+" places handicapes <br>" + parking.informations_complementaires + "<br> PAYANT : " + parking.payant + "<br> HORS VOIRIE : " + parking.hors_voirie + "<br> PRIVE : " + parking.prive);
            }
            else if (parking.coordonnees.length > 1) {
                var latlngs = [];
                parking.coordonnees.forEach(function(coordonnee) {
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]);
                }
                );
                var polygon = L.polygon(latlngs).addTo(feature_group_parkings_bdd);
                polygon.setStyle({color: 'blue'});
                polygon.bindPopup(parking.nom + "<br>" + parking.nb_places_max + " places aux maximum <br>"+ parking.nb_places_handicapes+" places handicapes <br>" + parking.informations_complementaires + "<br> PAYANT : " + parking.payant + "<br> HORS VOIRIE : " + parking.hors_voirie + "<br> PRIVE : " + parking.prive);
            }
        });
        
    })
    .catch(error => console.error(error));
}

updateBddParkings();