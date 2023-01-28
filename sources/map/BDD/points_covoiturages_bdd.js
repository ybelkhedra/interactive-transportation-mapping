var feature_group_covoiturage_bdd = L.featureGroup(
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function updateBddCovoiturage() {
    // suppression des marqueurs existants de la carte
    feature_group_covoiturage_bdd.eachLayer(function (layer) {
    if (layer instanceof L.Marker) {
        feature_group_covoiturage_bdd.removeLayer(layer);
    }
    });

    //récupération des données de la bdd
    fetch('../../sources/requetes/points_de_covoiturages.php')
    .then(response => response.json())
    .then(data => {
    data.forEach(function(covoiturage) {
            var marker = L.marker([covoiturage.latitude, covoiturage.longitude]).addTo(feature_group_covoiturage_bdd);
            marker.bindPopup(covoiturage.nom + "<br> Informations complémentaires : " + covoiturage.informations_complementaires);
    });

    })
    .catch(error => console.error(error));
}

//updateBddCovoiturage();