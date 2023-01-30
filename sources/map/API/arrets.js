




var feature_group_arrets_bus = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function afficherPopupArret(e) {
    var nom = "Arret : " + e.nom;
    var vehicule = "Type : "+ e.vehicule;
    // var gid = "GID : "+ e.gid;
    var lignes = [];
    for (var i = 0; i < e.ligne.length; i++) {
        lignes.push(e.ligne[i].nom + " Direction : " + e.ligne[i].direction);
    }
    var lignes = "Lignes : " + lignes.join(" - ");
    var popup = nom + "<br>" + vehicule + "<br>" + lignes;
    return popup;
}

// $.ajax({
//     url: '../../../donnees/json/resultats_post_traitement/arretsPost.json',
//     type: 'GET',
//     dataType: 'json',
//     success: function(data) {
//         $.each(data, function(key, val) {
//             // Récupération des valeurs de latitude et longitude
//             var latitude = parseFloat(val.lat);
//             var longitude = parseFloat(val.lon);
//             if (isNaN(latitude) || isNaN(longitude) || (val.vehicule != "BUS" && val.vehicule != "TRAM")) {
//                 return;
//             }
//             // Ajout d'un marker sur la carte
//             if (filtreCordonnees(latitude, longitude) == false ||  val.lignes.length == 0) {
//                 return;
//             }
//             if (val.vehicule == "BUS")
//             {
//                 L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).bindPopup(afficherPopupArret(val)).addTo(feature_group_arrets_bus);
//             }
//             else if (val.vehicule == "TRAM")
//             {
//                 L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(afficherPopupArret(val)).addTo(feature_group_arrets_bus);
//             }
//         });
//     }
// });



$.ajax({
    url: '../../requetes/arrets.php',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        console.log(data);
        $.each(data, function(key, val) {
            console.log(val);
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.latitude);
            var longitude = parseFloat(val.longitude);
            if (isNaN(latitude) || isNaN(longitude) || (val.vehicule != "BUS" && val.vehicule != "TRAM")) {
                return;
            }
            // Ajout d'un marker sur la carte
            if (filtreCordonnees(latitude, longitude) == false ||  val.ligne.length == 0) {
                return;
            }
            if (val.vehicule == "BUS")
            {
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).bindPopup(afficherPopupArret(val)).addTo(feature_group_arrets_bus);
            }
            else if (val.vehicule == "TRAM")
            {
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(afficherPopupArret(val)).addTo(feature_group_arrets_bus);
            }
        });
    }
});

