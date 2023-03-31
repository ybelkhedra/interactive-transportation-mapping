
function afficherPopupArretsTram(e) { 
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;

    var station_vcub = "Station VCub à proximité: " + e.station_vcube_proximite;
  
    var popup = nom +  "<br>" + station_vcub + "<br>" + infos ;
    return popup;
}

function updateBddArretsTram() { 
    // suppression des marqueurs existants de la carte
    feature_group_arrets_tram.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_arrets_tram.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/arrets_perso.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(arret) { // pour chaque arret
    
            if (arret.vehicule == "Tramway") {
                var marker = L.marker([arret.latitude, arret.longitude], {icon : tram_station_Icon}).addTo(feature_group_arrets_tram); // création du marqueur
                marker.bindPopup(afficherPopupArretsTram(arret)); // ajout du popup
            }
        });
        
    })
    .catch(error => console.error(error));
}

updateBddArretsTram();