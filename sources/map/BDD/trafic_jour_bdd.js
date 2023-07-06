var feature_group_trafic_jour_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte


function afficherPopupTraficJour(capteur)
{
    var nom = "Nom : " + capteur.nom;
    var type = "Matériel Utilisé : " + capteur.type_capteur;
    
    var popup = nom + "<br>" + type + "<br> Trafic par jour: " + document.getElementById("datepicker1").value;
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


function updateBddTraficJour(){
    var selectedDate = document.getElementById("datepicker1").value;
    if (selectedDate === "") {
        return;
    }

    // suppression des marqueurs existants de la carte
    feature_group_trafic_jour_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.Circle) {
            feature_group_trafic_jour_bdd.removeLayer(layer);
        }
        });
    //récupération des données de la bdd
    fetch('./sources/requetes/trafic_jour.php?date=' + selectedDate)
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

            var marker = L.marker([capteur.latitude, capteur.longitude], { icon: L.icon({ iconUrl: iconUrl, iconSize: [taille_icon, taille_icon] }) }).addTo(feature_group_trafic_jour_bdd);
            marker.bindPopup(afficherPopupTraficJour(capteur));
            
            if (capteur.total_vehicules > 0) {
                var circleColor;
                var circleRadius = 40 + Math.floor(capteur.total_vehicules / 200);
                
                if (capteur.total_vehicules >= 15000) {
                    circleColor = "darkred";
                } else if (capteur.total_vehicules >= 10000) {
                    circleColor = "red";
                } else if (capteur.total_vehicules >= 5000) {
                    circleColor = "orange";
                } else if (capteur.total_vehicules >= 2500) {
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
                }).addTo(feature_group_trafic_jour_bdd);
            }

            fetch('./sources/requetes/sens_trafic_jour.php?id=' + capteur.id + '&date=' + selectedDate)
            .then(response => response.json())
            .then(data => {
            var popupContent = afficherPopupTraficJour(capteur);

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

updateBddTraficJour(); // affichage des capteurs de la bdd