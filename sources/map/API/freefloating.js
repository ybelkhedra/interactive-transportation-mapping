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


function afficherPopupFreeFloating(e) {
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;
    var vehicules = [];
    for (var i = 0; i < e.vehicules_freefloating.length; i++) {
        vehicules.push(e.vehicules_freefloating[i]);
    }
    var vehicules = "Vehicules autorisés : " + vehicules.join(" - ");
    var popup = nom + "<br>" + infos + "<br>" + vehicules;
    return popup;
}

function updateBddStationsFreeFloating() { //a renommer en updateBddPointsCharges
    // suppression des marqueurs existants de la carte
    feature_group_freefloating.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_freefloating.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/stations_freefloating.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(freefloating) {
            if (freefloating.coordonnees.length == 1)
            {
                var marker = L.marker([freefloating.coordonnees[0].latitude, freefloating.coordonnees[0].longitude]).addTo(feature_group_freefloating);
                marker.bindPopup(afficherPopupFreeFloating(freefloating));
                marker.setStyle({color: 'pink'});

            }
            else if (freefloating.coordonnees.length > 1)
            {
                var latlngs = [];
                freefloating.coordonnees.forEach(function(coordonnee) {
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]);
                }
                );
                var polygon = L.polygon(latlngs).addTo(feature_group_freefloating);
                polygon.setStyle({color: 'blue'});
                polygon.bindPopup(afficherPopupFreeFloating(freefloating));
            }
        });
        
    })
    .catch(error => console.error(error));
}

updateBddStationsFreeFloating();