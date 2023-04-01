var feature_group_lignes_car_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
) // ajout du groupe de marqueurs à la carte

function afficherPopupLignes(ligne)
{
    var nom = "Nom : " + ligne.trip_headsign;
    if (ligne.wheelchair_accessible == 1) {
        var acces_handicape = "Accès handicapé : oui";
    } else {
        var acces_handicape = "Accès handicapé : non";
    }
    if (ligne.bikes_allowed == 1) {
        var velo = "Vélo autorisé : oui";
    } else {
        var velo = "Vélo autorisé : non";
    }
    var popup = nom +  "<br>" + acces_handicape + "<br>" + velo + "<br>" ;
    return popup;
}

function convertion_int_to_color(id)
{
    // convertion int id en return {color: "rgb("+r+" ,"+g+","+ b+")"};
    id = id * 100;
    var r = id % 256;
    var g = Math.floor(id / 256) % 256;
    var b = Math.floor(id / 256 / 256) % 256;
    return {color: "rgb("+r+" ,"+g+","+ b+")", weight:5};
}

function updateBddLignesCar(){
    console.log("updateBddLignesCar");
    // suppression des marqueurs existants de la carte
    feature_group_lignes_car_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_lignes_car_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/trips.json')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(ligne) { // pour chaque ligne
            console.log(ligne.id);
            if (ligne.ligne_car.length > 1) { // si le ligne a plusieurs coordonnées
                var latlngs = []; // création d'un tableau vide 
                ligne.ligne_car.forEach(function(coordonnee) { // pour chaque coordonnée
                    latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                });
                nb_lignes_bus++;
                var polyline = L.polyline(latlngs).addTo(feature_group_lignes_car_bdd); // création de la polyline
                polyline.setStyle(convertion_int_to_color(ligne.id)); // changement de la couleur de la polyline
                polyline.bindPopup(afficherPopupLignes(ligne)); // ajout du 
                affichage();
            }
        });
        
    })
    .catch(error => console.error(error)); 
}
updateBddLignesCar(); 