var feature_group_autopartages = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


var autopartage_Icon = L.icon({
    iconUrl: './sources/icons/autopartage.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon
});



function afficherInfosautoPartage() {
    autoPartage = autoPartage_GLOBAL_COURANT;
    //recuperer l'elemetn class btn btn-primary
    var btn = document.getElementsByClassName('btn btn-primary');
    var popup = "<div class=popupInfoDetaillee>";
    popup += '<p>Gestionnaire : ' + autoPartage.properties.gestionnaire + '</p>';
    popup += "<p>Nombre de places de recharge disponibles : "+autoPartage.properties.nb_irve+"</p>";
    popup += "<p>Nombre de places PMR : "+autoPartage.properties.nb_pmr+"</p>";
    popup += "<p>Date de dernière modification de la base de donnée : "+autoPartage.properties.mdate+"</p>";
    popup += "</div>";
    //supprimer le bouton class btn btn-primary dans le popup
    
    //ajouter le popup à la suite du popup existant en supprimant le bouton voir les infos détaillées
    btn[0].parentNode.innerHTML += popup;
    btn[0].parentNode.removeChild(btn[0]);
}

var autoPartage_GLOBAL_COURANT = null;

function addPopupautoPartage(autoPartage) {
    autoPartage_GLOBAL_COURANT = autoPartage;
    var popup = '<div class="popup">';
    popup += '<h3>' + autoPartage.properties.libelle + '</h3>';
    popup += '<p>Places totales : ' + autoPartage.properties.nb_place + '</p>';
    //afficher la si la station est active ou pas avec une petite bille de couleur verte ou rouge
    if(autoPartage.properties.actif) {
        popup += '<p>Etat : <span style="color:green;">Station active</span></p>';
    } else {
        popup += '<p>Etat : <span style="color:red;">Station inactive ou état inconnu</span></p>';
    }
    popup += '<button class="btn btn-primary" onclick="afficherInfosautoPartage()">Voir les infos détaillées</button>';
    popup += "<button id='autopartage' onclick='afficherIsochronePieton("+autoPartage.geometry.coordinates[1]+","+autoPartage.geometry.coordinates[0]+")'>Afficher l'isochrone pieton</button>";
    popup += "<button id='autopartage' onclick='afficherIsochroneVelo("+autoPartage.geometry.coordinates[1]+","+autoPartage.geometry.coordinates[0]+")'>Afficher l'isochrone velo</button>";
    popup += '</div>';
    return popup;
}



// $.ajax({
//     url: '../../../donnees/json/autopartage_cord.json',
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
//             L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'orange'})}).addTo(feature_group_autopartages);
//         });
//     }
// });


$.ajax({
        url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_autopartage_p',
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
                pt_autopartage++;
                L.marker([latitude, longitude], {icon: autopartage_Icon}).bindPopup(addPopupautoPartage(val)).addTo(feature_group_autopartages);
                affichage();
            });
        checkSumInitialLoaging++;

        }
    });