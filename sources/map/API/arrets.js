




var feature_group_arrets_bus = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


$.ajax({
    url: '../../../donnees/json/resultats_post_traitement/arrets.json',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.each(data, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.lat);
            var longitude = parseFloat(val.lon);
            if (isNaN(latitude) || isNaN(longitude) || (val.vehicule != "BUS" && val.vehicule != "TRAM")) {
                return;
            }
            // Ajout d'un marker sur la carte
            if (filtreCordonnees(latitude, longitude) == false) {
                return;
            }
            if (val.vehicule == "BUS")
            {
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).bindPopup(val.nom + "<br>" +val.lignes).addTo(feature_group_arrets_bus);
            }
            else if (val.vehicule == "TRAM")
            {
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(val.nom + "<br>" +val.lignes).addTo(feature_group_arrets_bus);
            }
        });
    }
});

