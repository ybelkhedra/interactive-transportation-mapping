ALTER TABLE emplacement_covoiturage
DROP FOREIGN KEY emplacement_covoiturage_reference_points_de_covoiturages_id;

ALTER TABLE emplacement_pdc
DROP FOREIGN KEY emplacement_pdc_reference_points_de_charges_id;

ALTER TABLE emplacement_stationnement_velo
DROP FOREIGN KEY emplacement_stationnement_velo_reference_stationnement_velo_id;

ALTER TABLE emplacements_parkings
DROP FOREIGN KEY emplacements_parkings_reference_parkings_id;

ALTER TABLE emplacements_parkings
DROP FOREIGN KEY emplacements_parkings_point_coordonnees_gps_id;

ALTER TABLE emplacement_pdc
DROP FOREIGN KEY emplacement_pdc_point_coordonnees_gps_id;

ALTER TABLE emplacement_covoiturage
DROP FOREIGN KEY emplacement_covoiturage_point_coordonnees_gps_id;

ALTER TABLE emplacement_stationnement_velo
DROP FOREIGN KEY emplacement_stationnement_velo_point_coordonnees_gps_id;


DROP TABLE IF EXISTS parkings;
DROP TABLE IF EXISTS coordonnees_gps;
DROP TABLE IF EXISTS emplacements_parkings;
DROP TABLE IF EXISTS points_de_charges;
DROP TABLE IF EXISTS emplacement_pdc;
DROP TABLE IF EXISTS points_de_covoiturages;
DROP TABLE IF EXISTS emplacement_covoiturage;
DROP TABLE IF EXISTS stationnement_velo;
DROP TABLE IF EXISTS emplacement_stationnement_velo;


CREATE TABLE parkings (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom TEXT NOT NULL,
nb_places INT NOT NULL,
payant BOOL NOT NULL,
handicape BOOL NOT NULL,
hors_voirie BOOL NOT NULL,
informations_complementaires TEXT);

CREATE TABLE coordonnees_gps (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE emplacements_parkings (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
point INT NOT NULL,
reference INT NOT NULL);

CREATE TABLE points_de_charges (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom TEXT,
payant BOOL NOT NULL,
prive BOOL);

CREATE TABLE emplacement_pdc (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
point INT NOT NULL,
reference INT NOT NULL);

CREATE TABLE points_de_covoiturages (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nom TEXT,
informations_complementaires TEXT);

CREATE TABLE emplacement_covoiturage (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
point INT NOT NULL,
reference INT NOT NULL);

CREATE TABLE stationnement_velo (
id INT PRIMARY KEY NOT NULL,
prive BOOL NOT NULL,
abrite BOOL NOT NULL,
nom TEXT);

CREATE TABLE emplacement_stationnement_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
point INT NOT NULL,
reference INT NOT NULL);

ALTER TABLE emplacements_parkings ADD CONSTRAINT emplacements_parkings_point_coordonnees_gps_id FOREIGN KEY (point) REFERENCES coordonnees_gps(id);
ALTER TABLE emplacements_parkings ADD CONSTRAINT emplacements_parkings_reference_parkings_id FOREIGN KEY (reference) REFERENCES parkings(id);
ALTER TABLE emplacement_pdc ADD CONSTRAINT emplacement_pdc_point_coordonnees_gps_id FOREIGN KEY (point) REFERENCES coordonnees_gps(id);
ALTER TABLE emplacement_pdc ADD CONSTRAINT emplacement_pdc_reference_points_de_charges_id FOREIGN KEY (reference) REFERENCES points_de_charges(id);
ALTER TABLE emplacement_covoiturage ADD CONSTRAINT emplacement_covoiturage_point_coordonnees_gps_id FOREIGN KEY (point) REFERENCES coordonnees_gps(id);
ALTER TABLE emplacement_covoiturage ADD CONSTRAINT emplacement_covoiturage_reference_points_de_covoiturages_id FOREIGN KEY (reference) REFERENCES points_de_covoiturages(id);
ALTER TABLE emplacement_stationnement_velo ADD CONSTRAINT emplacement_stationnement_velo_point_coordonnees_gps_id FOREIGN KEY (point) REFERENCES coordonnees_gps(id);
ALTER TABLE emplacement_stationnement_velo ADD CONSTRAINT emplacement_stationnement_velo_reference_stationnement_velo_id FOREIGN KEY (reference) REFERENCES stationnement_velo(id);


DELIMITER $$
CREATE TRIGGER delete_parking_emplacements_parkings 
BEFORE DELETE ON parkings
FOR EACH ROW 
BEGIN
    DELETE FROM emplacements_parkings WHERE reference = OLD.id;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER delete_pdc_emplacement_pdc 
BEFORE DELETE ON points_de_charges
FOR EACH ROW 
BEGIN
    DELETE FROM emplacement_pdc WHERE reference = OLD.id;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER delete_covoiturage_emplacement_covoiturage 
BEFORE DELETE ON points_de_covoiturages
FOR EACH ROW 
BEGIN
    DELETE FROM emplacement_covoiturage WHERE reference = OLD.id;
END$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER delete_stationnement_emplacement_stationnement 
BEFORE DELETE ON stationnement_velo
FOR EACH ROW 
BEGIN
    DELETE FROM emplacement_stationnement_velo WHERE reference = OLD.id;
END$$
DELIMITER ;
