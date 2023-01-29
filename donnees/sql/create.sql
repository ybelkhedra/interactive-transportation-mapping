ALTER TABLE situer_parkings DROP FOREIGN KEY situer_parkings_parking_parkings_id;
ALTER TABLE situer_parkings DROP FOREIGN KEY situer_parkings_coordonnee_coordonnees_parkings_id;
ALTER TABLE pts_recharge DROP FOREIGN KEY pts_recharge_parking_correspondant_parkings_id;
ALTER TABLE situer_pts_recharge DROP FOREIGN KEY situer_pts_recharge_point_de_recharge_pts_recharge_id;
ALTER TABLE situer_pts_recharge DROP FOREIGN KEY situer_pts_recharge_coordonnee_coordonnees_pts_recharge_id;
ALTER TABLE compatible DROP FOREIGN KEY compatible_type_de_prise_types_de_prises_id;
ALTER TABLE compatible DROP FOREIGN KEY compatible_point_de_recharge_pts_recharge_id;
ALTER TABLE recharger DROP FOREIGN KEY recharger_puissance_puissances_id;
ALTER TABLE recharger DROP FOREIGN KEY recharger_point_de_recharge_pts_recharge_id;
ALTER TABLE pts_covoit DROP FOREIGN KEY pts_covoit_parking_correspondant_parkings_id;
ALTER TABLE situer_pts_covoit DROP FOREIGN KEY situer_pts_covoit_point_de_covoiturage_pts_covoit_id;
ALTER TABLE situer_pts_covoit DROP FOREIGN KEY situer_pts_covoit_coordonnee_coordonnees_pts_covoit_id;
ALTER TABLE situer_stations_velo DROP FOREIGN KEY situer_stations_velo_pt_velo_stations_velo_id;
ALTER TABLE situer_stations_velo DROP FOREIGN KEY situer_stations_velo_coordonnee_coordonnees_stations_velo_id;
ALTER TABLE pistes_velo DROP FOREIGN KEY pistes_velo_type_piste_types_pistes_velo_id;
ALTER TABLE situer_pistes_velo DROP FOREIGN KEY situer_pistes_velo_piste_velo_pistes_velo_id;
ALTER TABLE situer_pistes_velo DROP FOREIGN KEY situer_pistes_velo_coordonnee_coordonnees_pistes_velo_id;
ALTER TABLE lignes_cars DROP FOREIGN KEY lignes_cars_depart_arrets_cars_id;
ALTER TABLE situer_lignes_cars DROP FOREIGN KEY situer_lignes_cars_ligne_car_lignes_cars_id;
ALTER TABLE situer_lignes_cars DROP FOREIGN KEY situer_lignes_cars_coordonnee_coordonnees_lignes_cars_id;
ALTER TABLE situer_arrets_cars DROP FOREIGN KEY situer_arrets_cars_arret_car_arrets_cars_id;
ALTER TABLE situer_arrets_cars DROP FOREIGN KEY situer_arrets_cars_coordonnee_coordonnees_arrets_cars_id;
ALTER TABLE desservir_car DROP FOREIGN KEY desservir_car_ligne_car_lignes_cars_id;
ALTER TABLE desservir_car DROP FOREIGN KEY desservir_car_arret_car_arrets_cars_id;
ALTER TABLE siter_gares_ter DROP FOREIGN KEY siter_gares_ter_gare_ter_gares_ter_id;
ALTER TABLE siter_gares_ter DROP FOREIGN KEY siter_gares_ter_coordonnee_coordonnees_gares_ter_id;
ALTER TABLE situer_pt_freefloat DROP FOREIGN KEY situer_pt_freefloat_pt_freefloat_pt_freefloat_id;
ALTER TABLE situer_pt_freefloat DROP FOREIGN KEY situer_pt_freefloat_coordonnee_coordonnees_pt_freefloat_id;
ALTER TABLE autoriser DROP FOREIGN KEY autoriser_pt_freefloat_pt_freefloat_id;
ALTER TABLE arrets DROP FOREIGN KEY arrets_station_vcube_proximite_stations_vcube_id;
ALTER TABLE situer_arrets DROP FOREIGN KEY situer_arrets_arret_arrets_id;
ALTER TABLE situer_arrets DROP FOREIGN KEY situer_arrets_coordonnee_coordonnees_arrets_id;
ALTER TABLE lignes DROP FOREIGN KEY lignes_direction_arrets_id;
ALTER TABLE desservir DROP FOREIGN KEY desservir_ligne_lignes_id;
ALTER TABLE desservir DROP FOREIGN KEY desservir_arret_arrets_id;
ALTER TABLE situer_stations_vcube DROP FOREIGN KEY situer_stations_vcube_station_vcube_stations_vcube_id;
ALTER TABLE situer_stations_vcube DROP FOREIGN KEY situer_stations_vcube_coordonnee_coordonnees_stations_vcube_id;
ALTER TABLE situer_lignes DROP FOREIGN KEY situer_lignes_ligne_lignes_id;
ALTER TABLE situer_lignes DROP FOREIGN KEY situer_lignes_coordonnee_coordonnees_lignes_id;
ALTER TABLE lignes DROP FOREIGN KEY lignes_type_types_lignes_id;
ALTER TABLE autoriser DROP FOREIGN KEY autoriser_vehicule_vehicules_freefloating_id;
ALTER TABLE installer DROP FOREIGN KEY installer_type_accroche_types_accroches_velo_id;
ALTER TABLE installer DROP FOREIGN KEY installer_station_velo_stations_velo_id;



DROP TABLE IF EXISTS parkings;
DROP TABLE IF EXISTS situer_parkings;
DROP TABLE IF EXISTS coordonnees_parkings;
DROP TABLE IF EXISTS pts_recharge;
DROP TABLE IF EXISTS situer_pts_recharge;
DROP TABLE IF EXISTS coordonnees_pts_recharge;
DROP TABLE IF EXISTS types_de_prises;
DROP TABLE IF EXISTS puissances;
DROP TABLE IF EXISTS compatible;
DROP TABLE IF EXISTS recharger;
DROP TABLE IF EXISTS pts_covoit;
DROP TABLE IF EXISTS situer_pts_covoit;
DROP TABLE IF EXISTS coordonnees_pts_covoit;
DROP TABLE IF EXISTS stations_velo;
DROP TABLE IF EXISTS coordonnees_stations_velo;
DROP TABLE IF EXISTS situer_stations_velo;
DROP TABLE IF EXISTS types_accroches_velo;
DROP TABLE IF EXISTS installer;
DROP TABLE IF EXISTS pistes_velo;
DROP TABLE IF EXISTS coordonnees_pistes_velo;
DROP TABLE IF EXISTS situer_pistes_velo;
DROP TABLE IF EXISTS types_pistes_velo;
DROP TABLE IF EXISTS lignes_cars;
DROP TABLE IF EXISTS situer_lignes_cars;
DROP TABLE IF EXISTS coordonnees_lignes_cars;
DROP TABLE IF EXISTS arrets_cars;
DROP TABLE IF EXISTS coordonnees_arrets_cars;
DROP TABLE IF EXISTS situer_arrets_cars;
DROP TABLE IF EXISTS desservir_car;
DROP TABLE IF EXISTS gares_ter;
DROP TABLE IF EXISTS siter_gares_ter;
DROP TABLE IF EXISTS coordonnees_gares_ter;
DROP TABLE IF EXISTS pt_freefloat;
DROP TABLE IF EXISTS coordonnees_pt_freefloat;
DROP TABLE IF EXISTS situer_pt_freefloat;
DROP TABLE IF EXISTS vehicules_freefloating;
DROP TABLE IF EXISTS autoriser;
DROP TABLE IF EXISTS stations_vcube;
DROP TABLE IF EXISTS coordonnees_stations_vcube;
DROP TABLE IF EXISTS situer_stations_vcube;
DROP TABLE IF EXISTS arrets;
DROP TABLE IF EXISTS coordonnees_arrets;
DROP TABLE IF EXISTS situer_arrets;
DROP TABLE IF EXISTS lignes;
DROP TABLE IF EXISTS coordonnees_lignes;
DROP TABLE IF EXISTS situer_lignes;
DROP TABLE IF EXISTS desservir;
DROP TABLE IF EXISTS types_lignes;

CREATE TABLE parkings (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT,
nb_places_max INT NOT NULL,
nb_places_disponibles INT,
payant BOOLEAN NOT NULL,
nb_places_handicapes INT NOT NULL,
hors_voirie BOOLEAN NOT NULL,
prive BOOLEAN NOT NULL,
informations_complementaires TEXT);


CREATE TABLE situer_parkings (
id INT NOT NULL,
parking INT NOT NULL,
coordonnee INT NOT NULL);


CREATE TABLE coordonnees_parkings (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);


CREATE TABLE pts_recharge (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT,
parking_correspondant INT,
info_complementaires TEXT);


CREATE TABLE situer_pts_recharge (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
point_de_recharge INT NOT NULL,
coordonnee INT NOT NULL);


CREATE TABLE coordonnees_pts_recharge (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);


CREATE TABLE types_de_prises (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL);


CREATE TABLE puissances (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
puissance FLOAT NOT NULL);


CREATE TABLE compatible (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
type_de_prise INT NOT NULL,
point_de_recharge INT NOT NULL);


CREATE TABLE recharger (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
puissance INT NOT NULL,
point_de_recharge INT NOT NULL);


CREATE TABLE pts_covoit (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT,
nombre_de_places INT NOT NULL,
parking_correspondant INT,
info_complementaires TEXT);


CREATE TABLE situer_pts_covoit (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
point_de_covoiturage INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE coordonnees_pts_covoit (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);


CREATE TABLE stations_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nb_places INT NOT NULL,
securise BOOLEAN NOT NULL,
abrite BOOLEAN NOT NULL,
info_complementaires TEXT);


CREATE TABLE coordonnees_stations_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_stations_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
pt_velo INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE types_accroches_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL);

CREATE TABLE installer (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
station_velo INT NOT NULL,
type_accroche INT NOT NULL);

CREATE TABLE pistes_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
type_piste INT NOT NULL,
info_complementaires TEXT);

CREATE TABLE coordonnees_pistes_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);


CREATE TABLE situer_pistes_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
piste_velo INT NOT NULL,
coordonnee INT NOT NULL);


CREATE TABLE types_pistes_velo (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL);



CREATE TABLE lignes_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
numero INT NOT NULL,
depart INT NOT NULL,
destination INT NOT NULL,
car_express BOOLEAN NOT NULL,
info_complementaires TEXT);


CREATE TABLE situer_lignes_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
ligne_car INT NOT NULL,
coordonnee INT NOT NULL);


CREATE TABLE coordonnees_lignes_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);


CREATE TABLE arrets_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL,
info_complementaires TEXT);

CREATE TABLE coordonnees_arrets_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_arrets_cars (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
arret_car INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE desservir_car (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
ligne_car INT NOT NULL,
arret_car INT NOT NULL);

CREATE TABLE gares_ter (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL,
info_complementaires TEXT);

CREATE TABLE siter_gares_ter (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
gare_ter INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE coordonnees_gares_ter (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE pt_freefloat (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT,
info_complementaires TEXT);

CREATE TABLE coordonnees_pt_freefloat (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_pt_freefloat (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
pt_freefloat INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE vehicules_freefloating (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
vehicule TEXT NOT NULL);

CREATE TABLE autoriser (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
pt_freefloat INT NOT NULL,
vehicule INT NOT NULL);

CREATE TABLE stations_vcube (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT,
nb_velos_max INT NOT NULL,
nb_velos_dispo INT,
vcube_plus BOOLEAN NOT NULL,
velos_electriques BOOLEAN NOT NULL,
info_complementaires TEXT);

CREATE TABLE coordonnees_stations_vcube (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_stations_vcube (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
station_vcube INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE arrets (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL,
station_vcube_proximite INT,
info_complementaires TEXT);

CREATE TABLE coordonnees_arrets (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_arrets (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
arret INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE lignes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL,
direction INT NOT NULL,
type INT,
info_complementaires TEXT);

CREATE TABLE coordonnees_lignes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL);

CREATE TABLE situer_lignes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
ligne INT NOT NULL,
coordonnee INT NOT NULL);

CREATE TABLE desservir (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
arret INT NOT NULL,
ligne INT NOT NULL,
heure_premier_passage TIME,
heure_dernier_passage TIME,
heure_prochain_passage TIME,
horaires TEXT,
frequence TIME,
diurne BOOLEAN,
nocturne BOOLEAN);

CREATE TABLE types_lignes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
nom TEXT NOT NULL);

ALTER TABLE situer_parkings ADD CONSTRAINT situer_parkings_parking_parkings_id FOREIGN KEY (parking) REFERENCES parkings(id);
ALTER TABLE situer_parkings ADD CONSTRAINT situer_parkings_coordonnee_coordonnees_parkings_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_parkings(id);
ALTER TABLE pts_recharge ADD CONSTRAINT pts_recharge_parking_correspondant_parkings_id FOREIGN KEY (parking_correspondant) REFERENCES parkings(id);
ALTER TABLE situer_pts_recharge ADD CONSTRAINT situer_pts_recharge_point_de_recharge_pts_recharge_id FOREIGN KEY (point_de_recharge) REFERENCES pts_recharge(id);
ALTER TABLE situer_pts_recharge ADD CONSTRAINT situer_pts_recharge_coordonnee_coordonnees_pts_recharge_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_pts_recharge(id);
ALTER TABLE compatible ADD CONSTRAINT compatible_type_de_prise_types_de_prises_id FOREIGN KEY (type_de_prise) REFERENCES types_de_prises(id);
ALTER TABLE compatible ADD CONSTRAINT compatible_point_de_recharge_pts_recharge_id FOREIGN KEY (point_de_recharge) REFERENCES pts_recharge(id);
ALTER TABLE recharger ADD CONSTRAINT recharger_puissance_puissances_id FOREIGN KEY (puissance) REFERENCES puissances(id);
ALTER TABLE recharger ADD CONSTRAINT recharger_point_de_recharge_pts_recharge_id FOREIGN KEY (point_de_recharge) REFERENCES pts_recharge(id);
ALTER TABLE pts_covoit ADD CONSTRAINT pts_covoit_parking_correspondant_parkings_id FOREIGN KEY (parking_correspondant) REFERENCES parkings(id);
ALTER TABLE situer_pts_covoit ADD CONSTRAINT situer_pts_covoit_point_de_covoiturage_pts_covoit_id FOREIGN KEY (point_de_covoiturage) REFERENCES pts_covoit(id);
ALTER TABLE situer_pts_covoit ADD CONSTRAINT situer_pts_covoit_coordonnee_coordonnees_pts_covoit_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_pts_covoit(id);
ALTER TABLE situer_stations_velo ADD CONSTRAINT situer_stations_velo_pt_velo_stations_velo_id FOREIGN KEY (pt_velo) REFERENCES stations_velo(id);
ALTER TABLE situer_stations_velo ADD CONSTRAINT situer_stations_velo_coordonnee_coordonnees_stations_velo_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_stations_velo(id);
ALTER TABLE installer ADD CONSTRAINT installer_station_velo_stations_velo_id FOREIGN KEY (station_velo) REFERENCES stations_velo(id);
ALTER TABLE installer ADD CONSTRAINT installer_type_accroche_types_accroches_velo_id FOREIGN KEY (type_accroche) REFERENCES types_accroches_velo(id);
ALTER TABLE pistes_velo ADD CONSTRAINT pistes_velo_type_piste_types_pistes_velo_id FOREIGN KEY (type_piste) REFERENCES types_pistes_velo(id);
ALTER TABLE situer_pistes_velo ADD CONSTRAINT situer_pistes_velo_piste_velo_pistes_velo_id FOREIGN KEY (piste_velo) REFERENCES pistes_velo(id);
ALTER TABLE situer_pistes_velo ADD CONSTRAINT situer_pistes_velo_coordonnee_coordonnees_pistes_velo_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_pistes_velo(id);
ALTER TABLE lignes_cars ADD CONSTRAINT lignes_cars_depart_arrets_cars_id FOREIGN KEY (depart) REFERENCES arrets_cars(id);
ALTER TABLE lignes_cars ADD CONSTRAINT lignes_cars_destination_arrets_cars_id FOREIGN KEY (destination) REFERENCES arrets_cars(id);
ALTER TABLE situer_lignes_cars ADD CONSTRAINT situer_lignes_cars_ligne_car_lignes_cars_id FOREIGN KEY (ligne_car) REFERENCES lignes_cars(id);
ALTER TABLE situer_lignes_cars ADD CONSTRAINT situer_lignes_cars_coordonnee_coordonnees_lignes_cars_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_lignes_cars(id);
ALTER TABLE situer_arrets_cars ADD CONSTRAINT situer_arrets_cars_arret_car_arrets_cars_id FOREIGN KEY (arret_car) REFERENCES arrets_cars(id);
ALTER TABLE situer_arrets_cars ADD CONSTRAINT situer_arrets_cars_coordonnee_coordonnees_arrets_cars_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_arrets_cars(id);
ALTER TABLE desservir_car ADD CONSTRAINT desservir_car_ligne_car_lignes_cars_id FOREIGN KEY (ligne_car) REFERENCES lignes_cars(id);
ALTER TABLE desservir_car ADD CONSTRAINT desservir_car_arret_car_arrets_cars_id FOREIGN KEY (arret_car) REFERENCES arrets_cars(id);
ALTER TABLE siter_gares_ter ADD CONSTRAINT siter_gares_ter_gare_ter_gares_ter_id FOREIGN KEY (gare_ter) REFERENCES gares_ter(id);
ALTER TABLE siter_gares_ter ADD CONSTRAINT siter_gares_ter_coordonnee_coordonnees_gares_ter_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_gares_ter(id);
ALTER TABLE situer_pt_freefloat ADD CONSTRAINT situer_pt_freefloat_pt_freefloat_pt_freefloat_id FOREIGN KEY (pt_freefloat) REFERENCES pt_freefloat(id);
ALTER TABLE situer_pt_freefloat ADD CONSTRAINT situer_pt_freefloat_coordonnee_coordonnees_pt_freefloat_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_pt_freefloat(id);
ALTER TABLE autoriser ADD CONSTRAINT autoriser_pt_freefloat_pt_freefloat_id FOREIGN KEY (pt_freefloat) REFERENCES pt_freefloat(id);
ALTER TABLE autoriser ADD CONSTRAINT autoriser_vehicule_vehicules_freefloating_id FOREIGN KEY (vehicule) REFERENCES vehicules_freefloating(id);
ALTER TABLE situer_stations_vcube ADD CONSTRAINT situer_stations_vcube_station_vcube_stations_vcube_id FOREIGN KEY (station_vcube) REFERENCES stations_vcube(id);
ALTER TABLE situer_stations_vcube ADD CONSTRAINT situer_stations_vcube_coordonnee_coordonnees_stations_vcube_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_stations_vcube(id);
ALTER TABLE arrets ADD CONSTRAINT arrets_station_vcube_proximite_stations_vcube_id FOREIGN KEY (station_vcube_proximite) REFERENCES stations_vcube(id);
ALTER TABLE situer_arrets ADD CONSTRAINT situer_arrets_arret_arrets_id FOREIGN KEY (arret) REFERENCES arrets(id);
ALTER TABLE situer_arrets ADD CONSTRAINT situer_arrets_coordonnee_coordonnees_arrets_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_arrets(id);
ALTER TABLE lignes ADD CONSTRAINT lignes_direction_arrets_id FOREIGN KEY (direction) REFERENCES arrets(id);
ALTER TABLE lignes ADD CONSTRAINT lignes_type_types_lignes_id FOREIGN KEY (type) REFERENCES types_lignes(id);
ALTER TABLE situer_lignes ADD CONSTRAINT situer_lignes_ligne_lignes_id FOREIGN KEY (ligne) REFERENCES lignes(id);
ALTER TABLE situer_lignes ADD CONSTRAINT situer_lignes_coordonnee_coordonnees_lignes_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_lignes(id);
ALTER TABLE desservir ADD CONSTRAINT desservir_arret_arrets_id FOREIGN KEY (arret) REFERENCES arrets(id);
ALTER TABLE desservir ADD CONSTRAINT desservir_ligne_lignes_id FOREIGN KEY (ligne) REFERENCES lignes(id);


