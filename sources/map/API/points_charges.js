var feature_group_ea73ace9e1ad1740a59b9950b5af676b = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

   

$.ajax({
    url: '../../../donnees/json/point_de_charge_cord.json',
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
            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'green'})}).addTo(feature_group_ea73ace9e1ad1740a59b9950b5af676b);
        });
    }
});