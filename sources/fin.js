

function affichage()
{
var nbTram = document.getElementsByClassName("nbTram");
    console.log(nbTram);
    nbTram[0].innerHTML = "Nombre de Tram en temps reel sur le campus : " + nb_trams;

var nbBus = document.getElementsByClassName("nbBus");
    nbBus[0].innerHTML = "Nombre de Bus en temps reel sur le campus : " + nb_bus;

var nbFreeFloating = document.getElementsByClassName("nbFreefloating");
    nbFreeFloating[0].innerHTML = "Nombre de Vélos en temps reel sur le campus : " + nb_velo;

var arretTrams = document.getElementsByClassName("arretTrams");
    arretTrams[0].innerHTML = "Nombre d'arrets de Tram : " + arrets_trams;

var arretBus = document.getElementsByClassName("arretBus");
    arretBus[0].innerHTML = "Nombre d'arrets de Bus : " + arrets_bus;

var autopartage = document.getElementsByClassName("autopartage");
    autopartage[0].innerHTML = "Nombre de points d'autopartage : " + nb_autopartage;

var covoiturage = document.getElementsByClassName("covoiturage");
    autopartage[0].innerHTML = "Nombre de points de covoiturage : " + nb_covoiturage;

var charge = document.getElementsByClassName("charge");
    charge[0].innerHTML = "Nombre de recharge éléctrique : " + nb_charge;

var parking = document.getElementsByClassName("parking");
    parking[0].innerHTML = "Nombre de parking : " + nb_parking;
}

affichage();