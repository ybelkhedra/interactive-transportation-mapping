




var feature_group_arrets_bus = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

var feature_group_arrets_tram = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


var bus_station_Icon = L.icon({
    iconUrl: './sources/icons/bus_station.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon
});

var tram_station_Icon = L.icon({
    iconUrl: './sources/icons/tram_station.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon

});


function difference_entre_deux_horaires(horaire1, horaire2)
{
    // horaire1 et horaire2 sont des strings de la forme "2023-04-05T11:00:00"
    // renvoie la difference en minutes entre les deux horaires
    var date1 = new Date(horaire1);
    var date2 = new Date(horaire2);
    var diff = Math.abs(date1 - date2);
    return Math.ceil(diff / (1000 * 60));
}



function afficherHorairesArret(id)
{
    var ident = "";
    fetch('./sources/requetes/convert_id_ident_arret.php?gid='+id)
        .then(response => response.json())
        .then(data => {
            ident = data;
            console.log("ident : "+ident);

        console.log("ident2 : "+ident);
        texte = "<h3>Prochains passages</h3>";
        url_prochains_passages = "https://data.bordeaux-metropole.fr/geojson/process/saeiv_arret_passages?key=177BEEMTWZ&datainputs={%22arret_id%22:\""+ident+"\"}&attributes=[%22libelle%22,%22hor_app%22,%22hor_estime%22,%22terminus%22,%22vehicule%22]"
        console.log("url_prochains_passages : "+url_prochains_passages);
        $.ajax({
            url: url_prochains_passages,
            dataType: "json",
            cache: false,
            success: function(data) {

                // type de retour : {"type":"FeatureCollection","features":[{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:00:00","hor_estime":"2023-04-05T11:00:00","terminus":"Beausoleil","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:02:00","hor_estime":"2023-04-05T11:03:26","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:11:00","hor_estime":"2023-04-05T11:11:00","terminus":"Beausoleil","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:12:00","hor_estime":"2023-04-05T11:14:40","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:22:00","hor_estime":"2023-04-05T11:21:28","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:22:00","hor_estime":"2023-04-05T11:22:00","terminus":"Beausoleil","vehicule":"BUS"}}]}
                //horaire_actuel et horaire_hor_estime sont des strings de la forme "2023-04-05T11:00:00"
                
                //recuperer l'horaire actuel fuseau de paris
                var horaire_actuel = new Date().toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                var horaire_hor_estime = new Date(data.features[0].properties.hor_estime);
                console.log("horaire_actuel : "+horaire_actuel);
                console.log("horaire_hor_estime : "+horaire_hor_estime);
                var diff = difference_entre_deux_horaires(horaire_actuel, horaire_hor_estime);

                texte += "<table>";
                for (var i = 0; i < data.features.length; i++) {
                    texte += "<tr><td>"+data.features[i].properties.libelle+"</td><td>"+data.features[i].properties.hor_estime+"</td><td> Estimé dans : "+diff+" Min</td><td>"+data.features[i].properties.terminus+"</td><td>"+data.features[i].properties.vehicule+"</td></tr>";
                }

            }
        });





        //modfier le popup de l'arret et ajouter texte à la fin var elements = document.getElementsByClassName(names);
        var elements = document.getElementsByClassName("popup_arret");
        for (var i = 0; i < elements.length; i++) {
            elements[i].innerHTML += texte;
        }
    }
    );

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
                nb_arrets_bus++;
                L.marker([latitude,longitude],{icon: bus_station_Icon}, {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).bindPopup(afficherPopupArret(arret)).addTo(feature_group_arrets_bus);
            }
            else if (arret.vehicule == "TRAM")
            {
                nb_arrets_tram++;
                L.marker([latitude,longitude],{icon: tram_station_Icon}, {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(afficherPopupArret(arret)).addTo(feature_group_arrets_tram);
            }
            affichage()
        }
    )}
);


