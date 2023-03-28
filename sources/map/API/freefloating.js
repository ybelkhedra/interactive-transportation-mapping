var feature_group_freefloating = L.featureGroup(
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

var freefloatingIcon = L.icon({
    iconUrl: './sources/icons/freefloating.png',

    iconSize:     [17, 17], // size of the icon
});

function afficherPopupFreeFloatingAPI(e) {
    var vehicules_autorises = "";
    if (e.properties.typologie == "VT") {
        vehicules_autorises = "Vélo Trottinette";
    }
    else if (e.properties.typologie == "VTS") {
        vehicules_autorises = "Vélo Trottinette Scooter";
    }
    var popup = "Vehicle autorisé : " + vehicules_autorises;
    return popup;
}

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
            L.marker([latitude, longitude], {icon: freefloatingIcon}).bindPopup(afficherPopupFreeFloatingAPI(val)).addTo(feature_group_freefloating);
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
        data.forEach(function(freefloat) {
            console.log(freefloat.coordonnees[0].latitude)
             // pour chaque freefloat
            // if (freefloat.coordonnees.length == 1) {// si le freefloat n'a qu'une seule coordonnée
            // var marker = L.marker([freefloat.coordonnees[0].latitude, freefloat.coordonnees[0].longitude]).addTo(feature_group_freefloating); // création du marqueur
            // marker.bindPopup(afficherPopupFreeFloating(freefloat)); // ajout du popup
            // marker.setStyle({color: 'yellow'}); // on definie la couleur du marker
            // }
            // else if (freefloat.coordonnees.length > 1) { // si le freefloat a plusieurs coordonnées
            //     var latlngs = []; // création d'un tableau vide 
            //     freefloat.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
            //         latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
            //     }
            //     );
            //     var polygon = L.polygon(latlngs).addTo(feature_group_freefloating); // création du polygone
            //     polygon.setStyle({color: 'yellow'}); // changement de la couleur du polygone
            //     polygon.bindPopup(afficherPopupFreeFloating(freefloat)); // ajout du popup
            // }
            
            var marker = L.marker([freefloat.coordonnees[0].latitude, freefloat.coordonnees[0].longitude]).addTo(feature_group_freefloating); // création du marqueur
            marker.bindPopup(afficherPopupFreeFloating(freefloat)); // ajout du popup
            //marker.setStyle({color: 'yellow'}); // on definie la couleur du marker

        });
        
    })
    .catch(error => console.error(error));
}

updateBddStationsFreeFloating();