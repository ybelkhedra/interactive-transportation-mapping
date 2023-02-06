var feature_group_ea73ace9e1ad1740a59b9950b5af676b = L.featureGroup(

    {}

).addTo(map_5c3862ba13c7e615013e758f79b1f9bb);


function afficherInfospdc() {
    pdc = pdc_GLOBAL_COURANT;
    console.log(pdc);
    //recuperer l'elemetn class btn btn-primary
    var btn = document.getElementsByClassName('btn btn-primary');
    var popup = "<div class=popupInfoDetaillee>";
    popup += '<p>Horaire d\'ouverture : ' + pdc.properties.horaires + '</p>';
    popup += "<p>Nom commercial du reseau : "+pdc.properties.nom_enseigne+"</p>";
    popup += "<p>Adresse : "+pdc.properties.adresse+"</p>";
    if(pdc.properties.deux_roues) {
        popup += '<p>Accepte les deux roues : <span style="color:green;">Oui</span></p>';
    } else {
        popup += '<p>Accepte les deux roues : <span style="color:red;">Non</span></p>';
    }
    popup += "<p>Date de mise en service : "+pdc.properties.mise_en_service+"</p>";
    popup += "<p>Date de dernière modification de la base de donnée : "+pdc.properties.mdate+"</p>";
    popup += "</div>";
    //supprimer le bouton class btn btn-primary dans le popup
    
    //ajouter le popup à la suite du popup existant en supprimant le bouton voir les infos détaillées
    btn[0].parentNode.innerHTML += popup;
    btn[0].parentNode.removeChild(btn[0]);
}

var pdc_GLOBAL_COURANT = null;


function isInTab(val,liste_pdc)
{
    var res = false;
    $.each(liste_pdc, function(key, val2) {
        if (val2.puissance == val.puissance_nominale && val2.prise_ef == val.prise_type_ef && val2.prise_2 == val.prise_type_2 && val2.prise_combo == val.prise_type_combo && val2.prise_chademo == val.prise_type_chademo && val2.prise_3c == val.prise_type_3c && val2.prise_autre == val.prise_type_autre && val2.gratuit == val.gratuit) {
            res = true;
        }
    });
    return res;

}

function addPopuppdc(pdc, liste_pdc_type) {
    var st_irve_sta_p = pdc.properties.gid;
    //listes des prises de charge disponibles sur la station
    var liste_pdc = [];
    var tmp =[];
    $.each(liste_pdc_type.features, function(key, val) {
        if (val.properties.rs_st_irve_sta_p == st_irve_sta_p) {
            if (!isInTab(val.properties,liste_pdc)) {
                liste_pdc.push({"puissance":val.properties.puissance_nominale,"prise_ef":val.properties.prise_type_ef,"prise_2":val.properties.prise_type_2,"prise_combo":val.properties.prise_type_combo,"prise_chademo":val.properties.prise_type_chademo,"prise_3c":val.properties.prise_type_3c,"prise_autre":val.properties.prise_type_autre,"gratuit":val.properties.gratuit});
            }
        }
    });
    pdc_GLOBAL_COURANT = pdc;
    var popup = '<div class="popup">';
    popup += '<h3> Point de recharge electrique : ' + pdc.properties.libelle + '</h3>';
    popup += '<p>Opérateur : ' + pdc.properties.nom_operateur + '</p>';
    popup += '<p>Nombre de places de stationnement : ' + pdc.properties.nb_stationnement + '</p>';
    popup += '<p>Nombre de prises de charge : ' +  pdc.properties.nb_pdc + '</p>';
    if (liste_pdc.length > 0) {
        popup += '<p>Prises de charge disponibles : </p>';
        popup += '<ul>';
        $.each(liste_pdc, function(key, val) {
            // afficher la puissance de la prise et si elle est disponible ou non ainsi que le type de prise de charge
            popup += '<li>' + val.puissance + ' kW - ';
            popup += ' - Type(s) : ';
            if (val.prise_ef) {
                popup += 'E/F ';
            }
            if (val.prise_2) {
                popup += 'Type 2 ';
            }
            if (val.prise_combo) {
                popup += 'Combo / CCS ';
            }
            if (val.prise_chademo) {
                popup += 'Chademo ';
            }
            if (val.prise_3c) {
                popup += 'Type 3C ';
            }
            if (val.prise_autre) {
                popup += 'Autre ';
            }
            if (val.gratuit) {
                popup += ' - <span style="color:green;">Gratuit</span>';
            }
            popup += '</li>';

        });
        popup += '</ul>';
    }
    popup += '<button class="btn btn-primary" onclick="afficherInfospdc()">Voir les infos détaillées</button>';
    popup += '</div>';
    return popup;
}

   

$.ajax({
    url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_irve_sta_p',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
        $.ajax({
            url: 'https://data.bordeaux-metropole.fr/geojson?key=177BEEMTWZ&typename=st_irve_pdc_p',
            type: 'GET',
            dataType: 'json',
            success: function(data_2) {

                $.each(data.features, function(key, val) {
                    // Récupération des valeurs de latitude et longitude
                    var latitude = parseFloat(val.geometry.coordinates[1]);
                    var longitude = parseFloat(val.geometry.coordinates[0]);
                    if (isNaN(latitude) || isNaN(longitude) || !filtreCordonnees(latitude, longitude)) {
                        return;
                    }
                    // Ajout d'un marker sur la carte
                    L.marker([latitude, longitude], {icon: L.AwesomeMarkers.icon({icon: 'info-sign', markerColor: 'green'})}).bindPopup(addPopuppdc(val,data_2)).addTo(feature_group_ea73ace9e1ad1740a59b9950b5af676b);
                });

            }
        });
    }
});