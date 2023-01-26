var feature_group_9eca2e6aae733fb41e9c12f6a296531b = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);




$.ajax({
    url: '../../../donnees/json/parking_cord.json',
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
            //console.log(latitude, longitude);
            L.marker([latitude, longitude]).addTo(feature_group_9eca2e6aae733fb41e9c12f6a296531b);
        });
    }
});