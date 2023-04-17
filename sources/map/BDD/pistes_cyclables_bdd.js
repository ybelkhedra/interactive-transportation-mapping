var feature_group_pistes_cyclables_bdd = L.featureGroup( // création d'un groupe de marqueurs
    {}
);//.addTo(map_5c3862ba13c7e615013e758f79b1f9bb);
 // ajout du groupe de marqueurs à la carte

function afficherPopupPistesCyclables(piste_cyclable)
{
    var type_piste = "Type piste : " + piste_cyclable.type_piste;
    var info_complementaires = "Informations complémentaires : " + piste_cyclable.info_complementaires;
    
    var popup = type_piste + "<br>" + info_complementaires;
    return popup;
}

function afficherPopupPistesCyclablesAPI(piste_cyclable)
{
// Type d'aménagement : 
// Liste des valeurs possibles : 
// RACCORD : Raccord sur filaire voie
// AIRE_PIETONNE : Aire piétonne
// ALLEES_DE_PARCS : Allées de parc
// BANDES_CYCL : Bande cyclable unilatérale (d'un coté ou de l'autre)
// COULOIRS_BUS : Couloir bus
// BANDES_CYCL_DBLE_SENS : Bandes cyclables bilatérales
// DBLE_SENS_CYCL : Voie à double sens cyclable (en cohabitation avec les autres véhicules)
// PIST_CYCL_CONTRESENS : Piste cyclable unilatérale et unidirectionnelle à contre sens de la circulation générale
// DBLE_SENS_PIST_CYCL : Piste cyclable bidirectionnelle
// PISTES_CYCL : Piste cyclable unidirectionnelle
// VOIE_VERTE : Voie verte
// ZONE_RENCONTRE : Zone de rencontre
// PASSAGE_PIETONS : Passage piétons
// TRAVERSEE : Traversée
// ZONE_30_DBLE_SENS : Zone 30 double sens
// ZONE_30_SENS_UNIQUE : Zone 30 sens unique

    var type_piste = "Type piste : ";
    if (piste_cyclable.typamena == "RACCORD") {
        type_piste += "Raccord sur filaire voie ";
    }
    else if (piste_cyclable.typamena == "AIRE_PIETONNE") {
        type_piste += "Aire piétonne ";
    }
    else if (piste_cyclable.typamena == "ALLEES_DE_PARCS") {
        type_piste += "Allées de parc ";
    }
    else if (piste_cyclable.typamena == "BANDES_CYCL")
    {
        type_piste += "Bande cyclable unilatérale (d'un coté ou de l'autre) ";
    }
    else if (piste_cyclable.typamena == "COULOIRS_BUS")
    {
        type_piste += "Couloir bus ";
    }
    else if (piste_cyclable.typamena == "BANDES_CYCL_DBLE_SENS")
    {
        type_piste += "Bandes cyclables bilatérales ";
    }
    else if (piste_cyclable.typamena == "DBLE_SENS_CYCL")
    {
        type_piste += "Voie à double sens cyclable (en cohabitation avec les autres véhicules) ";
    }
    else if (piste_cyclable.typamena == "PIST_CYCL_CONTRESENS")
    {
        type_piste += "Piste cyclable unilatérale et unidirectionnelle à contre sens de la circulation générale ";
    }
    else if (piste_cyclable.typamena == "DBLE_SENS_PIST_CYCL")
    {
        type_piste += "Piste cyclable bidirectionnelle ";
    }
    else if (piste_cyclable.typamena == "PISTES_CYCL")
    {
        type_piste += "Piste cyclable unidirectionnelle ";
    }
    else if (type_piste.typamena == "VOIE_VERTE")
    {
        type_piste += "Voie verte ";
    }
    else if (type_piste.typamena == "ZONE_RENCONTRE")
    {
        type_piste += "Zone de rencontre ";
    }
    else if (type_piste.typamena == "PASSAGE_PIETONS")
    {
        type_piste += "Passage piétons ";
    }
    else if (type_piste.typamena == "ZONE_30_DBLE_SENS")
    {
        type_piste += "Zone 30 double sens ";
    }
    else if (type_piste.typamena == "ZONE_30_SENS_UNIQUE")
    {
        type_piste += "Zone 30 sens unique ";
    }
    return type_piste;
}


function updateBddPisteCyclables(){
    // suppression des marqueurs existants de la carte
    feature_group_pistes_cyclables_bdd.eachLayer(function (layer) {
        if (layer instanceof L.Marker) {
            feature_group_pistes_cyclables_bdd.removeLayer(layer);
        }
    });
    //récupération des données de la bdd
    fetch('./sources/requetes/pistes_cyclables.php')
    .then(response => response.json())
    .then(data => {
        data.forEach(function(piste_cyclable) { // pour chaque piste cyclable
            if (piste_cyclable.coordonnees.length == 1) {// si le piste cyclable n'a qu'une seule coordonnée
                var marker = L.marker([piste_cyclable.coordonnees[0].latitude, piste_cyclable.coordonnees[0].longitude]).addTo(feature_group_pistes_cyclables_bdd); // création du marqueur
                marker.bindPopup(afficherPopupPistesCyclables(piste_cyclable)); // ajout du popup
                //marker.setStyle({color: 'red'}); // on definie la couleur du marker
            }
            else if (piste_cyclable.coordonnees.length > 1) { // si la piste cyclable a plusieurs coordonnées


                var latlngs = []; // création d'un tableau vide 
                piste_cyclable.coordonnees.forEach(function(coordonnee) { // pour chaque coordonnée
                    latlngs.push([coordonnee.latitude, coordonnee.longitude]); // ajout des coordonnées au tableau latlngs
                });
                var polyline = L.polyline(latlngs).addTo(feature_group_pistes_cyclables_bdd); // création de la polyline
                polyline.setStyle({color: 'purple', weight: 5}); // changement de la couleur de la polyline
                polyline.bindPopup(afficherPopupPistesCyclables(piste_cyclable)); // ajout du popup
                affichage();
            }
        });        
    })
    .catch(error => console.error(error));


    $.ajax({
        url: "https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=fv_trvel_l",
        dataType: "json",
        cache: false,
        success: function(data) {
        {
        // suppression des marqueurs existants de la carte
        feature_group_pistes_cyclables_bdd.eachLayer(function (layer) {
            if (layer instanceof L.Marker) {
                feature_group_pistes_cyclables_bdd.removeLayer(layer);
            }
            if (layer instanceof L.Polyline) {
                feature_group_pistes_cyclables_bdd.removeLayer(layer);
            }
        });
        $.each(data.features, function(key, val) {
            //inversé les coordonnées val.features.geometry.coordinates
            for (var i = 0; i < val.geometry.coordinates.length; i++) {
                    val.geometry.coordinates[i].reverse();
            }
                var polyline = L.polyline(val.geometry.coordinates, {color: 'orange'}).addTo(feature_group_pistes_cyclables_bdd);
                polyline.bindPopup(afficherPopupPistesCyclablesAPI(val.properties));
            });
        }

        checkSumInitialLoaging++;
        }
        });
}

updateBddPisteCyclables();