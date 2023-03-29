var feature_group_freefloating_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte

var freefloatingIcon = L.icon({
    iconUrl: './sources/icons/freefloating.png',

    iconSize:     [17, 17], // size of the icon
});

function afficherPopupFreeFloating(e) {
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;
    var vehicules = [];
    for (var i = 0; i < e.vehicules_freefloating.length; i++) {
        vehicules.push(e.vehicules_freefloating[i]);
    }
    var vehicules_autorises = "Vehicules autorisés : " + vehicules.join(" - ");
    var popup = nom + "<br>" + infos + "<br>" + vehicules_autorises;
    return popup;
}

function updateBddStationsFreeFloating() { //a renommer en updateBddPointsCharges
    // suppression des marqueurs existants de la carte
    feature_group_freefloating_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_freefloating_bdd.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/stations_freefloating.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(freefloat) {
            console.log(freefloat.coordonnees[0].latitude)
 
            
            var marker = L.marker([freefloat.coordonnees[0].latitude, freefloat.coordonnees[0].longitude], {icon: freefloatingIcon}).addTo(feature_group_freefloating_bdd); // création du marqueur
            marker.bindPopup(afficherPopupFreeFloating(freefloat)); // ajout du popup
            //marker.setStyle({color: 'yellow'}); // on definie la couleur du marker

        });
        
    })
    .catch(error => console.error(error));
}

updateBddStationsFreeFloating();