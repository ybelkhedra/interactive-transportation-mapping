function filtreCordonnees(lat, lon) {
    if (lat < 44.81 && lat > 44.76 && lon < -0.579 && lon > -0.65) {
        return true;
    }
    return false;
    console.log("Filtre: " + lat + " " + lon);
}

function filtreCordonneesTab(tab) {
    var tabFiltre = [];
    for (var i = 0; i < tab.length; i++) {
        if (filtreCordonnees(tab[i][0], tab[i][1])) {
            tabFiltre.push(tab[i]);
        }
        if (i>0 && filtreCordonnees(tab[i-1][0], tab[i-1][1]) && !filtreCordonnees(tab[i][0], tab[i][1])) {
            return tabFiltre;
        }
    }
    return tabFiltre;
}