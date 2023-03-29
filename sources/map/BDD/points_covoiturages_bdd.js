

var covoiturageIcon = L.icon({
    iconUrl: './sources/icons/covoiturage.png',

    iconSize:     [17, 17], // size of the icon
});

function afficherPopupPointsDeCovoit(e) { 
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;

    var places = "Places totales : " + e.nombre_de_places;
  
    var popup = nom +  "<br>" + places + "<br>" + infos ;
    return popup;
}

function updateBddCovoiturage() { 
    // suppression des marqueurs existants de la carte
    feature_group_covoiturages.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_covoiturages.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/points_de_covoiturage.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(pdcovoit) { // pour chaque pdcovoit
    
            var marker = L.marker([pdcovoit.latitude, pdcovoit.longitude],  {icon : covoiturageIcon}).addTo(feature_group_covoiturages); // création du marqueur
            marker.bindPopup(afficherPopupPointsDeCovoit(pdcovoit)); // ajout du popup

        });
        
    })
    .catch(error => console.error(error));
}

updateBddCovoiturage();