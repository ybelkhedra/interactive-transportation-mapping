

function affichage()
{
var nbTram = document.getElementsByClassName("nbTram");
    nbTram[0].innerHTML = "Nombre de Tram en temps reel sur le campus : " + nb_trams;

var nbBus = document.getElementsByClassName("nbBus");
    nbBus[0].innerHTML = "Nombre de Bus en temps reel sur le campus : " + nb_bus;

var nbFreeFloating = document.getElementsByClassName("nbFreefloating");
    nbFreeFloating[0].innerHTML = "Nombre de Vélos en temps reel sur le campus : " + nb_velo;

var arretTrams = document.getElementsByClassName("arretTrams");
    arretTrams[0].innerHTML = "Nombre d'arrets de Tram : " + nb_arrets_tram;

var arretBus = document.getElementsByClassName("arretBus");
    arretBus[0].innerHTML = "Nombre d'arrets de Bus : " + nb_arrets_bus;

var autopartage = document.getElementsByClassName("autopartage");
    autopartage[0].innerHTML = "Nombre de points d'autopartage : " + pt_autopartage;

var covoiturage = document.getElementsByClassName("covoiturage");
    covoiturage[0].innerHTML = "Nombre de points de covoiturage : " + pt_covoiturage;

var charge = document.getElementsByClassName("charge");
    charge[0].innerHTML = "Nombre de recharges éléctrique : " + pt_electriques;

var parking = document.getElementsByClassName("parking");
    parking[0].innerHTML = "Nombre de parking : " + nb_parkings;

// loader_get_data.innerHTML = "Importation des données en cours : " + checkSumInitialLoaging/12*100 + "%";

    
    if (checkSumInitialLoaging >= 12) {
        document.getElementsByClassName("chargementData")[0].innerHTML = '<div id="icon-container"></div><div class="chargementText">Chargement des données</div>';
        document.getElementsByClassName("chargementData")[0].style.display = "none";
    }
    else {
        document.getElementsByClassName("chargementData")[0].innerHTML = "Importation des données en cours : " +  Math.floor(checkSumInitialLoaging/12*100) + "%" ;
        document.getElementsByClassName("chargementData")[0].style = "display: block; background-color: #f1f1f1; color: #000; text-align: center; padding: 14px 16px; text-decoration: none; font-size: 27px;";

    }

}

affichage();

