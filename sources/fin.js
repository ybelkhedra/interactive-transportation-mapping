

function affichage()
{
var nbTram = document.getElementsByClassName("nbTram");
  nbTram.innerHTML = "Nombre de Tram en temps reel sur le campus : " + nb_trams;

var nbBus = document.getElementsByClassName("nbBus");
    nbBus.innerHTML = "Nombre de Bus en temps reel sur le campus : " + nb_bus;

var nbFreeFloating = document.getElementsByClassName("nbFreefloating");
    nbFreeFloating.innerHTML = "Nombre de Vélos en temps reel sur le campus : " + nb_velo;
}

affichage();