

function numberToColorLeaflet(i) {
    //i est le numero de troncon, retrouver le numero de ligne avec le tableau TableauRelationCheminTronc
    var r = (i * 4) % 256;
    var g = (i * 7) % 256;
    var b = (i * 13) % 256;
    return [r,b,g];
}

var feature_group_ligne_bus = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

var feature_group_ligne_tram = L.featureGroup(

    {}

);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

              
function chemin_lignes(){
    try {            
        $.ajax({
            url: '../../../donnees/json/sv_chem_l.json',
            type: 'GET',
            dataType: "json",
            cache: false,
            success: function(data) {

            $.each(data, function(key, val) {
                //console.log("TEST : "+val.type+val.geometry.coordinates);
                // Récupération des valeurs de latitude et longitude
                // inverser les coordonnées de val.fields.geo_shape.coordinates
                    for (var i = 0; i < val.geo_shape.geometry.coordinates.length; i++) {
                        val.geo_shape.geometry.coordinates[i].reverse();
                    }
                    var T = numberToColorLeaflet(val.rs_sv_ligne_a);
                    var r = T[0];
                    var g = T[1];
                    var b = T[2];
                    //console.log(r+" ,"+g+","+ b);
                    val.geo_shape.geometry.coordinates = filtreCordonneesTab(val.geo_shape.geometry.coordinates);
                    if (val.vehicule == "BUS")
                    {
                        nb_lignes_bus++;
                        L.polyline( val.geo_shape.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.vehicule + "<br> nd : " + val.rg_sv_arret_p_nd + "<br> na : " + val.rg_sv_arret_p_na).addTo(feature_group_ligne_bus);
                    }
                        else if (val.vehicule == "TRAM")
                    {
                        nb_lignes_tram++;
                        L.polyline(val.geo_shape.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.vehicule + "<br> nd : " + val.rg_sv_arret_p_nd + "<br> na : " + val.rg_sv_arret_p_na).addTo(feature_group_ligne_tram);
                    }
                    affichage();

            });
        checkSumInitialLoaging++;
            
        }
    });
    }
    catch(e){
        console.log(e);
    }
}


function chemin_lignes_online()
{
    try {
        $.ajax({
            url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_tronc_l",
            type: 'GET',
            dataType: "json",
            cache: false,
            success: function(data) {
                $.each(data.features, function(key, val) {
                    for (var i = 0; i < val.geometry.coordinates.length; i++) {
                        val.geometry.coordinates[i].reverse();
                    }
                    if (val.properties.gid != NaN)
                    {
                        //console.log("gid : "+val.properties.gid)
                        fetch("./sources/requetes/convert_tronc_chemin.php?gid="+val.properties.gid)
                        .then(response => response.json())
                        .then(data => {
                            //console.log(data);
                        });
                    }


                    var T = numberToColorLeaflet(val.properties.gid);
                    var r = T[0];
                    var g = T[1];
                    var b = T[2];
                    val.geometry.coordinates = filtreCordonneesTab(val.geometry.coordinates);
                    if (val.properties.vehicule == "BUS")
                        L.polyline(val.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.properties.vehicule + "<br> nd : " + val.properties.rg_sv_arret_p_nd + "<br> na : " + val.properties.rg_sv_arret_p_na).addTo(feature_group_ligne_bus);
                    else if (val.properties.vehicule == "TRAM")
                        L.polyline(val.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.properties.vehicule + "<br> nd : " + val.properties.rg_sv_arret_p_nd + "<br> na : " + val.properties.rg_sv_arret_p_na).addTo(feature_group_ligne_tram);
                        

                });
            }
        });
    }
    catch(e){
        console.log(e);
    }
}

chemin_lignes();
//chemin_lignes_online();