




var feature_group_arrets_bus = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

var feature_group_arrets_tram = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


var bus_station_Icon = L.icon({
    iconUrl: './sources/icons/bus_station.png',
    iconSize:     [taille_icon, taille_icon],
    iconAnchor: [taille_icon/2, taille_icon],
    popupAnchor: [0, -taille_icon/2],
});

var tram_station_Icon = L.icon({
    iconUrl: './sources/icons/tram_station.png',
    iconSize:     [taille_icon, taille_icon], 
    iconAnchor: [taille_icon/2, taille_icon],
    popupAnchor: [0, -taille_icon/2],
});


function difference_entre_deux_horaires(horaire1, horaire2)
{
    // horaire1 et horaire2 sont des strings de la forme "13:30:56"
    // renvoie la difference en minutes entre les deux horaires
    var horaire1_split = horaire1.split(":");
    var horaire2_split = horaire2.split(":");
    var date1 = new Date(0, 0, 0, horaire1_split[0], horaire1_split[1], horaire1_split[2]);
    var date2 = new Date(0, 0, 0, horaire2_split[0], horaire2_split[1], horaire2_split[2]);
    var diff = date2 - date1;
    var diff_minutes = Math.round(((diff % 86400000) % 3600000) / 60000);
    return diff_minutes;
}

function couleur_bulle_prochain_passage(diff)
{
    // diff est un entier qui represente le nombre de minutes avant le prochain passage
    // renvoie la couleur de la bulle du prochain passage
    if (diff < 5)
    {
        return "green";
    }
    else if (diff < 10)
    {
        return "orange";
    }
    else if (diff < 15)
    {
        return "red";
    }
    else
    {
        return "grey";
    }
}



function global_bulle_couleur(id)
{
    var ident = "";
    var couleur1 = fetch('./sources/requetes/convert_id_ident_arret.php?gid='+id)
        .then(response => response.json())
        .then(data => {
            ident = data;
        url_prochains_passages = "https://data.bordeaux-metropole.fr/geojson/process/saeiv_arret_passages?key=177BEEMTWZ&datainputs={%22arret_id%22:\""+ident+"\"}&attributes=[%22libelle%22,%22hor_app%22,%22hor_estime%22,%22terminus%22,%22vehicule%22]"
        var couleur2 = $.ajax({
            url: url_prochains_passages,
            dataType: "json",
            cache: false,
            success: function(data) {
                var horaire_actuel;
                var horaire_hor_estime;
                var diff;
                var diff_prochain_passage;
                //recuperer l'horaire actuel fuseau de paris
                horaire_actuel = new Date().toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                // convertire horaire actuel de  05/04/2023 13:22:38 à 13:22:38
                horaire_actuel = horaire_actuel.split(" ")[1];
                try {
                    horaire_hor_estime = new Date(data.features[0].properties.hor_estime);
                                    // convertire horaire horaire_hor_estime de  horaire_hor_estime : Wed Apr 05 2023 13:36:26 GMT+0200 (heure d’été d’Europe centrale) à 13:36:26
                    horaire_hor_estime = horaire_hor_estime.toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                    horaire_hor_estime = horaire_hor_estime.split(" ")[1];
                    diff = difference_entre_deux_horaires(horaire_actuel, horaire_hor_estime);
                    diff_prochain_passage = diff;
                }
                catch (e) {
                    diff_prochain_passage = "pas de passage";
                }
                return couleur_bulle_prochain_passage(diff_prochain_passage);
            }
        });
        return couleur2;
    }
    );
    return couleur1;
}



function afficherHorairesArret(id)
{
    var ident = "";
    fetch('./sources/requetes/convert_id_ident_arret.php?gid='+id)
        .then(response => response.json())
        .then(data => {
            ident = data;

        texte = "<h3>Prochains passages</h3>";
        url_prochains_passages = "https://data.bordeaux-metropole.fr/geojson/process/saeiv_arret_passages?key=177BEEMTWZ&datainputs={%22arret_id%22:\""+ident+"\"}&attributes=[%22libelle%22,%22hor_app%22,%22hor_estime%22,%22terminus%22,%22vehicule%22]"
        $.ajax({
            url: url_prochains_passages,
            dataType: "json",
            cache: false,
            success: function(data) {

                // type de retour : {"type":"FeatureCollection","features":[{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:00:00","hor_estime":"2023-04-05T11:00:00","terminus":"Beausoleil","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:02:00","hor_estime":"2023-04-05T11:03:26","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:11:00","hor_estime":"2023-04-05T11:11:00","terminus":"Beausoleil","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:12:00","hor_estime":"2023-04-05T11:14:40","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 16","hor_app":"2023-04-05T11:22:00","hor_estime":"2023-04-05T11:21:28","terminus":"Les Pins","vehicule":"BUS"}},{"type":"Feature","geometry":null,"properties":{"libelle":"Lianes 10","hor_app":"2023-04-05T11:22:00","hor_estime":"2023-04-05T11:22:00","terminus":"Beausoleil","vehicule":"BUS"}}]}
                //horaire_actuel et horaire_hor_estime sont des strings de la forme "2023-04-05T11:00:00"
                var horaire_actuel;
                var horaire_hor_estime;
                var diff;
                var diff_prochain_passage;
                texte += "<table>";
                texte += "<tr><th>ligne</th><th>temps d'attente</th><th>terminus</th><th>type de véhicule</th></tr>";
                for (var i = 0; i < data.features.length; i++) {
                                    //recuperer l'horaire actuel fuseau de paris
                    horaire_actuel = new Date().toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                    // convertire horaire actuel de  05/04/2023 13:22:38 à 13:22:38
                    horaire_actuel = horaire_actuel.split(" ")[1]; 
                    horaire_hor_estime = new Date(data.features[i].properties.hor_estime);
                    // convertire horaire horaire_hor_estime de  horaire_hor_estime : Wed Apr 05 2023 13:36:26 GMT+0200 (heure d’été d’Europe centrale) à 13:36:26
                    horaire_hor_estime = horaire_hor_estime.toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                    horaire_hor_estime = horaire_hor_estime.split(" ")[1];
                    diff = difference_entre_deux_horaires(horaire_actuel, horaire_hor_estime);
                    if (i == 0)
                    {
                        diff_prochain_passage = diff;
                    }
                    texte += "<tr><td>"+data.features[i].properties.libelle+"</td><td> Estimé dans : "+diff+" Min</td><td>"+data.features[i].properties.terminus+"</td><td>"+data.features[i].properties.vehicule+"</td></tr>";
                }
                texte += "</table>";
                
                //modfier le popup de l'arret et ajouter texte à la fin var elements = document.getElementsByClassName(names);
                var elements = document.getElementsByClassName("popup_arret");
                for (var i = 0; i < elements.length; i++) {
                    elements[i].innerHTML += texte;
                }
            }
        });
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
    var bouton_isochrone_pieton = "<button id='"+e.id+"' onclick='afficherIsochronePieton("+e.latitude+","+e.longitude+")'>Afficher l'isochrone pieton</button>";
    var bouton_isochrone_velo = "<button id='"+e.id+"' onclick='afficherIsochroneVelo("+e.latitude+","+e.longitude+")'>Afficher l'isochrone velo</button>";

    var popup = "<div class='popup_arret'><h3>"+nom+"</h3><p>"+vehicule+"</p><p>"+gid+"</p><p>"+L_lignes+"</p><p>"+bouton+"</p><p>"+bouton_isochrone_pieton+"</p><p>"+bouton_isochrone_velo+"</p></div>";
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

                id = arret.id;

                var ident = "";
                var couleur1 = fetch('./sources/requetes/convert_id_ident_arret.php?gid='+id)
                    .then(response => response.json())
                    .then(data => {
                        ident = data;
                    url_prochains_passages = "https://data.bordeaux-metropole.fr/geojson/process/saeiv_arret_passages?key=177BEEMTWZ&datainputs={%22arret_id%22:\""+ident+"\"}&attributes=[%22libelle%22,%22hor_app%22,%22hor_estime%22,%22terminus%22,%22vehicule%22]"
                    var couleur2 = $.ajax({
                        url: url_prochains_passages,
                        dataType: "json",
                        cache: false,
                        success: function(data) {
                            var horaire_actuel;
                            var horaire_hor_estime;
                            var diff;
                            var diff_prochain_passage;
                            //recuperer l'horaire actuel fuseau de paris
                            horaire_actuel = new Date().toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                            // convertire horaire actuel de  05/04/2023 13:22:38 à 13:22:38
                            horaire_actuel = horaire_actuel.split(" ")[1];
                            try {
                                horaire_hor_estime = new Date(data.features[0].properties.hor_estime);
                                                // convertire horaire horaire_hor_estime de  horaire_hor_estime : Wed Apr 05 2023 13:36:26 GMT+0200 (heure d’été d’Europe centrale) à 13:36:26
                                horaire_hor_estime = horaire_hor_estime.toLocaleString("fr-FR", {timeZone: "Europe/Paris"});
                                horaire_hor_estime = horaire_hor_estime.split(" ")[1];
                                diff = difference_entre_deux_horaires(horaire_actuel, horaire_hor_estime);
                                diff_prochain_passage = diff;
                            }
                            catch (e) {
                                diff_prochain_passage = "pas de passage";
                            }
                            var couleur =  couleur_bulle_prochain_passage(diff_prochain_passage);
                            if (couleur == "red")
                            {
                                var tram_station_Icon_color = L.icon({
                                    iconUrl: './sources/icons/tram_station_red.png',
                                    iconSize:     [taille_icon, taille_icon], // size of the icon
                                    iconAnchor: [taille_icon/2, taille_icon],
                                    popupAnchor: [0, -taille_icon/2],
                                });
                            }
                            else if (couleur == "orange")
                            {
                                var tram_station_Icon_color = L.icon({
                                    iconUrl: './sources/icons/tram_station_orange.png',
                                    iconSize:     [taille_icon, taille_icon], // size of the icon
                                    iconAnchor: [taille_icon/2, taille_icon],
                                    popupAnchor: [0, -taille_icon/2],
                                });
                            }
                            else if (couleur == "green")
                            {
                                var tram_station_Icon_color = L.icon({
                                    iconUrl: './sources/icons/tram_station_green.png',
                                    iconSize:     [taille_icon, taille_icon], // size of the icon
                                    iconAnchor: [taille_icon/2, taille_icon],
                                    popupAnchor: [0, -taille_icon/2],
                                });
                            }
                            else if (couleur == "grey")
                            {
                                var tram_station_Icon_color = L.icon({
                                    iconUrl: './sources/icons/tram_station_grey.png',
                                    iconSize:     [taille_icon, taille_icon], // size of the icon
                                    iconAnchor: [taille_icon/2, taille_icon],
                                    popupAnchor: [0, -taille_icon/2],
                                });
                            }
                            else 
                            {
                                var tram_station_Icon_color = L.icon({
                                    iconUrl: './sources/icons/tram_station.png',
                                    iconSize:     [taille_icon, taille_icon], // size of the icon
                                    iconAnchor: [taille_icon/2, taille_icon],
                                    popupAnchor: [0, -taille_icon/2],
                                });
                            }
            
            
                            nb_arrets_tram++;
                            L.marker([latitude,longitude],{icon: tram_station_Icon_color}, {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).bindPopup(afficherPopupArret(arret)).addTo(feature_group_arrets_tram);
                        }
                    });
                }
                );
            }
            affichage();
        }
    )
    checkSumInitialLoaging++;
}
);


