var feature_group_arrets_cars_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb); // ajout du groupe de marqueurs à la carte



function afficherPopupArretsBus(e) { 
    var nom = "Nom : " + e.stop_name;
    var lignes_desservis = "Lignes desservies : ";
    for (var i = 0; i < e.ligne_car.length; i++) {
        lignes_desservis += e.ligne_car[i][0] + " " + e.ligne_car[i][1] + "<br>";
    }
  
    var popup = nom +  "<br>" + lignes_desservis + "<br>" ;
    popup += "<button id='arret_car' onclick='afficherIsochronePieton("+e.stop_lat+","+e.stop_lon+")'>Afficher l'isochrone pieton</button>";
    popup += "<button id='arret_car' onclick='afficherIsochroneVelo("+e.stop_lat+","+e.stop_lon+")'>Afficher l'isochrone velo</button>";
 
    return popup;
}

function updateBddArretsBus() { 
    // suppression des marqueurs existants de la carte
    feature_group_arrets_bus.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_arrets_bus.removeLayer(layer);
        }
        });

    //récupération des données de la bdd
    fetch('./sources/requetes/arrets_cars.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(arret) { // pour chaque arret
            if (arret.ligne_car.length > 0)
            { 
                nb_arrets_bus++;
                var marker = L.marker([arret.stop_lat, arret.stop_lon], {icon : bus_station_Icon}).addTo(feature_group_arrets_cars_bdd); // création du marqueur
                marker.bindPopup(afficherPopupArretsBus(arret)); // ajout du popup
                affichage();
            }
        });
        checkSumInitialLoaging++;
        
    })
    .catch(error => console.error(error));
}

updateBddArretsBus();