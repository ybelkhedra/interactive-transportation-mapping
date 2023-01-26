var feature_group_traffic= L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

function updateMarkersTraffic() {


    try {
    // récupération des données de position de bus et de tram en utilisant l'URL du WebService GeoJSON
    
    $.ajax({
        url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=ci_trafi_l",
        dataType: "json",
        cache: false,
        success: function(data) {
    
    {
      // suppression des marqueurs existants de la carte
      feature_group_traffic.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_traffic.removeLayer(layer);
        }
      });
      // ajout de ligne de traffic chargé ou fluide
      $.each(data.features, function(key, val) {
        //inversé les coordonnées val.features.geometry.coordinates
        for (var i = 0; i < val.geometry.coordinates.length; i++) {
                val.geometry.coordinates[i].reverse();
        }
        if (val.properties.etat == "FLUIDE") {
            var polyline = L.polyline(val.geometry.coordinates, {color: 'green'}).addTo(feature_group_traffic);
    }
        else {
            var polyline = L.polyline(val.geometry.coordinates, {color: 'red'}).addTo(feature_group_traffic);
        }
        });
    }

        }
    });
    }   
    catch (e) {
        console.log(e);
    }
}

setInterval(updateMarkersTraffic, 30000);