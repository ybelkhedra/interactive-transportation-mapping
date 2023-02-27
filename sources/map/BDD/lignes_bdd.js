<<<<<<< HEAD
// var feature_group_lignes_bdd = L.featureGroup( // création d'un groupe de marqueurs
//     {}
// ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte
// DEJA DEFINI DANS API/lignes_bus_tram.js
=======
var feature_group_lignes_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte

function afficherPopupLignes(ligne)
{
    var nom = "Nom : " + ligne.nom;
    var type = "Type : " + ligne.type;
    var direction = "Direction : " + ligne.direction;
    var info_complementaires = "Informations complémentaires : " + ligne.info_complementaires;
    
    var popup = nom + "<br>" + type + "<br>" + direction + "<br>" + info_complementaires;
    return popup;
}



function updateBddLignes(){
    // suppression des marqueurs existants de la carte
    feature_group_lignes_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_lignes_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/lignes.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(ligne) { // pour chaque ligne
            if (ligne.coordonnees.length == 1) {// si le ligne n'a qu'une seule coordonnée
            var marker = L.marker([ligne.coordonnees[0].latitude, ligne.coordonnees[0].longitude]).addTo(feature_group_lignes_bdd); // création du marqueur
            marker.bindPopup(afficherPopupLignes(ligne)); // ajout du popup
            marker.setStyle({color: 'green'}); // on definie la couleur du marker
            }
            //else if (ligne.coordonnees.length > 1) { // si le ligne a plusieurs coordonnées
            //    var latlngs = []; // création d'un tableau vide 
            //    ligne.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
            //        latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
            //    }
            //    );
            //    var polygon = L.polygon(latlngs).addTo(feature_group_lignes_bdd); // création du polygone
            //    polygon.setStyle({color: 'green'}); // changement de la couleur du polygone
            //    polygon.bindPopup(afficherPopupLignes(ligne)); // ajout du popup
            //}
        });
        
    })
    .catch(error => console.error(error)); 
}

// updateBddLignes(); // affichage des pistes cyclables de la bdd
>>>>>>> 6a5f5fb49adcf0d52d04f566cb46c2d2ecd1cda8
