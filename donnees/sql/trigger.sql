--________________EXEMPLE DE TRIGGER____________________

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

--________________TRAVAIL A FAIRE : REALISER LES TRIGGERS SUIVANTS____________________

-- 1) Lorque l'on supprime un point de recharge on supprime les coordonnées qui lui sont associées dans la table situer_pt_recharge, les coordonnées dans coordonnees_pt_recharge.
-- On supprime aussi les relations dans la table compatible et les relations dans la table recharger.

DELIMITER $$
CREATE TRIGGER delete_pt_recharge BEFORE DELETE ON pt_recharge
FOR EACH ROW
BEGIN
DELETE FROM situer_pt_recharge WHERE pt_recharge = OLD.id;
DELETE FROM coordonnees_pt_recharge WHERE id = OLD.id;
DELETE FROM compatible WHERE pt_recharge = OLD.id;
DELETE FROM recharger WHERE pt_recharge = OLD.id;
END$$
DELIMITER ;

-- 2) Lorsque l'on supprime un type de borne on supprime aussi les relations dans la table compatible. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)


-- 3) Lorsque l'on supprime un puissances  on supprime aussi les relations dans la table recharger. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)


-- 4) Lorsque l'on supprime un point de covoiturage on supprime les coordonnées qui lui sont associées dans la table situer_pt_covoiturage, les coordonnées dans coordonnees_pt_covoiturage.

DELIMITER $$
CREATE TRIGGER delete_pts_covoit BEFORE DELETE ON pts_covoit
FOR EACH ROW
BEGIN
DELETE FROM situer_pts_covoit WHERE pts_covoit = OLD.id;
DELETE FROM coordonnees_pts_covoit WHERE id = OLD.id;
END$$
DELIMITER ;



-- 5) Lorsque l'on supprime un point de stationnement velo on supprime les coordonnées qui lui sont associées dans la table situer_pt_velo, les coordonnées dans coordonnees_pt_velo.
-- On supprime aussi les relations avec types_accroches dans la table installer.

DELIMITER $$
CREATE TRIGGER delete_stations_velo BEFORE DELETE ON stations_velo
FOR EACH ROW
BEGIN
DELETE FROM situer_stations_velo WHERE pt_velo = OLD.id;
DELETE FROM coordonnees_stations_velo WHERE id = OLD.id;
DELETE FROM installer WHERE pt_velo = OLD.id;
END$$
DELIMITER ;


-- 6) Lorsque l'on supprime un type d'accroche, on supprime aussi les relations avec points de stationnement velo dans la table installer. (pourquoi pas aussi les points de recharge associés aussi ? a discuter dans un second temps)

DELIMITER $$
CREATE TRIGGER delete_types_accroches_velo BEFORE DELETE ON types_accroches_velo
FOR EACH ROW
BEGIN
DELETE FROM installer WHERE column_2 = OLD.id;
END$$
DELIMITER ;

-- 7) Lorsque l'on supprime une piste cyclable on supprime les coordonnées qui lui sont associées dans la table situer_piste_cyclable, les coordonnées dans coordonnees_piste_cyclable.

-- 8) Lorsque l'on supprime un type de piste cyclable, on supprime toutes les pistes cyclables qui lui sont associées.

-- 9) Lorsque l'on supprime un ligne de car, on supprime les coordonnées qui lui sont associées dans la table situer_ligne_car, les coordonnées dans coordonnees_ligne_car.
-- On supprime aussi les relations avec arrets dans la table desservir_car.

-- 10) Lorsque l'on supprime un arret de car, on supprime les coordonnées qui lui sont associées dans la table situer_arret_car, les coordonnées dans coordonnees_arret_car.
-- On supprime aussi les relations avec lignes dans la table desservir_car. On supprime aussi les lignes de cars qui ont par depart ou arrive cette arret.

-- 11) Lorsque l'on supprime une gare ter, on supprime les coordonnées qui lui sont associées dans la table situer_gare_ter, les coordonnées dans coordonnees_gare_ter.

-- 12) Lorsque l'on supprime une stations de freefloating, on supprime les coordonnées qui lui sont associées dans la table situer_stations_freefloating, les coordonnées dans coordonnees_stations_freefloating.
-- On supprime aussi les relations avec vehicule autorises dans la table autoriser.

-- 13) Lorsque l'on supprime un type de vehicule, on supprime aussi les relations avec stations de freefloating dans la table autoriser. (pourquoi pas aussi les stations de freefloating associés qui n'ont pas d'autre vehicule autorisé aussi ? a discuter dans un second temps)

-- 14) Lorsque l'on supprime une stations vcube, on supprime les coordonnées qui lui sont associées dans la table situer_stations_vcube, les coordonnées dans coordonnees_stations_vcube.
-- Les arrets qui avait pour stations vcube a proximité cette stations sont mis a null.

-- 15) Lorsque l'on supprime un arret, on supprime les coordonnées qui lui sont associées dans la table situer_arret, les coordonnées dans coordonnees_arret.
-- On supprime aussi les relations avec lignes dans la table desservir. On supprime aussi les lignes qui ont pour direction cet arret.

-- 16) Lorsque l'on supprime une ligne, on supprime les coordonnées qui lui sont associées dans la table situer_ligne, les coordonnées dans coordonnees_ligne.
-- On supprime aussi les relations avec arrets dans la table desservir. On ne supprime JAMAIS les arrets associés.

-- 17) Lorsque l'on supprime un parking, on supprime les coordonnées qui lui sont associées dans la table situer_parkings, les coordonnées dans coordonnees_parkings.
-- On supprime aussi les points de charges associés à ce parking si il y en a. De même pour les points de covoiturage.
