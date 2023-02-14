
var feature_group_cf5c634cb92629a9a7265699e3b14613 = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function afficherInfoscovoit() {
    covoit = covoit_GLOBAL_COURANT;
    //recuperer l'elemetn class btn btn-primary
    var btn = document.getElementsByClassName('btn btn-primary');
    var popup = "<div class=popupInfoDetaillee>";
    popup += '<p>Gestionnaire : ' + covoit.properties.gestionnaire + '</p>';
    popup += "<p>Adresse : "+covoit.properties.adresse+"</p>";
    popup += "<p>Type de lieu : "+covoit.properties.implantation+"</p>";
    popup += "<p>Nombre de places de recharge disponibles : "+covoit.properties.nb_irve+"</p>";
    popup += "<p>Nombre de places PMR : "+covoit.properties.nb_pmr+"</p>";
    popup += "<p>Date de dernière modification de la base de donnée : "+covoit.properties.mdate+"</p>";
    popup += "</div>";
    //supprimer le bouton class btn btn-primary dans le popup
    
    //ajouter le popup à la suite du popup existant en supprimant le bouton voir les infos détaillées
    btn[0].parentNode.innerHTML += popup;
    btn[0].parentNode.removeChild(btn[0]);
}

var covoit_GLOBAL_COURANT = null;

function addPopupcovoit(covoit) {
    covoit_GLOBAL_COURANT = covoit;
    var popup = '<div class="popup">';
    popup += '<h3> Point de covoiturage : ' + covoit.properties.libelle + '</h3>';
    popup += '<p>Places totales : ' + covoit.properties.nb_place + '</p>';
    //afficher la si la station est active ou pas avec une petite bille de couleur verte ou rouge
    if(covoit.properties.actif) {
        popup += '<p>Etat : <span style="color:green;">Station active</span></p>';
    } else {
        popup += '<p>Etat : <span style="color:red;">Station inactive ou état inconnu</span></p>';
    }
    popup += '<button class="btn btn-primary" onclick="afficherInfoscovoit()">Voir les infos détaillées</button>';
    popup += '</div>';
    return popup;
}


// $.ajax({
//     url: '../../../donnees/json/covoiturage_cord.json',
//     type: 'GET',
//     dataType: 'json',
//     success: function(data) {
//         $.each(data, function(key, val) {
//             // Récupération des valeurs de latitude et longitude
//             var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
//             var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
//             if (isNaN(latitude) || isNaN(longitude) || !filtreCordonnees(latitude, longitude)) {
//                 return;
//             }
//             // Ajout d'un marker sur la carte
//             L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'blue'})}).addTo(feature_group_cf5c634cb92629a9a7265699e3b14613);
//         });
//     }
// });

$.ajax({
    url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_covoiturage_p',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.each(data.features, function(key, val) {
            // Récupération des valeurs de latitude et longitude
            var latitude = parseFloat(val.geometry.coordinates[1]);
            var longitude = parseFloat(val.geometry.coordinates[0]);
            if (isNaN(latitude) || isNaN(longitude) || !filtreCordonnees(latitude, longitude)) {
                return;
            }
            // Ajout d'un marker sur la carte
            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'blue'})}).bindPopup(addPopupcovoit(val)).addTo(feature_group_cf5c634cb92629a9a7265699e3b14613);
        });
    }
});