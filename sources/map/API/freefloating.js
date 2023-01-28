var feature_group_freefloating = L.featureGroup(
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);



try {
    // récupération des données de position de bus et de tram en utilisant l'URL du WebService GeoJSON
    
    $.ajax({
        url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_freefloating_p",
        dataType: "json",
        cache: false,
        success: function(data) 
        {
            {
                // suppression des marqueurs existants de la carte
                feature_group_freefloating.eachLayer(function (layer) {
                if (layer instanceof L.Marker) {
                    feature_group_freefloating.removeLayer(layer);
                }
            });
            // ajout de ligne de traffic chargé ou fluide
            $.each(data.features, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.geometry.coordinates[1]);
            var longitude = parseFloat(val.geometry.coordinates[0]);
            if (isNaN(latitude) || isNaN(longitude) || !filtreCordonnees(latitude, longitude)) {
                return;
            }
            // Ajout d'un marker sur la carte
            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'pink'})}).addTo(feature_group_freefloating);
            });
        }
    }
    });
}   
catch (e) {
    console.log(e);
}