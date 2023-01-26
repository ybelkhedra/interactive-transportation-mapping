var feature_group_arrets_bus = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


$.ajax({
    url: '../../../donnees/json/arrets_bus.json',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.each(data, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
            var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
            if (isNaN(latitude) || isNaN(longitude)) {
                return;
            }
            // Ajout d'un marker sur la carte
            if (val.fields.vehicule == "BUS")
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).addTo(feature_group_arrets_bus);
            else if (val.fields.vehicule == "TRAM")
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).addTo(feature_group_arrets_bus);
        });
    }
});