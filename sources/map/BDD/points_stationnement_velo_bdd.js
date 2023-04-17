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
    popup += "<button id='velo' onclick='afficherIsochronePieton("+stat_velo.latitude+","+stat_velo.longitude+")'>Afficher l'isochrone pieton</button>";
    popup += "<button id='velo' onclick='afficherIsochroneVelo("+stat_velo.latitude+","+stat_velo.longitude+")'>Afficher l'isochrone velo</button>";
    return popup;
}

function afficherPopupStatsVelosAPI(stat_velo)
{
    var gestionnaire = "Gestionnaire : " + stat_velo.properties.parking_velo_table_Gestionnaire;
    var nb_arceaux = "Nombre d'arceaux : " + stat_velo.properties.parking_velo_table_Nombre_arcea;
    var nb_places = "Nombre de places : " + stat_velo.properties.parking_velo_table_Nombre_place;
    if (stat_velo.properties.parking_velo_table_Parkin_abrit == "Oui") {
        var abrite = "Abrité";
    }
    else {
        var abrite = "Non abrité";
    }
    if (stat_velo.properties.parking_velo_table_Sécurisé == "Oui") {
        var securise = "Sécurisé";
    } else {
        var securise = "Non sécurisé";
    }
    var etat = "Etat : " + stat_velo.properties.parking_velo_table_Etat;
    var presence_arm = "Présence d'armoire : " + stat_velo.properties.parking_velo_table_Présence_arm;
    var popup = gestionnaire + "<br>" + nb_arceaux + "<br>" + nb_places + "<br>" + abrite + "<br>" + securise + "<br>" + etat + "<br>" + presence_arm;
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

            affichage();
        });        
    })
    .catch(error => console.error(error));


    $.ajax({
        url: "https://services2.arcgis.com/YAkAcaA6FerLbukZ/ArcGIS/rest/services/Parking_velo_WFL1/FeatureServer/1/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=standard&distance=0.0&units=esriSRUnit_Meter&relationParam=&returnGeodetic=true&outFields=parking_velo_table_Gestionnaire%2C+parking_velo_table_Nombre_arcea%2C+parking_velo_table_Nombre_place%2C+parking_velo_table_Parkin_abrit%2C+parking_velo_table_S%C3%A9curis%C3%A9%2C+parking_velo_table_Etat%2C+parking_velo_table_Pr%C3%A9sence_arm%2C+parking_velo_table_Name%2C+&returnGeometry=true&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&defaultSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=true&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=standard&f=pgeojson&token=",
        dataType: "json",
        cache: false,
        success: function(data) {
        {
        // suppression des marqueurs existants de la carte
        feature_group_pts_stationnement_velo_bdd.eachLayer(function (layer) {
            if (layer instanceof L.Marker) {
                feature_group_pts_stationnement_velo_bdd.removeLayer(layer);
            }
            if (layer instanceof L.Polyline) {
                feature_group_pts_stationnement_velo_bdd.removeLayer(layer);
            }
        });
        $.each(data.features, function(key, val) {
            try {
                //inversé les coordonnées val.features.geometry.coordinates
                val.geometry.coordinates.reverse();
                var marker = L.marker([val.geometry.coordinates[0], val.geometry.coordinates[1]], {icon: vcub_Icon}).bindPopup(afficherPopupStatsVelosAPI(val)).addTo(feature_group_pts_stationnement_velo_bdd);
            
            }
            catch(e)
            {
                console.log(e);
            }
            });
            
        }
        checkSumInitialLoaging++;
        }
    });

}

updateBddStatsVelos(); // affichage des stationnements vélos de la bdd