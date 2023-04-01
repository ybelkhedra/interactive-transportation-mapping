// var feature_group_pdc = L.featureGroup(
//     {}
// ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);
// DEJA DEFINI DANS API/points_charges.js

// PARTIE DE CODE A MODIFIER ==>
var pdcIcon = L.icon({
    iconUrl: './sources/icons/pdc.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon
});


function afficherPopupPointsDeCharges(e) { 
    var nom = "Nom : " + e.nom;
    var infos = "Informations : "+ e.info_complementaires;

    var prises = []
    for (var i = 0; i < e.type_prise.length; i++) {
        prises.push("Type : " + e.type_prise[i] + " -- Puissance : " + e.puissance[i] + " kW <br>");
    }
  
    var popup = nom + "<br>" + infos + "<br>" + prises;
    return popup;
}

function updateBddStationsPointsDeCharges() { //a renommer en updateBddPointsCharges
    // suppression des marqueurs existants de la carte
    feature_group_pdc.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pdc.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/points_de_charges.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(pdc) { // pour chaque pdc
            pt_electriques++;
            var marker = L.marker([pdc.latitude, pdc.longitude],  {icon : pdcIcon}).addTo(feature_group_pdc); // création du marqueur
            marker.bindPopup(afficherPopupPointsDeCharges(pdc)); // ajout du popup
            //marker.setStyle({color: 'yellow'}); // on definie la couleur du marker
            affichage();
        });
        
    })
    .catch(error => console.error(error));
}

updateBddStationsPointsDeCharges();