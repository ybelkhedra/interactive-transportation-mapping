var feature_group_capteurs_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupCapteurs(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    var e_s = "Entrée/Sortie total : " + capteur.entree_sortie;
    
    var popup = nom + "<br>" + type + "<br>" + e_s;
    return popup;
}

var capteur_Icon = L.icon({
    iconUrl: './sources/icons/capteur.png',

    iconSize:     [taille_icon, taille_icon], 
});


function updateBddCapteurs(){
    // suppression des marqueurs existants de la carte
    feature_group_capteurs_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_capteurs_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/capteurs.php')
    .then(response => response.json())
    .then(data => {
        console.log(data);
        data.forEach(function(capteur) {
            var marker = L.marker([capteur.latitude, capteur.longitude], {icon: capteur_Icon}).addTo(feature_group_capteurs_bdd); // création du marqueur
            marker.bindPopup(afficherPopupCapteurs(capteur)); // ajout du popup
            
            if (capteur.entree_sortie > 0) {
                var circleColor;
                var circleRadius = 40 + Math.floor(capteur.entree_sortie / 200);
                
                if (capteur.entree_sortie >= 15000) {
                    circleColor = "darkred";
                } else if (capteur.entree_sortie >= 10000) {
                    circleColor = "red";
                } else if (capteur.entree_sortie >= 5000) {
                    circleColor = "orange";
                } else if (capteur.entree_sortie >= 2500) {
                    circleColor = "yellow";
                } else {
                    circleColor = "green";
                }
                
                L.circle([capteur.latitude, capteur.longitude], {
                    color: circleColor,
                    fillColor: circleColor,
                    fillOpacity: 0.5,
                    radius: circleRadius,
                    stroke: false
                }).addTo(feature_group_capteurs_bdd);
            }
            
            affichage();
        });                
        checkSumInitialLoaging++;
        
    })
    .catch(error => console.error(error)); 
}

updateBddCapteurs(); // affichage des capteurs de la bdd