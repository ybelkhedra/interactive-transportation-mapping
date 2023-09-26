L_NO_TOUCH = false;

L_DISABLE_3D = false;

var checkSumInitialLoaging = 0;

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

var baseURL = 'http://127.0.0.1:8000/api/v1/';

var taille_icon = 30;

var nb_bus = 0;
var nb_trams = 0;
var nb_parkings = 0;
var nb_velo = 0;
var nb_lignes_bus = 0;
var nb_lignes_tram = 0;
var nb_arrets_bus = 0;
var nb_arrets_tram = 0;
var pt_electriques = 0;
var pt_covoiturage = 0;
var pt_autopartage = 0;
var pt_freefloating = 0;

var feature_isochrone = L.featureGroup(
    {}
).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

navigator.geolocation.getCurrentPosition(function(location) {
    var lat = location.coords.latitude;
    var lon = location.coords.longitude;
    L.marker([lat, lon]).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);
}, function(error) {
    console.log(error);
}, { enableHighAccuracy: true });

function supprimer_isochrone()
{
    feature_isochrone.eachLayer(function (layer) {
            feature_isochrone.removeLayer(layer);
        });
}

function afficherIsochronePieton(latitude, longitude)
{

    // api : https://api.mapbox.com/isochrone/v1/mapbox/walking/-118.22258,33.99038?contours_minutes=5,10,15&contours_colors=6706ce,04e813,4286f4&polygons=true&access_token=pk.eyJ1IjoiY2hhcmxpZWZveGFscGhhIiwiYSI6ImNsZzZxN24yMzBmejEzaHBkZmttdm9teWwifQ.MwpyFqHOmuvcblOTnmgxZw
    var api_key = "pk.eyJ1IjoiY2hhcmxpZWZveGFscGhhIiwiYSI6ImNsZzZxN24yMzBmejEzaHBkZmttdm9teWwifQ.MwpyFqHOmuvcblOTnmgxZw";
    var url = "https://api.mapbox.com/isochrone/v1/mapbox/"+"walking"+"/"+longitude+","+latitude+"?contours_minutes=5,10,15&contours_colors=6706ce,04e813,4286f4&polygons=true&access_token="+api_key;
    $.ajax({
        url: url,
        type: 'GET',
        success: function(data) {
            $.each(data.features, async function(key, val) {
                var color = val.properties.color;
                var contour = val.properties.contour;
                var fill = val.properties.fill;
                var fill_opacity = val.properties.fillOpacity;
                var opacity = val.properties.opacity;
                var coordinates = val.geometry.coordinates[0];
                //inverser les coordonnées pour que le polygone soit bien affiché
                coordinates.forEach(function (item, index) {
                    coordinates[index] = item.reverse();
                });
                console.log(coordinates);
                var popup
                var polygon = L.polygon(coordinates, {color: color, opacity: opacity, fillOpacity: fill_opacity}).bindPopup("<br>Contour</br><br> Bleu foncé = 5 min</br><br> Vert = 10 min</br><br> Bleu clair = 15 min</br><br>Supprimer les isochrones : <button onclick='supprimer_isochrone()'>Supprimer</button>").addTo(feature_isochrone);
                console.log(polygon);
                
            });
        }
    });
}
function afficherIsochroneVelo(latitude, longitude)
{
    // api : https://api.mapbox.com/isochrone/v1/mapbox/walking/-118.22258,33.99038?contours_minutes=5,10,15&contours_colors=6706ce,04e813,4286f4&polygons=true&access_token=pk.eyJ1IjoiY2hhcmxpZWZveGFscGhhIiwiYSI6ImNsZzZxN24yMzBmejEzaHBkZmttdm9teWwifQ.MwpyFqHOmuvcblOTnmgxZw
    var api_key = "pk.eyJ1IjoiY2hhcmxpZWZveGFscGhhIiwiYSI6ImNsZzZxN24yMzBmejEzaHBkZmttdm9teWwifQ.MwpyFqHOmuvcblOTnmgxZw";
    var url = "https://api.mapbox.com/isochrone/v1/mapbox/"+"cycling"+"/"+longitude+","+latitude+"?contours_minutes=5,10,15&contours_colors=6706ce,04e813,4286f4&polygons=true&access_token="+api_key;
    console.log(url);
    $.ajax({
        url: url,
        type: 'GET',
        success: function(data) {
            console.log(data);
            $.each(data.features, async function(key, val) {
                var color = val.properties.color;
                var contour = val.properties.contour;
                var fill = val.properties.fill;
                var fill_opacity = val.properties.fillOpacity;
                var opacity = val.properties.opacity;
                var coordinates = val.geometry.coordinates[0];
                //inverser les coordonnées pour que le polygone soit bien affiché
                coordinates.forEach(function (item, index) {
                    coordinates[index] = item.reverse();
                });
                console.log(coordinates);
                var polygon = L.polygon(coordinates, {color: color, opacity: opacity, fillOpacity: fill_opacity}).bindPopup("<br>Contour</br><br> Bleu foncé = 5 min</br><br> Vert = 10 min</br><br> Bleu clair = 15 min</br><br>Supprimer les isochrones : <button onclick='supprimer_isochrone()'>Supprimer</button>").addTo(feature_isochrone);
                console.log(polygon);
            });
        }
    });
}