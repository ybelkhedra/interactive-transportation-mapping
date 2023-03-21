

-- entrainement
SELECT id, coordonnees_parkings.* FROM parkings NATURAL JOIN situer_parkings NATURAL JOIN coordonnees_parkings;

SELECT parkings.id, count(pts_recharge.id) 
FROM parkings 
LEFT OUTER JOIN pts_recharge ON parkings.id = pts_recharge.parking_correspondant
GROUP BY parkings.id;

SELECT parkings.id, count(pts_covoit.id) 
FROM parkings 
LEFT OUTER JOIN pts_covoit ON parkings.id = pts_covoit.parking_correspondant
GROUP BY parkings.id;


-- liste des arrets de cars, avec pour chacun toutes ses informations statiques mais aussi : 
-- la position GPS (pas besoin d'en faire une liste car cela sera un point unique)
-- la liste des lignes qui lui sont associées


SELECT arrets_cars.*, latitude, longitude, lignes_cars.numero AS num_ligne
FROM arrets_cars 
INNER JOIN situer_arrets_cars 
    ON arrets_cars.id = situer_arrets_cars.arret_car
INNER JOIN coordonnees_arrets_cars 
    ON situer_arrets_cars.coordonnee = coordonnees_arrets_cars.id
INNER JOIN desservir_car
    ON arrets_cars.id = desservir_car.arret_car
INNER JOIN lignes_cars
    ON desservir_car.ligne_car = lignes_cars.id
ORDER BY arrets_cars.id;


-- liste des arrets, avec pour chacun toutes ses informations statiques mais aussi : 
-- la position GPS pas besoin d'en faire une liste car cela sera un point unique
-- la station vcube a proximite
-- la liste des lignes qui lui sont associées
-- heure de premier passage de chaque ligne qui lui sont associées
-- heure de dernier passage de chaque ligne qui lui sont associées
-- frequence de chaque ligne qui lui sont associées
-- diurne/nocturne de chaque ligne qui lui sont associées


SELECT arrets.*, latitude, longitude
FROM arrets
INNER JOIN situer_arrets
    ON arrets.id = situer_arrets.arret
INNER JOIN coordonnees_arrets
    ON situer_arrets.coordonnee = coordonnees_arrets.id
;
    
SELECT lignes.*, desservir.*
FROM lignes
INNER JOIN situer_lignes
    ON lignes.id = situer_lignes.ligne
INNER JOIN coordonnees_lignes
    ON situer_lignes.coordonnee = coordonnees_lignes.id
INNER JOIN desservir
    ON lignes.id = desservir.ligne
INNER JOIN arrets
    ON desservir.arret = arrets.id
WHERE arrets.id = 1;


-- On fait la liste des gares_ter, avec pour chacune toutes ses informations statiques mais aussi : 
-- la position GPS pas besoin d'en faire une liste car cela sera un point unique

SELECT gares_ter.*, latitude, longitude
FROM gares_ter
INNER JOIN siter_gares_ter 
    ON gares_ter.id = siter_gares_ter.gare_ter
INNER JOIN coordonnees_gares_ter
    ON siter_gares_ter.coordonnee = coordonnees_gares_ter.id;

SELECT gares_ter.*, latitude, longitude
FROM gares_ter
INNER JOIN siter_gares_ter
    ON gares_ter.id = siter_gares_ter.gare_ter
INNER JOIN coordonnees_gares_ter
    ON siter_gares_ter.coordonnee = coordonnees_gares_ter.id;

-- On fait la liste des points de charges, avec pour chacun toutes ses informations statiques mais aussi : 
-- la position GPS (pas besoin d'en faire une liste car cela sera un point unique) 
-- la liste des types de prise qui lui sont associés
-- la puissance des prises qui lui sont associées

SELECT pts_recharge.*, latitude, longitude, types_de_prises.nom as type_de_prise, puissances.puissance as puissance
FROM pts_recharge
INNER JOIN situer_pts_recharge
    ON pts_recharge.id = situer_pts_recharge.point_de_recharge
INNER JOIN coordonnees_pts_recharge
    ON situer_pts_recharge.coordonnee = coordonnees_pts_recharge.id
INNER JOIN compatible
    ON pts_recharge.id = compatible.point_de_recharge
INNER JOIN types_de_prises
    ON compatible.type_de_prise = types_de_prises.id
INNER JOIN recharger
    ON pts_recharge.id = recharger.point_de_recharge
INNER JOIN puissances
    ON recharger.puissance = puissances.id
;



SELECT stations_vcube.*, latitude, longitude
FROM stations_vcube
INNER JOIN situer_stations_vcube
    ON stations_vcube.id = situer_stations_vcube.station_vcube
INNER JOIN coordonnees_stations_vcube
    ON situer_stations_vcube.coordonnee = coordonnees_stations_vcube.id
;




SELECT stations_vcube.*, latitude, longitude, arrets.nom
FROM stations_vcube
INNER JOIN situer_stations_vcube
    ON stations_vcube.id = situer_stations_vcube.station_vcube
INNER JOIN coordonnees_stations_vcube
    ON situer_stations_vcube.coordonnee = coordonnees_stations_vcube.id
INNER JOIN arrets
    ON stations_vcube.id = arrets.station_vcube_proximite
;

SELECT id
FROM stations_vcube;

SELECT DISTINCT pt_freefloat.*, latitude, longitude
FROM pt_freefloat 
INNER JOIN situer_pt_freefloat 
    ON pt_freefloat.id = situer_pt_freefloat.pt_freefloat 
INNER JOIN coordonnees_pt_freefloat 
    ON situer_pt_freefloat.coordonnee = coordonnees_pt_freefloat.id
;