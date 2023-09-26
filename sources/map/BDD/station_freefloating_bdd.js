var feature_group_freefloating_bdd = L.featureGroup(
  // création d'un groupe de marqueurs
  {}
); //.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte

var freefloatingIcon = L.icon({
  iconUrl: "./sources/icons/freefloating.png",

  iconSize: [taille_icon, taille_icon], // size of the icon
});

function afficherPopupFreeFloating(e) {
  var nom = "Nom : " + e.nom;
  var infos = "Informations : " + e.infos_complementaires;
  var vehicules = [];
  for (var i = 0; i < e.vehicules_freefloating.length; i++) {
    vehicules.push(e.vehicules_freefloating[i]["vehicule"]);
  }
  var vehicules_autorises = "Vehicules autorisés : " + vehicules.join(" - ");
  var popup = nom + "<br>" + infos + "<br>" + vehicules_autorises + "<br>";
  popup +=
    "<button id='freefloating' onclick='afficherIsochronePieton(" +
    e.coordonnees[0].latitude +
    "," +
    e.coordonnees[0].longitude +
    ")'>Afficher l'isochrone pieton</button>";
  popup +=
    "<button id='freefloating' onclick='afficherIsochroneVelo(" +
    e.coordonnees[0].latitude +
    "," +
    e.coordonnees[0].longitude +
    ")'>Afficher l'isochrone velo</button>";

  return popup;
}

function afficherPopupFreeFloatingAPI(e) {
  var vehicules_autorises = "";
  if (e.properties.typologie == "VT") {
    vehicules_autorises = "Vélo Trottinette";
  } else if (e.properties.typologie == "VTS") {
    vehicules_autorises = "Vélo Trottinette Scooter";
  }
  var bouton_isochrone_pieton =
    "<button id='freefloating' onclick='afficherIsochronePieton(" +
    e.geometry.coordinates[1] +
    "," +
    e.geometry.coordinates[0] +
    ")'>Afficher l'isochrone pieton</button>";
  var bouton_isochrone_velo =
    "<button id='freefloating' onclick='afficherIsochroneVelo(" +
    e.geometry.coordinates[1] +
    "," +
    e.geometry.coordinates[0] +
    ")'>Afficher l'isochrone velo</button>";
  var popup =
    "<br>Vehicle autorisé : " +
    vehicules_autorises +
    "</br><br>" +
    bouton_isochrone_pieton +
    "</br><br>" +
    bouton_isochrone_velo +
    "</br>";
  return popup;
}

function updateBddStationsFreeFloating() {
  //a renommer en updateBddPointsCharges
  // suppression des marqueurs existants de la carte
  feature_group_freefloating_bdd.eachLayer(function (layer) {
    if (layer instanceof L.Marker) {
      feature_group_freefloating_bdd.removeLayer(layer);
    }
  });

  $.ajax({
    url: baseURL + "stationnements_freefloating/",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        $.each(data.data, function (key, st_freefloating) {
          try {
            // pour chaque st_freefloating
            pt_freefloating++;
            var length = st_freefloating.coordonnees.length;
            if (length == 1) {
              // si le st_freefloating n'a qu'une seule coordonnée
              var marker = L.marker(
                [
                  st_freefloating.coordonnees[0].latitude,
                  st_freefloating.coordonnees[0].longitude,
                ],
                { icon: freefloatingIcon }
              ).addTo(feature_group_freefloating_bdd); // création du marqueur
              marker.bindPopup(afficherPopupFreeFloating(st_freefloating)); // ajout du popup
            } else if (length > 1) {
              // si le st_freefloating a plusieurs coordonnées
              var latlngs = []; // création d'un tableau vide
              var sumLat = 0;
              var sumLng = 0;
              st_freefloating.coordonnees.forEach(function (coordonnee) {
                // pour chaque coordonnée
                latlngs.push([coordonnee.latitude, coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                sumLat += coordonnee.latitude;
                sumLng += coordonnee.longitude;
              });
              L.marker([sumLat / length, sumLng / length], {
                icon: freefloatingIcon,
              })
                .addTo(feature_group_freefloating_bdd)
                .bindPopup(afficherPopupFreeFloating(st_freefloating));
              var polygon = L.polygon(latlngs).addTo(
                feature_group_freefloating_bdd
              ); // création du polygone
              polygon.setStyle({ color: "blue" }); // changement de la couleur du polygone
              polygon.bindPopup(afficherPopupFreeFloating(st_freefloating)); // ajout du popup
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

  // récupération des données en utilisant l'URL du WebService GeoJSON
  $.ajax({
    url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_freefloating_s",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        // ajout de ligne de traffic chargé ou fluide
        $.each(data.features, function (key, val) {
          // Récupération des valeurs de latitude et longitude
          var latitude = val.geometry.coordinates[0][0][1];
          var longitude = val.geometry.coordinates[0][0][0];
          if (
            isNaN(latitude) ||
            isNaN(longitude) ||
            !filtreCordonnees(latitude, longitude)
          ) {
            return;
          }
          // Ajout d'un marker sur la carte
          pt_freefloating++;
          var length = val.geometry.coordinates[0].length;
          if (length == 1) {
            // si le st_freefloating n'a qu'une seule coordonnée
            var marker = L.marker(
              [
                val.geometry.coordinates[0][0][1],
                val.geometry.coordinates[0][0][0],
              ],
              { icon: freefloatingIcon }
            ).addTo(feature_group_freefloating_bdd); // création du marqueur
            marker.bindPopup(afficherPopupFreeFloatingAPI(val)); // ajout du popup
          } else if (length > 1) {
            // si le st_freefloating a plusieurs coordonnées
            var latlngs = []; // création d'un tableau vide
            var sumLat = 0;
            var sumLng = 0;
            val.geometry.coordinates[0].forEach(function (coordonnee) {
              // pour chaque coordonnée
              latlngs.push([coordonnee[1], coordonnee[0]]); // ajout des coordonnées au tableau latlngs
              sumLat += coordonnee[1];
              sumLng += coordonnee[0];
            });
            L.marker([sumLat / length, sumLng / length], {
              icon: freefloatingIcon,
            })
              .addTo(feature_group_freefloating_bdd)
              .bindPopup(afficherPopupFreeFloatingAPI(val));
            var polygon = L.polygon(latlngs).addTo(
              feature_group_freefloating_bdd
            ); // création du polygone
            polygon.setStyle({ color: "blue" }); // changement de la couleur du polygone
            polygon.bindPopup(afficherPopupFreeFloatingAPI(val)); // ajout du popup
            affichage();
          }
        });
      }
      checkSumInitialLoaging++;
    },
  });
}

updateBddStationsFreeFloating();
