
var feature_group_bus_temps_reel = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);

async function get_suivant(gid)
{
    var suivant = "inconnu"
    return await fetch('./sources/requetes/convert_gid_arret.php?gid='+gid)
    .then(response => response.json())
    .then(data => {
        suivant = data;
        return suivant;
    })
}

async function addPopupVehicule(vehicule){
    var en_cours = "inconnu"
    var suivant = "inconnu"
    return fetch('./sources/requetes/convert_gid_arret.php?gid='+vehicule.rs_sv_arret_p_actu)
    .then(response => response.json())
    .then(async data => {
        en_cours = data

        suivant = await get_suivant(vehicule.rs_sv_arret_p_suiv)

        var popup = "<b>Destination : </b>" + vehicule.terminus + "<br>";
        popup += "<b> Arret en cours : "+en_cours+"<br>";
        popup += "<b> Arret suivant : "+suivant+"<br>";


        popup += "<b> Type d'itinéraire : "+vehicule.statut+"<br>";
        popup += "<b>Ponctualite : </b>" + vehicule.etat + " de "+ vehicule.retard +" secondes<br>";
        if (vehicule.arret)
        {
            popup += "<b>Le vehicule est actuellement arrêté à un arrêt<br>";
        }
        if (vehicule.pmr)
        {
            popup += "<b>Le vehicule est équipé d'accès PMR<br>";
        }
        popup += "<b>Vitesse du vehicule : "+vehicule.vitesse+"<br>";

        popup += "<b>Date de mise à jour des données : "+vehicule.mdate+"<br>";

        return popup;
    })
}


async function updateMarkersVehicule() {

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
      $.each(data.features, async function(key, val) {
        if (val.properties.localise) {//(val.geometry && val.geometry.coordinates) {
        // création d'un marqueur avec l'icône spécifiée et ajout de la fenêtre contextuelle avec les informations sur le bus ou le tram
            if (filtreCordonnees(val.geometry.coordinates[1], val.geometry.coordinates[0]))
            {
                if (val.properties.vehicule == "BUS")
                {
                    var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'bus', prefix: 'fa', markerColor: 'red'})}).bindPopup(await addPopupVehicule(val.properties));
                }
                else if (val.properties.vehicule == "TRAM_LONG" || val.properties.vehicule == "TRAM_COURT")
                {
                    var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'subway', prefix: 'fa', markerColor: 'blue'})}).bindPopup(await addPopupVehicule(val.properties));
                }
                else if (val.properties.vehicule == "TPMR" || val.properties.vehicule == "NAVETTE" || val.properties.vehicule == "VSR" || val.properties.vehicule == "VSM" || val.properties.vehicule == "VSA" || val.properties.vehicule == "INCONNU")
                {
                    var marker = L.marker([val.geometry.coordinates[1], val.geometry.coordinates[0]], {icon: L.AwesomeMarkers.icon({icon: 'car', prefix: 'fa', markerColor: 'grey'})}).bindPopup(await addPopupVehicule(val.properties));
                }
                    // ajout du marqueur à la carte
                marker.addTo(feature_group_bus_temps_reel);
                success++;
            }
        }
        else {
            error++;
        }
        });
        }}
    });
    }
    catch (e) {
        console.log(e);
    }
}
updateMarkersVehicule();
setInterval(updateMarkersVehicule, 10000);