var covoiturageIcon = L.icon({
  iconUrl: "./sources/icons/covoiturage.png",

  iconSize: [taille_icon, taille_icon], // size of the icon
});

function afficherPopupPointsDeCovoit(e) {
  var nom = "Nom : " + e.nom;
  var infos = "Informations : " + e.infos_complementaires;

  var places = "Places totales : " + e.nb_places;

  var popup = nom + "<br>" + places + "<br>" + infos + "<br>";
  popup +=
    "<button id='covoit' onclick='afficherIsochronePieton(" +
    e.coordonnees[0].latitude +
    "," +
    e.coordonnees[0].longitude +
    ")'>Afficher l'isochrone pieton</button>";
  popup +=
    "<button id='covoit' onclick='afficherIsochroneVelo(" +
    e.coordonnees[0].latitude +
    "," +
    e.coordonnees[0].longitude +
    ")'>Afficher l'isochrone velo</button>";

  return popup;
}

function updateBddCovoiturage() {
  // suppression des marqueurs existants de la carte
  feature_group_covoiturages.eachLayer(function (layer) {
    if (layer instanceof L.Marker) {
      feature_group_covoiturages.removeLayer(layer);
    }
  });

  //récupération des données de la bdd
  $.ajax({
    url: baseURL + "points_covoiturage/",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        $.each(data.data, function (key, pdcovoit) {
          try {
            // pour chaque pdcovoit
            pt_covoiturage++;
            var length = pdcovoit.coordonnees.length;
            if (length == 1) {
              // si le pdcovoit n'a qu'une seule coordonnée
              var marker = L.marker(
                [
                  pdcovoit.coordonnees[0].latitude,
                  pdcovoit.coordonnees[0].longitude,
                ],
                { icon: covoiturageIcon }
              ).addTo(feature_group_covoiturages); // création du marqueur
              marker.bindPopup(afficherPopupPointsDeCovoit(pdcovoit)); // ajout du popup
            } else if (length > 1) {
              // si le pdcovoit a plusieurs coordonnées
              var latlngs = []; // création d'un tableau vide
              var sumLat = 0;
              var sumLng = 0;
              pdcovoit.coordonnees.forEach(function (coordonnee) {
                // pour chaque coordonnée
                latlngs.push([coordonnee.latitude, coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                sumLat += coordonnee.latitude;
                sumLng += coordonnee.longitude;
              });
              L.marker([sumLat / length, sumLng / length], {
                icon: covoiturageIcon,
              })
                .addTo(feature_group_covoiturages)
                .bindPopup(afficherPopupPointsDeCovoit(pdcovoit));
              var polygon = L.polygon(latlngs).addTo(
                feature_group_covoiturages
              ); // création du polygone
              polygon.setStyle({ color: "blue" }); // changement de la couleur du polygone
              polygon.bindPopup(afficherPopupPointsDeCovoit(pdcovoit)); // ajout du popup
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
}

updateBddCovoiturage();
