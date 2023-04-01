// var feature_group_parkings = L.featureGroup( // création d'un groupe de marqueurs pour les parkings de la bdd
//     {}
// ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte
// DEJA DEFINI DANS API/parkings.js

function afficherPopupParkings(parking)
{
    var nom = "Nom : " + parking.nom;
    var nb_places_max = "Nombre de places maximum : " + parking.nb_places_max;
    var nb_places_handicapes = "Nombre de places handicapés : " + parking.nb_places_handicapes;
    var informations_complementaires = "Informations complémentaires : " + parking.informations_complementaires;
    if (parking.payant == 1) {
        var payant = "Payant";
    } else {
        var payant = "Gratuit";
    }
    if (parking.hors_voirie == 1) {
        var hors_voirie = "Hors voirie";
    }
    else {
        var hors_voirie = "Sur voirie";
    }
    if (parking.prive == 1) {
        var prive = "Privé";
    }
    else
    {
        var prive = "Public";
    }
    var popup = nom + "<br>" + nb_places_max + "<br>" + nb_places_handicapes + "<br>" + informations_complementaires + "<br>" + payant + "<br>" + hors_voirie + "<br>" + prive;
    return popup;
}


function updateBddParkings(){
    //récupération des données de la bdd
    fetch('./sources/requetes/parkings.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(parking) { // pour chaque parking
            nb_parkings++;
            if (parking.coordonnees.length == 1) {// si le parking n'a qu'une seule coordonnée
            var marker = L.marker([parking.coordonnees[0].latitude, parking.coordonnees[0].longitude], {icon : parkingIcon}).addTo(feature_group_parkings); // création du marqueur
            marker.bindPopup(afficherPopupParkings(parking)); // ajout du popup
            }
            else if (parking.coordonnees.length > 1) { // si le parking a plusieurs coordonnées
                var latlngs = []; // création d'un tableau vide 
                parking.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                }
                );
                var polygon = L.polygon(latlngs).addTo(feature_group_parkings); // création du polygone
                polygon.setStyle({color: 'blue'}); // changement de la couleur du polygone
                polygon.bindPopup(afficherPopupParkings(parking)); // ajout du popup
            }
        });
        
    })
    .catch(error => console.error(error)); 
}

updateBddParkings(); // affichage des parkings de la bdd