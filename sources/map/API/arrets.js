




var feature_group_arrets_bus = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function afficherPopupArret(e) {
    var nom = "Arret : " + e.nom;
    var vehicule = "Type : "+ e.vehicule;
    var gid = "GID : "+ e.gid;
    var lignes = [];
    var eviter_duplication = [];
    for (var i = 0; i < e.lignes.length; i++) {
        if (e.lignes[i].courses_associees[0].aller.length > 0) {
            for (var j = 0; j < e.lignes[i].courses_associees[0].aller.length; j++) {
                if (eviter_duplication.indexOf(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[0].aller[j].arret_arrivee) == -1) {
                    lignes.push(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[0].aller[j].arret_arrivee + "<br>");
                    eviter_duplication.push(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[0].aller[j].arret_arrivee)
                }
            }
        }
        if (e.lignes[i].courses_associees[1].retour.length > 0) {
            for (var j = 0; j < e.lignes[i].courses_associees[1].retour.length; j++) {
                if (eviter_duplication.indexOf(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[1].retour[j].arret_arrivee) == -1) {
                    lignes.push(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[1].retour[j].arret_arrivee+ "<br>");
                    eviter_duplication.push(e.lignes[i].nom + " Direction : " + e.lignes[i].courses_associees[1].retour[j].arret_arrivee)    
                }
           }
        }
    }
    var lignes = "Lignes : " + lignes.join(", ");
    return nom + "<br>" + vehicule + "<br>" + gid + "<br>" + lignes;
}

$.ajax({
    url: '../../../donnees/json/resultats_post_traitement/arretsPost.json',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.each(data, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.lat);
            var longitude = parseFloat(val.lon);
            if (isNaN(latitude) || isNaN(longitude) || (val.vehicule != "BUS" && val.vehicule != "TRAM")) {
                return;
            }
            // Ajout d'un marker sur la carte
            if (filtreCordonnees(latitude, longitude) == false ||  val.lignes.length == 0) {
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

