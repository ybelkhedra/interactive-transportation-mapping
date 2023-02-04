var layer_control_643cdab5b83b581cb10d63d05a5a00f0 = {

    base_layers : {

        "openstreetmap" : tile_layer_8135ca89c9bddfd00acf4c435b16801c,

    },

    overlays :  {
        "Points de stationnement velo (BDD)" : feature_group_pts_stationnement_velo_bdd,

        "Pistes cyclables (BDD)" : feature_group_pistes_cyclables_bdd,

        "Lignes de car (BDD)" : feature_group_lignes_cars_bdd,

        "Lignes de transport TBM (BDD)" : feature_group_lignes_bdd,

        "Arrets de bus/tram (BDD)" : feature_group_arrets_perso_bdd,

        "Gare TER" : feature_group_gares_ter_bdd,

        "Points de freefloating" : feature_group_freefloating,

        "Points de covoiturages (BDD)" : feature_group_covoiturage_bdd,

        "Points de charges (BDD)" : feature_group_pdc_bdd,

        "Parking (BDD)" : feature_group_parkings_bdd,

        "Parking" : feature_group_9eca2e6aae733fb41e9c12f6a296531b,

        "Points de charge" : feature_group_ea73ace9e1ad1740a59b9950b5af676b,

        "Covoiturage" : feature_group_cf5c634cb92629a9a7265699e3b14613,

        "Autopartage" : feature_group_3c3d8f447cafac6c7a871b7a2bc74795,

        "Lignes de transport" : feature_group_2c8baec54a38159e19461b6f5698af3b,

        "Bus en temps reel" : feature_group_bus_temps_reel,

        "Arrets de bus" : feature_group_arrets_bus,

        "Etat du traffic" : feature_group_traffic,
    },

};

L.control.layers(

    layer_control_643cdab5b83b581cb10d63d05a5a00f0.base_layers,

    layer_control_643cdab5b83b581cb10d63d05a5a00f0.overlays,

    {"autoZIndex": true, "collapsed": true, "position": "topright"}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function chargement(bool) {
    return new Promise(function(resolve, reject) {
        var loader = document.getElementsByClassName("container")[0];
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