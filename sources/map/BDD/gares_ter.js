var feature_group_gares_ter_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupGares(gare)
{
    var nom = "Nom : " + gare.nom;
    var info_complementaires = "Informations complémentaires : " + gare.info_complementaires;
    
    var popup = nom + "<br>" + info_complementaires;
    popup += "<button id='gare' onclick='afficherIsochronePieton("+gare.latitude+","+gare.longitude+")'>Afficher l'isochrone pieton</button>";
    popup += "<button id='gare' onclick='afficherIsochroneVelo("+gare.latitude+","+gare.longitude+")'>Afficher l'isochrone velo</button>";
    return popup;
}

var gare_Icon = L.icon({
    iconUrl: './sources/icons/train_station.png',

    iconSize:     [taille_icon, taille_icon], // size of the icon
});


function updateBddGares(){
    // suppression des marqueurs existants de la carte
    feature_group_gares_ter_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_gares_ter_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/gares_ter.php')
    .then(response => response.json())
    .then(data => {
        console.log(data);
        data.forEach(function(gare) { // pour chaque gare
            // if (gare.coordonnees.length == 1) {// si le gare n'a qu'une seule coordonnée
            // var marker = L.marker([gare.coordonnees[0].latitude, gare.coordonnees[0].longitude]).addTo(feature_group_gares_ter_bdd); // création du marqueur
            // marker.bindPopup(afficherPopupGares(gare)); // ajout du popup
            // marker.setStyle({color: 'yellow'}); // on definie la couleur du marker
            // }
            // else if (gare.coordonnees.length > 1) { // si le gare a plusieurs coordonnées
            //     var latlngs = []; // création d'un tableau vide 
            //     gare.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
            //         latlngs.push([coordonnee.latitude,coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
            //     }
            //     );
            //     var polygon = L.polygon(latlngs).addTo(feature_group_gares_ter_bdd); // création du polygone
            //     polygon.setStyle({color: 'yellow'}); // changement de la couleur du polygone
            //     polygon.bindPopup(afficherPopupGares(gare)); // ajout du popup
            // }
            
            var marker = L.marker([gare.latitude, gare.longitude], {icon: gare_Icon}).addTo(feature_group_gares_ter_bdd); // création du marqueur
            marker.bindPopup(afficherPopupGares(gare)); // ajout du popup
            //marker.setStyle({color: 'yellow'}); // on definie la couleur du marker
            affichage();


        });
        checkSumInitialLoaging++;
        
    })
    .catch(error => console.error(error)); 
}

updateBddGares(); // affichage des gares de la bdd