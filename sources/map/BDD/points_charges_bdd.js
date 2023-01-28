var feature_group_pdc_bdd = L.featureGroup(
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

function updateBddPointsCharges() {
    // suppression des marqueurs existants de la carte
    feature_group_pdc_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pdc_bdd.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('../../sources/requetes/points_de_charges.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(pdc) {
            var marker = L.marker([pdc.latitude, pdc.longitude]).addTo(feature_group_pdc_bdd);
            marker.bindPopup(pdc.nom + "<br> PAYANT : " + pdc.payant + "<br> PRIVE : " + pdc.prive);
        });
        
    })
    .catch(error => console.error(error));
}

//updateBddPointsCharges();