




var feature_group_arrets_bus = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function afficherHorairesArret(id)
{
    var e;
    DATA_global.forEach(function(arret) {
        if (arret.id == id) {
            e = arret;
        }
    });



    console.log("e : "+e);
    arret_gid = e.id;
    for (var i = 0; i < e.lignes.length; i++) {
        var ligne = e.lignes[i].nomCommercial;
        var destination = e.lignes[i].destination;
        var texte = "Horaires de passage de la ligne " + ligne + " en direction de " + destination + " : <br>";
        for (var j = 0; j < e.lignes[i].liste_id_lignes.length; j++) {
            console.log('./sources/requetes/horaires_api.php?arret_gid='+arret_gid+'&ligne_id='+e.lignes[i].liste_id_lignes[j]);
            fetch('./sources/requetes/horaires.php?arret_gid='+arret_gid+'&ligne_id='+e.lignes[i].liste_id_lignes[j])
                .then(response => response.json())
                .then(data => {
                    data.forEach(function(horaire) {
                        texte += horaire.horaire_apparent + "<br>";
                    }
                )}
            );
        }
    }
    //modfier le popup de l'arret et ajouter texte à la fin var elements = document.getElementsByClassName(names);
    var elements = document.getElementsByClassName("popup_arret");
    for (var i = 0; i < elements.length; i++) {
        elements[i].innerHTML += texte;
    }

}

function afficherPopupArret(e) {
    var nom = "Arret : " + e.libelle;
    var vehicule = "Type : "+ e.vehicule;
    var gid = "GID : "+ e.id;
    var L_lignes = [];
    for (var i = 0; i < e.lignes.length; i++) {
        L_lignes.push(e.lignes[i].nomCommercial + " Direction : " + e.lignes[i].destination);
    }
    var L_lignes = "Lignes : <br> - " + L_lignes.join("<br> - ") ;

    //Dans le popup ajouter un bouton pour afficher les horaires de passage, appeler la fonction afficherHorairesArret(e)
    var bouton = "<button id='"+e.id+"' onclick='afficherHorairesArret("+e.id+")'>Afficher les horaires de passage</button>";

    var popup = "<div class='popup_arret'><h3>"+nom+"</h3><p>"+vehicule+"</p><p>"+gid+"</p><p>"+L_lignes+"</p><p>"+bouton+"</p></div>";
    return popup;
}

var DATA_global;

fetch('./sources/requetes/arrets_api.php')
    .then(response => response.json())
    .then(data => {
        DATA_global = data;
        data.forEach(function(arret) {
            var latitude = parseFloat(arret.latitude);
            var longitude = parseFloat(arret.longitude);
            if (filtreCordonnees(latitude,longitude) == false ||  arret.lignes.length == 0) {
                return;
            }
            if (arret.vehicule == "BUS")
            {
                L.marker([latitude,longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).bindPopup(afficherPopupArret(arret)).addTo(feature_group_arrets_bus);
            }
            else if (arret.vehicule == "TRAM")
            {
                L.marker([latitude,longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(afficherPopupArret(arret)).addTo(feature_group_arrets_bus);
            }
        }
    )}
);


