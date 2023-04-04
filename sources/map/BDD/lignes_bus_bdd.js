function updateBddLignesBus(){
    // suppression des marqueurs existants de la carte
    feature_group_ligne_bus.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.Polyline) {
            feature_group_ligne_bus.removeLayer(layer);
        }
    });
    //récupération des données de la bdd
    fetch('./sources/requetes/lignes.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(ligne) { // pour chaque ligne
            if (ligne.type != "Tramway") {
                if (ligne.coordonnees.length == 1) {// si le ligne n'a qu'une seule coordonnée
                    var marker = L.marker([ligne.coordonnees[0].latitude, ligne.coordonnees[0].longitude]); // création du marqueur
                    var popupContent = "Nom : " + ligne.nom + "<br>Type : " + ligne.type + "<br>Direction : " + ligne.direction + "<br>Informations complémentaires : " + ligne.info_complementaires; // ajout des informations à afficher dans le popup
                    marker.bindPopup(popupContent); // ajout du popup
                    //marker.setStyle({color: 'green'}); // on definie la couleur du marker
                    feature_group_ligne_bus.addLayer(marker); // ajout du marqueur au groupe de marqueurs
                }
                else if (ligne.coordonnees.length > 1) { // si le ligne a plusieurs coordonnées
                    var latlngs = []; // création d'un tableau vide 
                    ligne.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
                        latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                    });
                    var polyline = L.polyline(latlngs); // création de la polyline
                    var popupContent = "Nom : " + ligne.nom + "<br>Type : " + ligne.type + "<br>Direction : " + ligne.direction + "<br>Informations complémentaires : " + ligne.info_complementaires; // ajout des informations à afficher dans le popup
                    polyline.bindPopup(popupContent); // ajout du popup
                    polyline.setStyle({color: 'green',weight:5}); // changement de la couleur de la polyline
                    feature_group_ligne_bus.addLayer(polyline); // ajout de la polyline au groupe de marqueurs
                }
                affichage();
            }
        });
    })
    .catch(error => console.error(error)); 
}

updateBddLignesBus();