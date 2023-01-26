
var feature_group_bus_temps_reel = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

function updateMarkersVehicule() {

    try {
    // récupération des données de position de bus et de tram en utilisant l'URL du WebService GeoJSON
    
    $.ajax({
        url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_vehic_p",
        dataType: "json",
        cache: false,
        success: function(data) {
    
    {
      // suppression des marqueurs existants de la carte
      feature_group_bus_temps_reel.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_bus_temps_reel.removeLayer(layer);
        }
      });
        var success = 0;
        var error = 0;
      // ajout de nouveaux marqueurs pour chaque élément de données de position de bus et de tram
      $.each(data.features, function(key, val) {
        if (val.properties.localise) {//(val.geometry && val.geometry.coordinates) {
        // création d'un marqueur avec l'icône spécifiée et ajout de la fenêtre contextuelle avec les informations sur le bus ou le tram
            if (val.properties.vehicule == "BUS")
            {
                var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'bus', prefix: 'fa', markerColor: 'red'})}).bindPopup("TYPE : " + val.properties.vehicule + " DESTINATION : " + val.properties.terminus);
            }
            else
            {
                var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'subway', prefix: 'fa', markerColor: 'blue'})}).bindPopup("TYPE : " + val.properties.vehicule + " DESTINATION : " + val.properties.terminus);
            }
                // ajout du marqueur à la carte
            marker.addTo(feature_group_bus_temps_reel);
            success++;
        }
        else {
            error++;
        }
        });
        //console.log("success : " + success + " error : " + error + "données datant du : " + data.features[0].properties.mdate);
    }
        }
    });
    }
    catch (e) {
        console.log(e);
    }
}

setInterval(updateMarkersVehicule, 10000);