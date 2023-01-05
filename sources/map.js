            L_NO_TOUCH = false;

            L_DISABLE_3D = false;

    

    

            var map_5c3862ba13c7e615013e758f79b1f9bb = L.map(

                "map_5c3862ba13c7e615013e758f79b1f9bb",

                {

                    center: [44.79517, -0.603537],

                    crs: L.CRS.EPSG3857,

                    //maxBounds: [[44.79517, -0.603537], [44.79517, -0.603537]],

                    zoom: 14,

                    zoomControl: true,

                    preferCanvas: false,

                }

            );



            



        

    

            var tile_layer_8135ca89c9bddfd00acf4c435b16801c = L.tileLayer(

                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",

                {"attribution": "Data by \u0026copy; \u003ca href=\"http://openstreetmap.org\"\u003eOpenStreetMap\u003c/a\u003e, under \u003ca href=\"http://www.openstreetmap.org/copyright\"\u003eODbL\u003c/a\u003e.", "detectRetina": false, "maxNativeZoom": 18, "maxZoom": 18, "minZoom": 14, "noWrap": false, "opacity": 1, "subdomains": "abc", "tms": false}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

 
            var layer_control_643cdab5b83b581cb10d63d05a5a00f0 = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


            var feature_group_9eca2e6aae733fb41e9c12f6a296531b = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


        

            $.ajax({
                url: '../donnees/json/parking_cord.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
                        var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
                        if (isNaN(latitude) || isNaN(longitude)) {
                            return;
                        }
                        // Ajout d'un marker sur la carte
                        //console.log(latitude, longitude);
                        L.marker([latitude, longitude]).addTo(feature_group_9eca2e6aae733fb41e9c12f6a296531b);
                    });
                }
            });

    

            var feature_group_ea73ace9e1ad1740a59b9950b5af676b = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

               

            $.ajax({
                url: '../donnees/json/point_de_charge_cord.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
                        var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
                        if (isNaN(latitude) || isNaN(longitude)) {
                            return;
                        }
                        // Ajout d'un marker sur la carte
                        L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'green'})}).addTo(feature_group_ea73ace9e1ad1740a59b9950b5af676b);
                    });
                }
            });
    

    

            var feature_group_cf5c634cb92629a9a7265699e3b14613 = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

        

    
            $.ajax({
                url: '../donnees/json/covoiturage_cord.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
                        var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
                        if (isNaN(latitude) || isNaN(longitude)) {
                            return;
                        }
                        // Ajout d'un marker sur la carte
                        L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'blue'})}).addTo(feature_group_cf5c634cb92629a9a7265699e3b14613);
                    });
                }
            });


            var feature_group_3c3d8f447cafac6c7a871b7a2bc74795 = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


            $.ajax({
                url: '../donnees/json/autopartage_cord.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
                        var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
                        if (isNaN(latitude) || isNaN(longitude)) {
                            return;
                        }
                        // Ajout d'un marker sur la carte
                        L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'orange'})}).addTo(feature_group_3c3d8f447cafac6c7a871b7a2bc74795);
                    });
                }
            });


            var feature_group_2c8baec54a38159e19461b6f5698af3b = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


            $.ajax({
                url: '../donnees/json/chemins_lignes.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        //inverser les coordonnées de val.fields.geo_shape.coordinates
                            for (var i = 0; i < val.fields.geo_shape.coordinates.length; i++) {
                                val.fields.geo_shape.coordinates[i].reverse();
                            }
                            if (val.fields.vehicule == "BUS")
                                L.polyline(val.fields.geo_shape.coordinates, {color: 'blue'}).addTo(feature_group_2c8baec54a38159e19461b6f5698af3b);
                            else if (val.fields.vehicule == "TRAM")
                                L.polyline(val.fields.geo_shape.coordinates, {color: 'red'}).addTo(feature_group_2c8baec54a38159e19461b6f5698af3b);
                    });
                }
            });



            var feature_group_arrets_bus = L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


            $.ajax({
                url: '../donnees/json/arrets_bus.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $.each(data, function(key, val) {
                        // Récupération des valeurs de latitude et longitude
                        var latitude = parseFloat(val.fields.geo_shape.coordinates[1]);
                        var longitude = parseFloat(val.fields.geo_shape.coordinates[0]);
                        if (isNaN(latitude) || isNaN(longitude)) {
                            return;
                        }
                        // Ajout d'un marker sur la carte
                        if (val.fields.vehicule == "BUS")
                            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'grey'})}).addTo(feature_group_arrets_bus);
                        else if (val.fields.vehicule == "TRAM")
                            L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'black'})}).addTo(feature_group_arrets_bus);
                    });
                }
            });




            function updateMarkersVehicule() {


                try {
                // récupération des données de position de bus et de tram en utilisant l'URL du WebService GeoJSON
                
                $.ajax({
                    url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=sv_vehic_p",
                    dataType: "json",
                    cache: false,
                    success: function(data) {
                
                {
                  // suppression des marqueurs existants de la carte
                  feature_group_bus_temps_reel.eachLayer(function (layer) {
                    if (layer instanceof L.Marker) {
                        feature_group_bus_temps_reel.removeLayer(layer);
                    }
                  });
                    var success = 0;
                    var error = 0;
                  // ajout de nouveaux marqueurs pour chaque élément de données de position de bus et de tram
                  $.each(data.features, function(key, val) {
                    if (val.properties.localise) {//(val.geometry && val.geometry.coordinates) {
                    // création d'un marqueur avec l'icône spécifiée et ajout de la fenêtre contextuelle avec les informations sur le bus ou le tram
                        if (val.properties.vehicule == "BUS")
                        {
                            var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'bus', prefix: 'fa', markerColor: 'red'})}).bindPopup("TYPE : " + val.properties.vehicule + " DESTINATION : " + val.properties.terminus);
                        }
                        else
                        {
                            var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'subway', prefix: 'fa', markerColor: 'blue'})}).bindPopup("TYPE : " + val.properties.vehicule + " DESTINATION : " + val.properties.terminus);
                        }
                            // ajout du marqueur à la carte
                        marker.addTo(feature_group_bus_temps_reel);
                        success++;
                    }
                    else {
                        error++;
                    }
                    });
                    console.log("success : " + success + " error : " + error + "données datant du : " + data.features[0].properties.mdate);
                }
                    }
                });
                }
                catch (e) {
                    console.log(e);
                }
            }
    
         
    
            updateMarkersVehicule();
    
              setInterval(
                function() {
                    updateMarkersVehicule();
                  console.log("mise à jour des marqueurs");
                }, 10000);
    


            var feature_group_traffic= L.featureGroup(

                {}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);




        function updateMarkersTraffic() {


                    try {
                    // récupération des données de position de bus et de tram en utilisant l'URL du WebService GeoJSON
                    
                    $.ajax({
                        url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=ci_trafi_l",
                        dataType: "json",
                        cache: false,
                        success: function(data) {
                    
                    {
                      // suppression des marqueurs existants de la carte
                      feature_group_traffic.eachLayer(function (layer) {
                        if (layer instanceof L.Marker) {
                            feature_group_traffic.removeLayer(layer);
                        }
                      });
                      // ajout de ligne de traffic chargé ou fluide
                      $.each(data.features, function(key, val) {
                        //inversé les coordonnées val.features.geometry.coordinates
                        for (var i = 0; i < val.geometry.coordinates.length; i++) {
                                val.geometry.coordinates[i].reverse();
                        }
                        if (val.properties.etat == "FLUIDE") {
                            var polyline = L.polyline(val.geometry.coordinates, {color: 'green'}).addTo(feature_group_traffic);
                    }
                        else {
                            var polyline = L.polyline(val.geometry.coordinates, {color: 'red'}).addTo(feature_group_traffic);
                        }
                        });
                    }

                        }
                    });
                    }   
                    catch (e) {
                        console.log(e);
                    }
                }

                




                updateMarkersTraffic();

                    setInterval(
                    function() {
                        updateMarkersTraffic();
                        console.log("mise à jour du traffic");
                    }, 20000);







                var feature_group_2c8baec54a38159e19461b6f5698af3b = L.featureGroup(

                    {}
    
                ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

                var feature_group_bus_temps_reel = L.featureGroup(

                    {}
    
                ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

    

            var layer_control_643cdab5b83b581cb10d63d05a5a00f0 = {

                base_layers : {

                    "openstreetmap" : tile_layer_8135ca89c9bddfd00acf4c435b16801c,

                },

                overlays :  {

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

            //ajouter un layer "bus en temps reel à la carte"

            

            L.control.layers(

                layer_control_643cdab5b83b581cb10d63d05a5a00f0.base_layers,

                layer_control_643cdab5b83b581cb10d63d05a5a00f0.overlays,

                {"autoZIndex": true, "collapsed": true, "position": "topright"}

            ).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

