function afficherPopupParkings(parking) {
  var nom = "Nom : " + parking.nom;
  var nb_places_max = "Nombre de places maximum : " + parking.nb_places_max;
  var nb_places_disponibles = "";
  if (parking.nb_places_disponibles != null) {
    nb_places_disponibles =
      "Nombre de places disponibles : " +
      parking.nb_places_disponibles +
      "<br>";
  }
  var nb_places_handicapes =
    "Nombre de places handicapés : " + parking.nb_places_handicapes;
  var informations_complementaires =
    "Informations complémentaires : " + parking.infos_complementaires;
  if (parking.payant == 1) {
    var payant = "Payant";
  } else {
    var payant = "Gratuit";
  }
  if (parking.hors_voirie == 1) {
    var hors_voirie = "Hors voirie";
  } else {
    var hors_voirie = "Sur voirie";
  }
  if (parking.prive == 1) {
    var prive = "Privé";
  } else {
    var prive = "Public";
  }
  var popup =
    nom +
    "<br>" +
    nb_places_max +
    "<br>" +
    nb_places_disponibles +
    nb_places_handicapes +
    "<br>" +
    informations_complementaires +
    "<br>" +
    payant +
    "<br>" +
    hors_voirie +
    "<br>" +
    prive +
    "<br>";
  popup +=
    "<button id='parkings' onclick='afficherIsochronePieton(" +
    parking.coordonnees[0].latitude +
    "," +
    parking.coordonnees[0].longitude +
    ")'>Afficher l'isochrone pieton</button>";
  popup +=
    "<button id='parkings' onclick='afficherIsochroneVelo(" +
    parking.coordonnees[0].latitude +
    "," +
    parking.coordonnees[0].longitude +
    ")'>Afficher l'isochrone velo</button>";
  return popup;
}

function updateBddParkings() {
  $.ajax({
    url: baseURL + "parkings/",
    dataType: "json",
    cache: false,
    success: function (data) {
      {
        $.each(data.data, function (key, parking) {
          try {
            // pour chaque parking
            nb_parkings++;
            var length = parking.coordonnees.length;
            if (length == 1) {
              // si le parking n'a qu'une seule coordonnée
              var marker = L.marker(
                [
                  parking.coordonnees[0].latitude,
                  parking.coordonnees[0].longitude,
                ],
                { icon: parkingbddIcon }
              ).addTo(feature_group_parkings); // création du marqueur
              marker.bindPopup(afficherPopupParkings(parking)); // ajout du popup
            } else if (length > 1) {
              // si le parking a plusieurs coordonnées
              var latlngs = []; // création d'un tableau vide
              var sumLat = 0;
              var sumLng = 0;
              parking.coordonnees.forEach(function (coordonnee) {
                // pour chaque coordonnée
                latlngs.push([coordonnee.latitude, coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                sumLat += coordonnee.latitude;
                sumLng += coordonnee.longitude;
              });
              L.marker([sumLat / length, sumLng / length], {
                icon: parkingbddIcon,
              })
                .addTo(feature_group_parkings)
                .bindPopup(afficherPopupParkings(parking));
              var polygon = L.polygon(latlngs).addTo(feature_group_parkings); // création du polygone
              polygon.setStyle({ color: "blue" }); // changement de la couleur du polygone
              polygon.bindPopup(afficherPopupParkings(parking)); // ajout du popup
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

updateBddParkings(); // affichage des parkings de la bdd
