
-- Lorsque l'on supprime une station de vélo, on supprime les coordonnées qui lui sont associées 
-- dans la table situer_stations_velo, on supprime aussi les coordonnéees dans la table coordonnees_stations_velo
DROP TRIGGER IF EXISTS delete_stations_velo;

DELIMITER $$
CREATE TRIGGER delete_stations_velo BEFORE DELETE ON stations_velo
FOR EACH ROW
BEGIN
DELETE FROM situer_stations_velo WHERE pt_velo = OLD.id;
DELETE FROM coordonnees_stations_velo WHERE id = OLD.id;
END$$
DELIMITER ;


-- 1) Lorsque l'on supprime un point de recharge on supprime les coordonnées qui lui sont associées dans la table situer_pt_recharge, les coordonnées dans coordonnees_pt_recharge.
-- On supprime aussi les relations dans la table compatible et les relations dans la table recharger.

DROP TRIGGER IF EXISTS delete_pts_recharge;

DELIMITER $$
CREATE TRIGGER delete_pts_recharge BEFORE DELETE ON pts_recharge
FOR EACH ROW
BEGIN
DELETE FROM situer_pts_recharge WHERE point_de_recharge = OLD.id;
DELETE FROM coordonnees_pts_recharge WHERE id = OLD.id;
DELETE FROM compatible WHERE point_de_recharge = OLD.id;
DELETE FROM recharger WHERE point_de_recharge = OLD.id;
END$$
DELIMITER ;

-- 2) Lorsque l'on supprime un type de borne on supprime aussi les relations dans la table compatible. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)
DROP TRIGGER IF EXISTS delete_type_prise;

DELIMITER $$
CREATE TRIGGER delete_type_prise BEFORE DELETE ON types_de_prises
FOR EACH ROW
BEGIN 
DELETE FROM compatible WHERE type_de_prise = OLD.id; 
END$$
DELIMITER ;

-- 3) Lorsque l'on supprime un puissances on supprime aussi les relations dans la table recharger. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)

DROP TRIGGER IF EXISTS delete_puissance;

DELIMITER $$
CREATE TRIGGER delete_puissance BEFORE DELETE ON puissances
FOR EACH ROW
BEGIN 
DELETE FROM recharger WHERE puissance = OLD.id; 
END$$
DELIMITER ;

-- 4) Lorsque l'on supprime un point de covoiturage on supprime les coordonnées qui lui sont associées dans la table situer_pt_covoiturage, les coordonnées dans coordonnees_pt_covoiturage.

DROP TRIGGER IF EXISTS delete_pts_covoit;

DELIMITER $$
CREATE TRIGGER delete_pts_covoit BEFORE DELETE ON pts_covoit
FOR EACH ROW
BEGIN
DELETE FROM situer_pts_covoit WHERE point_de_covoiturage = OLD.id;
DELETE FROM coordonnees_pts_covoit WHERE id = OLD.id;
END$$
DELIMITER ;



-- 5) Lorsque l'on supprime un point de stationnement velo on supprime les coordonnées qui lui sont associées dans la table situer_pt_velo, les coordonnées dans coordonnees_pt_velo.
-- On supprime aussi les relations avec types_accroches dans la table installer.

DROP TRIGGER IF EXISTS delete_stations_velo;

DELIMITER $$
CREATE TRIGGER delete_stations_velo BEFORE DELETE ON stations_velo
FOR EACH ROW
BEGIN
DELETE FROM situer_stations_velo WHERE pt_velo = OLD.id;
DELETE FROM coordonnees_stations_velo WHERE id = OLD.id;
DELETE FROM installer WHERE station_velo = OLD.id;
END$$
DELIMITER ;


-- 6) Lorsque l'on supprime un type d'accroche, on supprime aussi les relations avec points de stationnement velo dans la table installer. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)

DROP TRIGGER IF EXISTS delete_types_accroches_velo;

DELIMITER $$
CREATE TRIGGER delete_types_accroches_velo BEFORE DELETE ON types_accroches_velo
FOR EACH ROW
BEGIN
DELETE FROM installer WHERE type_accroche = OLD.id;
END$$
DELIMITER ;

-- 7) Lorsque l'on supprime une piste cyclable on supprime les coordonnées qui lui sont associées dans la table situer_piste_cyclable, les coordonnées dans coordonnees_piste_cyclable.

DROP TRIGGER IF EXISTS delete_pistes_velo;

DELIMITER $$
CREATE TRIGGER delete_pistes_velo BEFORE DELETE ON pistes_velo
FOR EACH ROW
BEGIN
DELETE FROM situer_pistes_velo WHERE piste_velo = OLD.id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS delete_situer_pistes_velo;


DELIMITER $$
CREATE TRIGGER delete_situer_pistes_velo BEFORE DELETE ON situer_pistes_velo
FOR EACH ROW
BEGIN
DELETE FROM coordonnees_pistes_velo WHERE id = OLD.coordonnee;
END$$
DELIMITER ;

-- 8) Lorsque l'on supprime un type de piste cyclable, on supprime toutes les pistes cyclables qui lui sont associées.

DROP TRIGGER IF EXISTS delete_types_pistes_velo;

DELIMITER $$
CREATE TRIGGER delete_types_pistes_velo BEFORE DELETE ON types_pistes_velo
FOR EACH ROW
BEGIN
DELETE FROM pistes_velo WHERE type_piste = OLD.id;
END$$
DELIMITER ;


-- 9) Lorsque l'on supprime un ligne de car, on supprime les coordonnées qui lui sont associées dans la table situer_ligne_car, les coordonnées dans coordonnees_ligne_car.
-- On supprime aussi les relations avec arrets dans la table desservir_car.

DROP TRIGGER IF EXISTS delete_lignes_cars;

DELIMITER $$
CREATE TRIGGER delete_lignes_cars BEFORE DELETE ON lignes_cars
FOR EACH ROW
BEGIN
DELETE FROM situer_lignes_cars WHERE ligne_car = OLD.id;
DELETE FROM desservir_car WHERE ligne_car = OLD.id;

END$$
DELIMITER ;


DROP TRIGGER IF EXISTS delete_situer_lignes_cars;

DELIMITER $$
CREATE TRIGGER delete_situer_lignes_cars BEFORE DELETE ON situer_lignes_cars
FOR EACH ROW
BEGIN
DELETE FROM coordonnees_lignes_cars WHERE id = OLD.coordonnee;
END$$
DELIMITER ;





-- 10) Lorsque l'on supprime un arret de car, on supprime les coordonnées qui lui sont associées dans la table situer_arret_car, les coordonnées dans coordonnees_arret_car.
-- On supprime aussi les relations avec lignes dans la table desservir_car. On supprime aussi les lignes de cars qui ont par depart ou arrive cette arret.

DROP TRIGGER IF EXISTS delete_arrets_cars;

DELIMITER $$
CREATE TRIGGER delete_arrets_cars BEFORE DELETE ON arrets_cars
FOR EACH ROW
BEGIN
DELETE FROM situer_arrets_cars WHERE arret_car = OLD.id;
DELETE FROM desservir_car WHERE arret_car = OLD.id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS delete_situer_arrets_cars;

DELIMITER $$
CREATE TRIGGER delete_situer_arrets_cars BEFORE DELETE ON situer_arrets_cars
FOR EACH ROW
BEGIN
DELETE FROM coordonnees_arrets_cars WHERE id = OLD.coordonnee;
END$$
DELIMITER ;



-- 11) Lorsque l'on supprime une gare ter, on supprime les coordonnées qui lui sont associées dans la table situer_gare_ter, les coordonnées dans coordonnees_gare_ter.

DROP TRIGGER IF EXISTS delete_gares_ter;

DELIMITER $$
CREATE TRIGGER delete_gares_ter BEFORE DELETE ON gares_ter
FOR EACH ROW
BEGIN
DELETE FROM siter_gares_ter WHERE gare_ter = OLD.id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS delete_siter_gares_ter;

DELIMITER $$
CREATE TRIGGER delete_siter_gares_ter BEFORE DELETE ON siter_gares_ter
FOR EACH ROW
BEGIN
DELETE FROM coordonnees_gares_ter WHERE id = OLD.coordonnee;
END$$
DELIMITER ;


-- 12) Lorsque l'on supprime une stations de freefloating, on supprime les coordonnées qui lui sont associées dans la table situer_stations_freefloating, les coordonnées dans coordonnees_stations_freefloating.
-- On supprime aussi les relations avec vehicule autorises dans la table autoriser.


DROP TRIGGER IF EXISTS delete_pt_freefloat;

DELIMITER $$
CREATE TRIGGER delete_pt_freefloat BEFORE DELETE ON pt_freefloat
FOR EACH ROW
BEGIN
DELETE FROM situer_pt_freefloat WHERE pt_freefloat = OLD.id;
DELETE FROM autoriser WHERE pt_freefloat = OLD.id;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS delete_situer_pt_freefloat;

DELIMITER $$
CREATE TRIGGER delete_situer_pt_freefloat BEFORE DELETE ON situer_pt_freefloat
FOR EACH ROW
BEGIN
DELETE FROM coordonnees_pt_freefloat WHERE id = OLD.coordonnee;
END$$
DELIMITER ;



-- 13) Lorsque l'on supprime un type de vehicule, on supprime aussi les relations avec stations de freefloating dans la table autoriser. (pourquoi pas aussi les stations de freefloating associés qui n'ont pas d'autre vehicule autorisé aussi ? a discuter dans un second temps)
DROP TRIGGER IF EXISTS delete_vehicule;

DELIMITER $$
CREATE TRIGGER delete_vehicule
BEFORE DELETE ON vehicules_freefloating
FOR EACH ROW
BEGIN
  DELETE FROM autoriser WHERE vehicule = OLD.id;
END$$
DELIMITER ;



-- 14) Lorsque l'on supprime une stations vcube, on supprime les coordonnées qui lui sont associées dans la table situer_stations_vcube, les coordonnées dans coordonnees_stations_vcube.
-- Les arrets qui avait pour stations vcube a proximité cette stations sont mis a null.
DROP TRIGGER IF EXISTS delete_station_vcube;

DELIMITER $$
CREATE TRIGGER delete_station_vcube
BEFORE DELETE ON stations_vcube
FOR EACH ROW
BEGIN
  DELETE FROM coordonnees_stations_vcube WHERE id = (SELECT coordonnee FROM situer_stations_vcube WHERE station_vcube = OLD.id);
  DELETE FROM situer_stations_vcube WHERE station_vcube = OLD.id;
  UPDATE arrets SET station_vcube_proximite = NULL WHERE station_vcube_proximite = OLD.id;
END$$
DELIMITER ;



-- 15) Lorsque l'on supprime un arret, on supprime les coordonnées qui lui sont associées dans la table situer_arret, les coordonnées dans coordonnees_arret.
-- On supprime aussi les relations avec lignes dans la table desservir. On supprime aussi les lignes qui ont pour direction cet arret.
DROP TRIGGER IF EXISTS delete_arret;

DELIMITER $$
CREATE TRIGGER delete_arret
BEFORE DELETE ON arrets
FOR EACH ROW
BEGIN
  DELETE FROM situer_arret WHERE arret = OLD.id;
  DELETE FROM coordonnees_arret WHERE id = (SELECT coordonnee FROM situer_arret WHERE arret = OLD.id);
  DELETE FROM desservir WHERE arret = OLD.id;
  DELETE FROM ligne WHERE direction = OLD.id;
END $$
DELIMITER ;



-- 16) Lorsque l'on supprime une ligne, on supprime les coordonnées qui lui sont associées dans la table situer_ligne, les coordonnées dans coordonnees_ligne.
-- On supprime aussi les relations avec arrets dans la table desservir. On ne supprime JAMAIS les arrets associés.
DROP TRIGGER IF EXISTS delete_ligne;

DELIMITER $$
CREATE TRIGGER delete_ligne 
BEFORE DELETE ON lignes
FOR EACH ROW
BEGIN
    DELETE FROM situer_lignes WHERE ligne = OLD.id;
    DELETE FROM coordonnees_lignes WHERE id = (SELECT coordonnee FROM situer_lignes WHERE ligne = OLD.id);
    DELETE FROM desservir WHERE ligne = OLD.id;
END $$
DELIMITER ;



-- 17) Lorsque l'on supprime un parking, on supprime les coordonnées qui lui sont associées dans la table situer_parkings, les coordonnées dans coordonnees_parkings.
-- On supprime aussi les points de charges associés à ce parking si il y en a. De même pour les points de covoiturage.
DROP TRIGGER IF EXISTS delete_parking;

DELIMITER $$
CREATE TRIGGER delete_parking 
BEFORE DELETE ON parkings
FOR EACH ROW
BEGIN
    DELETE FROM situer_parkings WHERE parking = OLD.id;
    DELETE FROM coordonnees_parkings WHERE id IN (SELECT coordonnee FROM situer_parkings WHERE parking = OLD.id);
    DELETE FROM pts_recharge WHERE parking_correspondant = OLD.id;
    DELETE FROM pts_covoit WHERE parking_correspondant = OLD.id;
END $$
DELIMITER ;
