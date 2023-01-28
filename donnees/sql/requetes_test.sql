

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
