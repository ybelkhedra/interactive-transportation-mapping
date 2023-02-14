var feature_group_vcube = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);




function addPopupvcube(vcube) {
    var popup = '<div class="popup">';
    popup += '<h3> Station Vcube : ' + vcube.properties.libelle + '</h3>';
    //afficher la si la station est active ou pas avec une petite bille de couleur verte ou rouge État de la connexion de la station :  Liste des valeurs possibles :  CONNECTEE : Station connectée DECONNECTEE : Station déconnectée MAINTENANCE : Station en maintenance
    if(vcube.properties.etat == "CONNECTEE") {
        popup += '<p>Etat : <span style="color:green;">Station connectée</span></p>';
    } else if(vcube.properties.etat == "DECONNECTEE") {
        popup += '<p>Etat : <span style="color:red;">Station déconnectée</span></p>';   
    } else if(vcube.properties.etat == "MAINTENANCE") {
        popup += '<p>Etat : <span style="color:orange;">Station en maintenance</span></p>';
    }
    popup += '<p>Nombre de places libres : ' + vcube.properties.nbplaces + '</p>';
    popup += '<p>Nombre total de vélos disponibles : ' + vcube.properties.nbvelos + '</p>';
    popup += '<p>Nombre de vélos électriques disponibles : ' + vcube.properties.nbelec + '</p>';
    popup += '<p>Nombre de vélos classiques disponibles : ' + vcube.properties.nbclassiq + '</p>';
    popup += '</div>';
    return popup;
}

function updatevcube() {
    $.ajax({
        url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=ci_vcub_p',
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
                L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'blue'})}).bindPopup(addPopupvcube(val)).addTo(feature_group_vcube);
            });
        }
    });
}

updatevcube();
//lancer la fonction updatevcube() toutes les 1 minutes
setInterval(updatevcube, 60000);