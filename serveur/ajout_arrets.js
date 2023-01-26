// Programme qui se connecte au API de openData pour recuperer les arrets de bus, les lignes de bus, les horaires appliquables a chaque arret et les ajoute a la base de donnees

// Récuperation des données depuis l'API de openData
function getJSON(url) {
  var req = new XMLHttpRequest();
  req.open('GET', url, false);
  req.send(null);
  if (req.status == 200)
    return JSON.parse(req.responseText);
}

var arretsData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_arret_p');
var lignesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_chem_l');
var tronconData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_tronc_l');
var relationLigneTronconData = getJSON('https://data.bordeaux-metropole.fr/geojson/relations/SV_TRONC_L/SV_CHEM_L?key=177BEEMTWZ');
var horairesData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_horai_a');
var nomCommercialData = getJSON('https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_ligne_a');

// Pour chaque arrets, on affiche les lignes qui passent par cet arrêt, les horaires de passage et les informations generales comme le nom, la localisation, etc.
for (var i = 0; i < 5; i++) {
    var arret = arretsData.features[i];
    var arretId = arret.properties.gid;
    var arretNom = arret.properties.nom;
    var arretLat = arret.geometry.coordinates[1];
    var arretLng = arret.geometry.coordinates[0];
    var tronconsConcerne = [];

    // On récupère les troncons qui passent par cet arrêt
    for (var j = 0; j < relationLigneTronconData.features.length; j++) {
        var relation = relationLigneTronconData.features[j];
        if (relation.properties.rs_sv_arret_p == arretId) {
            tronconsConcerne.push(relation.properties.rs_sv_tronc_l);
        }
    }

    // On récupère les lignes qui passent par cet arrêt grâce aux troncons
    var lignesConcerne = [];
    for (var j = 0; j < tronconsConcerne.length; j++) {
        var tronconId = tronconsConcerne[j];
        for (var k = 0; k < relationLigneTronconData.features.length; k++) {
            var relation = relationLigneTronconData.features[k];
            if (relation.properties.rs_sv_tronc_l == tronconId) {
                lignesConcerne.push(relation.properties.rs_sv_chem_l);
            }
        }
    }

    // On récupère les horaires de passage des lignes qui passent par cet arrêt
    var horairesConcerne = [];
    for (var j = 0; j < horairesData.features.length; j++) {
        var horaire = horairesData.features[j];
        if (horaire.properties.arret == arretId) {
            horairesConcerne.push(horaire);
        }
    }

    // On affiche ces informations clairement pour l'utilisateur
    console.log("Arret " + arretNom + " (" + arretLat + ", " + arretLng + ")");
    console.log("Lignes :");
    for (var j = 0; j < lignesConcerne.length; j++) {
        var ligneId = lignesConcerne[j];
        var ligneNom = "";
        var ligneVehicule = "";
        for (var k = 0; k < lignesData.features.length; k++) {
            var ligne = lignesData.features[k];
            if (ligne.properties.gid == ligneId) {
                ligneNom = ligne.properties.nom;
                ligneVehicule = ligne.properties.vehicule;
            }
        }
        console.log(" - " + ligneNom + " (" + ligneVehicule + ")");
    }
    console.log("Horaires :");
    for (var j = 0; j < horairesConcerne.length; j++) {
        var horaire = horairesConcerne[j];
        var horaireHeure = horaire.properties.heure;
        var horaireJour = horaire.properties.jour;
        console.log(" - " + horaireHeure + " (" + horaireJour + ")");
    }
    console.log("");
}

