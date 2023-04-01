var feature_group_parkings = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

var parkingIcon = L.icon({
    iconUrl: './sources/icons/parking.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon
});

function afficherInfosParking() {
    parking = PARKING_GLOBAL_COURANT;
    console.log(parking);
    //recuperer l'elemetn class btn btn-primary
    var btn = document.getElementsByClassName('btn btn-primary');
    var popup = "<div class=popupInfoDetaillee>";
    //ajouter l'adresse, nombre de places pmr np_pmr, type de parking ta_type (Type de tarif : Liste des valeurs possibles :  GRATUIT : Parking gratuit PAYANT_RESERVE_ABONNES : Parking payant réservé aux abonnés PAYANT_TARIF_HORAIRE : Tarif payant horaire PAYANT_TARIF_PARC_RELAIS : Tarif payant Parc-Relais PAYANT_TARIF_VOIRIE : Tarif payant voirie PAYANT_AUTRE_TYPE_DE_TARIF : Payant autre type de tarif), nombre de places velo np_veltot, nombre de place covoiturage np_covoit, date de derniere modification date_maj mdate, nombre de place vehicule electrique np_vle, nombre de place pour velo electrique np_velec, nombre de place autopartage np_mobalt, année de mise en service an_serv
    popup += "<p>Adresse : "+parking.properties.adresse+"</p>";
    popup += "<p>Type de parking : "+parking.properties.ta_type+"</p>";
    popup += "<p>Nombre de places PMR : "+parking.properties.np_pmr+"</p>";
    popup += "<p>Nombre de places vélo : "+parking.properties.np_veltot+"</p>";
    popup += "<p>Nombre de places covoiturage : "+parking.properties.np_covoit+"</p>";
    popup += "<p>Nombre de places véhicule électrique : "+parking.properties.np_vle+"</p>";
    popup += "<p>Nombre de places vélo électrique : "+parking.properties.np_velec+"</p>";
    popup += "<p>Nombre de places autopartage : "+parking.properties.np_mobalt+"</p>";
    popup += "<p>Année de mise en service : "+parking.properties.an_serv+"</p>";
    popup += "<p>Date de dernière modification de la base de donnée : "+parking.properties.mdate+"</p>";
    popup += "</div>";
    //supprimer le bouton class btn btn-primary dans le popup
    
    //ajouter le popup à la suite du popup existant en supprimant le bouton voir les infos détaillées
    btn[0].parentNode.innerHTML += popup;
    btn[0].parentNode.removeChild(btn[0]);
}

var PARKING_GLOBAL_COURANT = null;

function addPopupParkings(parking) {
    PARKING_GLOBAL_COURANT = parking;
    var popup = '<div class="popup">';
    popup += '<h3>' + parking.properties.nom + '</h3>';
    popup += '<p>Exploitant : ' + parking.properties.exploit + '</p>';
    popup += '<p>Places totales : ' + parking.properties.total + '</p>';
    popup += '<p>Places libres : ' + parking.properties.libres + '</p>';
    popup += '<p>Tarifs : <a href="'+parking.properties.url+'" target="_blank">Voir les tarifs</a></p>';
    //ajouter un bouton pour afficher les infos détaillées
    popup += '<button class="btn btn-primary" onclick="afficherInfosParking()">Voir les infos détaillées</button>';
    popup += '</div>';
    return popup;
}

// $.ajax({
//     url: '../../../donnees/json/parking_cord.json',
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
//             //console.log(latitude, longitude);
//             L.marker([latitude, longitude]).addTo(feature_group_parkings);
//         });
//     }
// });

$.ajax({
    url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_park_p',
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
            nb_parkings++;
            L.marker([latitude, longitude], {icon: parkingIcon}).bindPopup(addPopupParkings(val)).addTo(feature_group_parkings);
            affichage();
        });
    }
});