var feature_group_3c3d8f447cafac6c7a871b7a2bc74795 = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


$.ajax({
    url: '../../../donnees/json/autopartage_cord.json',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.each(data, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
            var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
            if (isNaN(latitude) || isNaN(longitude) || !filtreCordonnees(latitude, longitude)) {
                return;
            }
            // Ajout d'un marker sur la carte
            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'orange'})}).addTo(feature_group_3c3d8f447cafac6c7a871b7a2bc74795);
        });
    }
});