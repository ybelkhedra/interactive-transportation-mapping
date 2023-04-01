var feature_group_pts_stationnement_velo_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupStatsVelos(stat_velo)
{
    //Il manque les types d'accroches
    var nb_places = "Nombre de places : " + stat_velo.nb_places_max;
    var info_complementaires = "Informations complémentaires : " + stat_velo.info_complementaires;
    if (stat_velo.securise == 1) {
        var securise = "Sécurisé";
    } else {
        var securise = "Non sécurisé";
    }
    if (stat_velo.abrite == 1) {
        var abrite = "Abrité";
    }
    else {
        var abrite = "Non abrité";
    }
    var popup = nb_places + "<br>" + info_complementaires + "<br>" + securise + "<br>" + abrite;
    return popup;
}


function updateBddStatsVelos(){
    // suppression des marqueurs existants de la carte
    feature_group_pts_stationnement_velo_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pts_stationnement_velo_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/points_stationnement_velo.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(station) { // pour chaque station
            nb_velo++;
            var marker = L.marker([station.latitude, station.longitude], {icon: vcub_Icon}).addTo(feature_group_pts_stationnement_velo_bdd); // création du marqueur
            marker.bindPopup(afficherPopupStatsVelos(station)); // ajout du popup


        });
        
    })
    .catch(error => console.error(error)); 
}

updateBddStatsVelos(); // affichage des stationnements vélos de la bdd