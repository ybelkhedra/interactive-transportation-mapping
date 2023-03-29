

//var covoiturageIcon = L.icon({
//    iconUrl: './sources/icons/covoiturage.png',
//
//    iconSize:     [17, 17], // size of the icon
//});

function afficherPopupVcub(e) { 
    var nom = "Nom : " + e.nom;

    var places_max = "Capacité : " + e.nb_velos_max;

    var velos_dispo = "Vélos disponibles : " + e.nb_velos_dispo;

    var vcub_plus = "Vcub+ disponibles : " + e.vcube_plus;

    var velos_elec = "Vélos électriques disponibles : " + e.velos_electriques;

    var arrets_proches = "Arrêts à proximité : ";
    for(var i=0; i < e.arrets_proximite.length; i++) {
        if (i > 0) {
            arrets_proches = arrets_proches + " - ";
        }
        arrets_proches = arrets_proches + e.arrets_proximite[i].nom;
        
    }

    var infos = "Informations : "+ e.info_complementaires;

  
    var popup = nom +  "<br>" + places_max + "<br>" 
                              + velos_dispo + "<br>" 
                              + vcub_plus + "<br>" 
                              + velos_elec + "<br>" 
                              + arrets_proches + "<br>" 
                              + infos ;
    return popup;
}

function updateBddVcub() { 
    // suppression des marqueurs existants de la carte
    feature_group_vcube.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_vcube.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/stations_vcube.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(station) { // pour chaque station
            console.log("une station vcub");
            var marker = L.marker([station.latitude, station.longitude]).addTo(feature_group_vcube); // création du marqueur
            marker.bindPopup(afficherPopupVcub(station)); // ajout du popup

        });
        
    })
    .catch(error => console.error(error));
}

updateBddVcub();