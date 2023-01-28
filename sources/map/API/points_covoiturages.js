
var feature_group_cf5c634cb92629a9a7265699e3b14613 = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);




$.ajax({
    url: '../../../donnees/json/covoiturage_cord.json',
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
            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'blue'})}).addTo(feature_group_cf5c634cb92629a9a7265699e3b14613);
        });
    }
});