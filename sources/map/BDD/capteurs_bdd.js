var feature_group_capteurs_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupCapteurs(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    // var e_s = "Entrée/Sortie total : " + capteur.entree_sortie;
    
    var popup = nom + "<br>" + type + "<br> Capteurs";
    return popup;
}


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
        data.forEach(function(capteur) {
            var iconUrl = './sources/icons/capteur.png';

            if (capteur.type_capteur.includes("radar")) {
            iconUrl = './sources/icons/radar.png';
            } else if (capteur.type_capteur.includes("caméra")) {
            iconUrl = './sources/icons/camera.png';
            } else if (capteur.type_capteur.includes("tube")) {
            iconUrl = './sources/icons/tube.png';
            }

            var marker = L.marker([capteur.latitude, capteur.longitude], { icon: L.icon({ iconUrl: iconUrl, iconSize: [taille_icon, taille_icon] }) }).addTo(feature_group_capteurs_bdd);
            marker.bindPopup(afficherPopupCapteurs(capteur));
            
            affichage();
        });                
        checkSumInitialLoaging++;
        
    })
    .catch(error => console.error(error)); 
}

updateBddCapteurs(); // affichage des capteurs de la bdd