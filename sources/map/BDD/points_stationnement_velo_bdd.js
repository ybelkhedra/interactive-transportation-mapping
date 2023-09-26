var feature_group_pts_stationnement_velo_bdd = L.featureGroup(
  // création d'un groupe de marqueurs
  {}
); //.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte

var stat_velo_Icon = L.icon({
  iconUrl: "./sources/icons/velo_parking.png",

  iconSize: [taille_icon, taille_icon],
});

function afficherPopupStatsVelos(stat_velo) {
  var nb_places = "Nombre de places : " + stat_velo.nb_places;
  var info_complementaires =
    "Informations complémentaires : " + stat_velo.infos_complementaires;
  if (stat_velo.securise == 1) {
    var securise = "Sécurisé";
  } else {
    var securise = "Non sécurisé";
  }
  if (stat_velo.abrite == 1) {
    var abrite = "Abrité";
  } else {
    var abrite = "Non abrité";
  }
  var types_accroches =
    "Types d'accroches : " + stat_velo.types_accroches[0].nom;
  for (var i = 1; i < stat_velo.types_accroches.length; i++) {
    types_accroches += ", " + stat_velo.types_accroches[i].nom;
  }

  var popup =
    nb_places +
    "<br>" +
    securise +
    "<br>" +
    abrite +
    "<br>" +
    types_accroches +
    "<br>" +
    info_complementaires +
    "<br>";
  popup +=
    "<button id='velo' onclick='afficherIsochronePieton(" +
    stat_velo.coordonnees[0].latitude +
    "," +
    stat_velo.coordonnees[0].longitude +
    ")'>Afficher l'isochrone pieton</button>";
  popup +=
    "<button id='velo' onclick='afficherIsochroneVelo(" +
    stat_velo.coordonnees[0].latitude +
    "," +
    stat_velo.coordonnees[0].longitude +
    ")'>Afficher l'isochrone velo</button>";
  return popup;
}

function afficherPopupStatsVelosAPI(stat_velo) {
  var gestionnaire = "Gestionnaire : " + stat_velo.prop_velo_table_Gestionnaire;
  var nb_arceaux =
    "Nombre d'arceaux : " + stat_velo.prop_velo_table_Nombre_arcea;
  var nb_places =
    "Nombre de places : " + stat_velo.prop_velo_table_Nombre_place;
  if (stat_velo.prop_velo_table_Parkin_abrit == "Oui") {
    var abrite = "Abrité";
  } else {
    var abrite = "Non abrité";
  }
  if (stat_velo.prop_velo_table_Sécurisé == "Oui") {
    var securise = "Sécurisé";
  } else {
    var securise = "Non sécurisé";
  }
  var etat = "Etat : " + stat_velo.prop_velo_table_Etat;
  var presence_arm =
    "Présence d'armoire : " + stat_velo.prop_velo_table_Présence_arm;
  var popup =
    gestionnaire +
    "<br>" +
    nb_arceaux +
    "<br>" +
    nb_places +
    "<br>" +
    abrite +
    "<br>" +
    securise +
    "<br>" +
    etat +
    "<br>" +
    presence_arm;
  return popup;
}

function updateBddStatsVelos() {
  // suppression des marqueurs existants de la carte
  feature_group_pts_stationnement_velo_bdd.eachLayer(function (layer) {
    if (layer instanceof L.Marker) {
      feature_group_pts_stationnement_velo_bdd.removeLayer(layer);
    }
  });

  $.ajax({
    url: baseURL + "stationnements_velos/",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        $.each(data.data, function (key, stat_velo) {
          try {
            // pour chaque stat_velo
            var length = stat_velo.coordonnees.length;
            if (length == 1) {
              // si le stat_velo n'a qu'une seule coordonnée
              L.marker(
                [
                  stat_velo.coordonnees[0].latitude,
                  stat_velo.coordonnees[0].longitude,
                ],
                { icon: stat_velo_Icon }
              )
                .addTo(feature_group_pts_stationnement_velo_bdd)
                .bindPopup(afficherPopupStatsVelos(stat_velo)); // ajout du popup
            } else if (length > 1) {
              // si le stat_velo a plusieurs coordonnées
              var latlngs = []; // création d'un tableau vide
              var sumLat = 0;
              var sumLng = 0;
              stat_velo.coordonnees.forEach(function (coordonnee) {
                // pour chaque coordonnée
                latlngs.push([coordonnee.latitude, coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                sumLat += coordonnee.latitude;
                sumLng += coordonnee.longitude;
              });
              L.marker([sumLat / length, sumLng / length], {
                icon: stat_velo_Icon,
              })
                .addTo(feature_group_pts_stationnement_velo_bdd)
                .bindPopup(afficherPopupStatsVelos(stat_velo));
              var polygon = L.polygon(latlngs).addTo(
                feature_group_pts_stationnement_velo_bdd
              ); // création du polygone
              polygon.setStyle({ color: "blue" }); // changement de la couleur du polygone
              polygon.bindPopup(afficherPopupStatsVelos(stat_velo)); // ajout du popup
              affichage();
            }
          } catch (e) {
            console.log(e);
          }
        });
      }
      checkSumInitialLoaging++;
    },
  });

  $.ajax({
    url: "https://services2.arcgis.com/YAkAcaA6FerLbukZ/ArcGIS/rest/se_velo_WFL1/FeatureServer/1/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=standard&distance=0.0&units=esriSRUnit_Meter&relationParam=&returnGeodetic=true&out_velo_table_Gestionna_velo_table_Nombre_ar_velo_table_Nombre_pl_velo_table_Parkin_ab_velo_table_S%C3%A9curis%C3_velo_table_E_velo_table_Pr%C3%A9sence__velo_table_Name%2C+&returnGeometry=true&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&defaultSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=true&returnDistinctValues=false&cacheHint=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=standard&f=pgeojson&token=",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        $.each(data.features, function (key, val) {
          try {
            //inverser les coordonnées val.features.geometry.coordinates
            val.geometry.coordinates.reverse();
            L.marker(
              [val.geometry.coordinates[0], val.geometry.coordinates[1]],
              { icon: stat_velo_Icon }
            )
              .bindPopup(afficherPopupStatsVelosAPI(val))
              .addTo(feature_group_pts_stationnement_velo_bdd);
          } catch (e) {
            console.log(e);
          }
        });
      }
      checkSumInitialLoaging++;
    },
  });
}

updateBddStatsVelos(); // affichage des stationnements vélos de la bdd
