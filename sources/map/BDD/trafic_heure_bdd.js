var feature_group_trafic_heure_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupTraficHeure(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    // var e_s = "Entrée/Sortie total : " + capteur.entree_sortie;
    
    var popup = nom + "<br>" + type + "<br> Trafic par heure: " 
    + document.getElementById("datepicker1").value
    + " entre " + debutIntervalle + " et " + finIntervalle;

    popup += "<br>Total véhicules : " + capteur.total_vehicules;
    popup += "<br>EDPM/Trottinette : " + capteur.total_vehicules_EDPM_Trottinette;
    popup += "<br>VELO : " + capteur.total_vehicules_VELO;
    popup += "<br>MOTO : " + capteur.total_vehicules_MOTO;
    popup += "<br>Deux roues/2RM/2R : " + capteur.total_vehicules_Deux_roues_2RM_2R;
    popup += "<br>VL : " + capteur.total_vehicules_VL;
    popup += "<br>BUS : " + capteur.total_vehicules_BUS;
    popup += "<br>PL : " + capteur.total_vehicules_PL;
    popup += "<br>PL_1 : " + capteur.total_vehicules_PL_1;
    popup += "<br>PL_2 : " + capteur.total_vehicules_PL_2;
    popup += "<br>PL/BUS : " + capteur.total_vehicules_PL_BUS;
    popup += "<br>UT : " + capteur.total_vehicules_UT;
    popup += "<br>PT : " + capteur.total_vehicules_PT;

    return popup;
}


function updateBddTraficHeure() {
    var selectedDate = document.getElementById("datepicker1").value;
    if (selectedDate === "") {
        return;
    }
    
    console.log("debutIntervalle: " + debutIntervalle + "   finIntervalle: " + finIntervalle);

    var debut = document.getElementById("timepicker1").value;
    var fin = document.getElementById("timepicker2").value;

    var [heureDebut, minuteDebut] = debut.split(':');
    heureDebut = parseInt(heureDebut, 10);
    minuteDebut = parseInt(minuteDebut, 10);

    // Obtenir l'heure et les minutes de la fin
    var [heureFin, minuteFin] = fin.split(':');
    heureFin = parseInt(heureFin, 10);
    minuteFin = parseInt(minuteFin, 10);

    // Créer les objets Date pour calculer la différence
    var dateDebut = new Date();
    dateDebut.setHours(heureDebut);
    dateDebut.setMinutes(minuteDebut);

    var dateFin = new Date();
    dateFin.setHours(heureFin);
    dateFin.setMinutes(minuteFin);

    // Calculer la différence en minutes
    var differenceMs = dateFin.getTime() - dateDebut.getTime();
    var differenceMin = Math.round(differenceMs / 60000);

    feature_group_trafic_heure_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.Circle) {
            feature_group_trafic_heure_bdd.removeLayer(layer);
        }
    });
    
    fetch('./sources/requetes/trafic_heure.php?date=' + selectedDate + '&heure1=' + debutIntervalle + '&heure2=' + finIntervalle)
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

                var marker = L.marker([capteur.latitude, capteur.longitude], { icon: L.icon({ iconUrl: iconUrl, iconSize: [taille_icon, taille_icon] }) }).addTo(feature_group_trafic_heure_bdd);
                marker.bindPopup(afficherPopupTraficHeure(capteur));

                if (capteur.total_vehicules > 0) {
                    var total = Math.round(1440 * capteur.total_vehicules / differenceMin);

                    var circleColor;
                    var circleRadius = 40 + Math.floor(total / 200);
                    
                    if (total >= 15000) {
                        circleColor = "darkred";
                    } else if (total >= 10000) {
                        circleColor = "red";
                    } else if (total >= 5000) {
                        circleColor = "orange";
                    } else if (total >= 2500) {
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
                    }).addTo(feature_group_trafic_heure_bdd);
                }

                fetch('./sources/requetes/sens_trafic_heure.php?id=' + capteur.id + '&date=' + selectedDate + '&heure1=' + debutIntervalle + '&heure2=' + finIntervalle)
                .then(response => response.json())
                .then(data => {
                var popupContent = afficherPopupTraficHeure(capteur);

                data.forEach(function (sens) {
                    popupContent += `<br>Total véhicules vers ${sens.nom} : ${sens.total_vehicules}`;
                });

                marker.getPopup().setContent(popupContent);
                })
                .catch(error => console.error(error));
                
                affichage();
            });                
            checkSumInitialLoaging++;
        })
        .catch(error => console.error(error));        
}

function removeBddTraficHeure() {
    feature_group_trafic_heure_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.Circle) {
            feature_group_trafic_heure_bdd.removeLayer(layer);
        }
    });
}

updateBddTraficHeure(); // affichage des capteurs de la bdd