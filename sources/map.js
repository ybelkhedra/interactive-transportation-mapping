var layer_control_643cdab5b83b581cb10d63d05a5a00f0 = {

    base_layers : {

        "openstreetmap" : tile_layer_8135ca89c9bddfd00acf4c435b16801c,

    },

    overlays :  {

        "Parking relais" : feature_group_parkings_relais,//ok

        "Stations Vcube" : feature_group_vcube,//ok

        "Points de stationnement velo" : feature_group_pts_stationnement_velo_bdd,//ok

        "Arrets cars" : feature_group_arrets_cars_bdd,//ok

        "Pistes cyclables" : feature_group_pistes_cyclables_bdd,//ok

        "Lignes de car" : feature_group_lignes_car_bdd,//ok

        "Gare TER" : feature_group_gares_ter_bdd,//ok

        "Points de freefloating" : feature_group_freefloating,//ok

        "Points de freefloating bdd" : feature_group_freefloating_bdd,//ok

        "Capteurs bdd" : feature_group_capteurs_bdd,

        "Parking" : feature_group_parkings,//ok

        "Points de charge" : feature_group_pdc,//ok

        "Covoiturage" : feature_group_covoiturages,//ok

        "Autopartage" : feature_group_autopartages,//ok

        "Lignes de BUS" : feature_group_ligne_bus,//ok

        "Lignes de TRAM" : feature_group_ligne_tram,//ok

        "Bus en temps reel" : feature_group_bus_temps_reel,//ok

        "Tram en temps reel" : feature_group_tram_temps_reel,//ok

        "Arrets de bus" : feature_group_arrets_bus,//ok

        "Arrets de tram" : feature_group_arrets_tram,//ok

        "Etat du traffic" : feature_group_traffic,//ok

    },

};

L.control.layers(

    layer_control_643cdab5b83b581cb10d63d05a5a00f0.base_layers,

    layer_control_643cdab5b83b581cb10d63d05a5a00f0.overlays,

    {"autoZIndex": true, "collapsed": true, "position": "topright"}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function chargement(bool) {
    return new Promise(function(resolve, reject) {
        var loader = document.getElementsByClassName("chargementText")[0];
        // dans loader ajouter : "Affichage des données en cours..."
        loader.innerHTML = "<div class='affichage_loading'>Affichage des données en cours...</div>";
        if(!loader){
            console.log("Loading element not found");
            reject();
        }
        if (bool) {
            loader.style.display = "block";
            setTimeout(function() {
                resolve();
            }, 2000);
        }
        else {
            loader.style.display = "none";
            resolve();
        }
    });
}