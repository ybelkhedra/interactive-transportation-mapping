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