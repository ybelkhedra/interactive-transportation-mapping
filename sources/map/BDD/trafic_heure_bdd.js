var feature_group_trafic_heure_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupTraficHeure(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    // var e_s = "Entrée/Sortie total : " + capteur.entree_sortie;
    
    var popup = nom + "<br>" + type + "<br> Trafic par heure: " 
    + document.getElementById("datepicker1").value + " entre "
    + document.getElementById("timepicker1").value + " et " 
    + document.getElementById("timepicker2").value;

    popup += "<br>Total Véhicules : " + capteur.total_vehicules;
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

    feature_group_trafic_jour_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.Circle) {
            feature_group_trafic_jour_bdd.removeLayer(layer);
        }
    });
    
    fetch('./sources/requetes/trafic_heure.php?date=' + selectedDate + '&heure1=' + debut + '&heure2=' + fin)
        .then(response => response.json())
        .then(data => {
            console.log(data);
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
                
                affichage();
            });                
            checkSumInitialLoaging++;
        })
        .catch(error => console.error(error));

    // var debut = document.getElementById("timepicker1").value;
    // var fin = document.getElementById("timepicker2").value;
    // var periode = document.getElementById('periode').value;
    // var estMin = document.getElementById('choix_min').checked;
    // var estHeur = document.getElementById('choix_heur').checked;

    // // Fonction pour exécuter la requête avec les paramètres donnés
    // function executeRequete(debIntervalle, finIntervalle) {
    //     console.log("heure1= " + debIntervalle + "   heure2= " + finIntervalle);

    //     feature_group_trafic_jour_bdd.eachLayer(function (layer) {
    //         if (layer instanceof L.Marker || layer instanceof L.Circle) {
    //             feature_group_trafic_jour_bdd.removeLayer(layer);
    //         }
    //     });
        
    //     fetch('./sources/requetes/trafic_heure.php?date=' + selectedDate + '&heure1=' + debIntervalle + '&heure2=' + finIntervalle)
    //         .then(response => response.json())
    //         .then(data => {
    //             console.log(data);
    //             data.forEach(function(capteur) {
    //                 var iconUrl = './sources/icons/capteur.png';

    //                 if (capteur.type_capteur.includes("radar")) {
    //                     iconUrl = './sources/icons/radar.png';
    //                 } else if (capteur.type_capteur.includes("caméra")) {
    //                     iconUrl = './sources/icons/camera.png';
    //                 } else if (capteur.type_capteur.includes("tube")) {
    //                     iconUrl = './sources/icons/tube.png';
    //                 }

    //                 var marker = L.marker([capteur.latitude, capteur.longitude], { icon: L.icon({ iconUrl: iconUrl, iconSize: [taille_icon, taille_icon] }) }).addTo(feature_group_trafic_heure_bdd);
    //                 marker.bindPopup(afficherPopupTraficHeure(capteur));
                    
    //                 affichage();
    //             });                
    //             checkSumInitialLoaging++;
    //         })
    //         .catch(error => console.error(error));
    // }

    // // Calcul des intervalles de temps et exécution de la requête
    // var debIntervalle = debut;
    // var finIntervalle = "";

    // if (estHeur) {
    //     var periodeHeure = parseInt(periode);
    //     var heuresDebut = parseInt(debut.split(':')[0]);
    //     var heuresFin = parseInt(fin.split(':')[0]);
    //     var diffHeures = heuresFin - heuresDebut;
    
    //     for (var i = 0; i < diffHeures; i += periodeHeure) {
    //         var heures = heuresDebut + i;
    //         var heuresSuivantes = heuresDebut + i + periodeHeure;
    
    //         if (heuresSuivantes <= heuresFin) {
    //             finIntervalle = heuresSuivantes.toString().padStart(2, '0') + ":" + fin.split(':')[1];
    //             executeRequete(debIntervalle, finIntervalle);
    //             debIntervalle = finIntervalle;
    //         }
    //     }
    // } else if (estMin) {
    //     var periodeMinutes = parseInt(periode);
    //     var heuresDebut = parseInt(debut.split(':')[0]);
    //     var minutesDebut = parseInt(debut.split(':')[1]);
    //     var heuresFin = parseInt(fin.split(':')[0]);
    //     var minutesFin = parseInt(fin.split(':')[1]);
    //     var diffHeures = heuresFin - heuresDebut;
    //     var diffMinutes = minutesFin - minutesDebut;
    
    //     for (var j = 0; j <= diffHeures; j++) {
    //         var heures = heuresDebut + j;
    //         var heuresSuivantes = heuresDebut + j + 1;
    //         var limiteMinutes = (heuresSuivantes < heuresFin) ? 60 : (minutesFin + 1) % 60;
    
    //         for (var k = 0; k < diffMinutes; k += periodeMinutes) {
    //             var minutes = minutesDebut + k;
    
    //             if (heures < heuresFin || (heures === heuresFin && minutes < limiteMinutes)) {
    //                 var minutesSuivantes = minutesDebut + k + periodeMinutes;
    
    //                 if (minutesSuivantes < 60) {
    //                     finIntervalle = heures.toString().padStart(2, '0') + ":" + minutesSuivantes.toString().padStart(2, '0');
    //                 } else {
    //                     heuresSuivantes++;
    //                     finIntervalle = heuresSuivantes.toString().padStart(2, '0') + ":00";
    //                 }
    
    //                 executeRequete(debIntervalle, finIntervalle);
    //                 debIntervalle = finIntervalle;
    //             }
    //         }
    //     }
    // }          
}

updateBddTraficHeure(); // affichage des capteurs de la bdd