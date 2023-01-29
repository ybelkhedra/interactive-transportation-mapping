

function numberToColorLeaflet(i) {
    var r = (i * 4) % 256;
    var g = (i * 7) % 256;
    var b = (i * 13) % 256;
    return [r,b,g];
}

var feature_group_2c8baec54a38159e19461b6f5698af3b = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

              
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
                        L.polyline( val.geo_shape.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.vehicule + "<br>" +val.libelle + "<br>" +val.sens + "<br> nd : " + val.rg_sv_arret_p_nd + "<br> na : " + val.rg_sv_arret_p_na).addTo(feature_group_2c8baec54a38159e19461b6f5698af3b);
                    else if (val.vehicule == "TRAM")
                        L.polyline(val.geo_shape.geometry.coordinates, {color: "rgb("+r+" ,"+g+","+ b+")"}).bindPopup(val.vehicule + "<br>" +val.libelle + "<br>" +val.sens + "<br> nd : " + val.rg_sv_arret_p_nd + "<br> na : " + val.rg_sv_arret_p_na).addTo(feature_group_2c8baec54a38159e19461b6f5698af3b);
                        

            });
            
        }
    });
    }
    catch(e){
        console.log(e);
    }
}

chemin_lignes();