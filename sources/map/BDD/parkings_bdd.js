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
    fetch('../../requetes/parkings.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(parking) {
            var marker = L.marker([parking.latitude, parking.longitude]).addTo(feature_group_parkings_bdd);
            marker.bindPopup(parking.nom + "<br>" + parking.nb_places + " places disponibles <br>" + parking.informations_complementaires + "<br> PAYANT : " + parking.payant + "<br> HANDICAPE : " + parking.handicape+ "<br> HORS VOIRIE : " + parking.hors_voirie);
        });
        
    })
    .catch(error => console.error(error));
}

updateBddParkings();