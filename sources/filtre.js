function filtreCordonnees(lat, lon) {
    if (lat < 44.829622 && lat > 44.776781 && lon < -0.5535 && lon > -0.644965) {
        return true;
    }
    return false;
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