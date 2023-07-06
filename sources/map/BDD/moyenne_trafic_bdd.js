var feature_group_moyenne_trafic_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupMoyenneTrafic(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    
    var popup = nom + "<br>" + type + "<br> Moyenne de trafic entre " + document.getElementById("datepicker1").value + " et " + document.getElementById("datepicker2").value;
    popup += "<br>Total Véhicules : " + capteur.moyenne_vehicules;
    popup += "<br>EDPM/Trottinette : " + capteur.moyenne_vehicules_EDPM_Trottinette;
    popup += "<br>VELO : " + capteur.moyenne_vehicules_VELO;
    popup += "<br>MOTO : " + capteur.moyenne_vehicules_MOTO;
    popup += "<br>Deux roues/2RM/2R : " + capteur.moyenne_vehicules_Deux_roues_2RM_2R;
    popup += "<br>VL : " + capteur.moyenne_vehicules_VL;
    popup += "<br>BUS : " + capteur.moyenne_vehicules_BUS;
    popup += "<br>PL : " + capteur.moyenne_vehicules_PL;
    popup += "<br>PL_1 : " + capteur.moyenne_vehicules_PL_1;
    popup += "<br>PL_2 : " + capteur.moyenne_vehicules_PL_2;
    popup += "<br>PL/BUS : " + capteur.moyenne_vehicules_PL_BUS;
    popup += "<br>UT : " + capteur.moyenne_vehicules_UT;
    popup += "<br>PT : " + capteur.moyenne_vehicules_PT;

    return popup;
}


function updateBddMoyenneTrafic(){
    var selectedDate1 = document.getElementById("datepicker1").value;
    var selectedDate2 = document.getElementById("datepicker2").value;
    if (selectedDate1 === "" || selectedDate2 === "") {
        console.log("Please select a date");
        return;
    }

    console.log("date1: " + selectedDate1 + "    date2: " + selectedDate2);

    // suppression des marqueurs existants de la carte
    feature_group_moyenne_trafic_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_moyenne_trafic_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/moyenne_trafic.php?date1=' + selectedDate1 + '&date2=' + selectedDate2)
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

            var marker = L.marker([capteur.latitude, capteur.longitude], { icon: L.icon({ iconUrl: iconUrl, iconSize: [taille_icon, taille_icon] }) }).addTo(feature_group_moyenne_trafic_bdd);
            marker.bindPopup(afficherPopupMoyenneTrafic(capteur));
            
            if (capteur.moyenne_vehicules > 0) {
                var circleColor;
                var circleRadius = 40 + Math.floor(capteur.moyenne_vehicules / 200);
                
                if (capteur.moyenne_vehicules >= 15000) {
                    circleColor = "darkred";
                } else if (capteur.moyenne_vehicules >= 10000) {
                    circleColor = "red";
                } else if (capteur.moyenne_vehicules >= 5000) {
                    circleColor = "orange";
                } else if (capteur.moyenne_vehicules >= 2500) {
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
                }).addTo(feature_group_moyenne_trafic_bdd);
            }

            fetch('./sources/requetes/sens_moyenne_trafic.php?id=' + capteur.id + '&date1=' + selectedDate1 + '&date2=' + selectedDate2)
            .then(response => response.json())
            .then(data => {
            var popupContent = afficherPopupMoyenneTrafic(capteur);

            data.forEach(function (sens) {
                popupContent += `<br>Moyenne de véhicules vers ${sens.nom} : ${sens.moyenne_vehicules}`;
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

updateBddMoyenneTrafic(); // affichage des capteurs de la bdd