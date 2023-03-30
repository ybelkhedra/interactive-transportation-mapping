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
ALTER TABLE situer_gares_ter DROP FOREIGN KEY situer_gares_ter_gare_ter_gares_ter_id;
ALTER TABLE situer_gares_ter DROP FOREIGN KEY situer_gares_ter_coordonnee_coordonnees_gares_ter_id;
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

ALTER TABLE horaires DROP FOREIGN KEY horaires_ligne_lignes_id;
ALTER TABLE horaires DROP FOREIGN KEY horaires_arret_arrets_id;
ALTER TABLE horaires DROP FOREIGN KEY horaires_direction_arrets_id;

ALTER TABLE lignesData DROP FOREIGN KEY lignesData_rs_sv_ligne_a_nomCommercialData_gid;
ALTER TABLE lignesData DROP FOREIGN KEY lignesData_rg_sv_arret_p_nd_arretsData_gid;
ALTER TABLE lignesData DROP FOREIGN KEY lignesData_rg_sv_arret_p_na_arretsData_gid;
ALTER TABLE tronconsData DROP FOREIGN KEY tronconsData_rg_sv_arret_p_nd_arretsData_gid;
ALTER TABLE tronconsData DROP FOREIGN KEY tronconsData_rg_sv_arret_p_na_arretsData_gid;
ALTER TABLE relationsLignesTronconsData DROP FOREIGN KEY relationsLignesTronconsData_rs_sv_chem_l_lignesData_gid;
ALTER TABLE relationsLignesTronconsData DROP FOREIGN KEY relationsLignesTronconsData_rs_sv_tronc_l_tronconsData_gid;
ALTER TABLE horairesData DROP FOREIGN KEY horairesData_rs_sv_arret_p_arretsData_gid;
ALTER TABLE horairesData DROP FOREIGN KEY horairesData_rs_sv_cours_a_CoursesData_gid;
ALTER TABLE CoursesData DROP FOREIGN KEY CoursesData_rs_sv_ligne_a_nomCommercialData_gid;
ALTER TABLE CoursesData DROP FOREIGN KEY CoursesData_rs_sv_chem_l_lignesData_gid;
ALTER TABLE CoursesData DROP FOREIGN KEY CoursesData_rg_sv_arret_p_nd_arretsData_gid;
ALTER TABLE CoursesData DROP FOREIGN KEY CoursesData_rg_sv_arret_p_na_arretsData_gid;


ALTER TABLE stop_times DROP FOREIGN KEY stop_times_stop_id_stop_stop_id;
ALTER TABLE trips DROP FOREIGN KEY trips_route_id_routes_route_id;
ALTER TABLE trips DROP FOREIGN KEY trips_service_id_calendar_service_id;
-- ALTER TABLE trips DROP FOREIGN KEY stop_times_trip_id_trips_trip_id;
-- ALTER TABLE trips DROP FOREIGN KEY trips_shape_id_shapes_shape_id;
ALTER TABLE routes DROP FOREIGN KEY routes_agency_id_agency_agency_id;
ALTER TABLE calendar_dates DROP FOREIGN KEY calendar_dates_service_id_calendar_service_id;





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
DROP TABLE IF EXISTS situer_gares_ter;
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
DROP TABLE IF EXISTS horaires;





DROP TABLE IF EXISTS arretsData;
DROP TABLE IF EXISTS lignesData;
DROP TABLE IF EXISTS tronconsData;
DROP TABLE IF EXISTS relationsLignesTronconsData;
DROP TABLE IF EXISTS horairesData;
DROP TABLE IF EXISTS CoursesData;
DROP TABLE IF EXISTS nomCommercialData;






DROP TABLE IF EXISTS stop;
DROP TABLE IF EXISTS stop_times;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS shapes;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS calendar_dates;
DROP TABLE IF EXISTS calendar;


CREATE TABLE stop (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
stop_id INT NOT NULL UNIQUE,
stop_name TEXT NOT NULL,
stop_lat FLOAT NOT NULL,
stop_lon FLOAT NOT NULL);

CREATE TABLE stop_times (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
trip_id BIGINT NOT NULL,
arrival_time TEXT NOT NULL,
departure_time TEXT NOT NULL,
stop_id INT NOT NULL,
stop_sequence INT NOT NULL);

CREATE TABLE trips (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
route_id INT NOT NULL,
service_id INT NOT NULL,
trip_id BIGINT NOT NULL UNIQUE,
trip_headsign TEXT NOT NULL,
trip_short_name TEXT NOT NULL,
direction_id INT NOT NULL,
shape_id TEXT NOT NULL,
wheelchair_accessible INT NOT NULL,
bikes_allowed INT NOT NULL);

CREATE TABLE shapes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
shape_id TEXT NOT NULL,
shape_pt_lat FLOAT NOT NULL,
shape_pt_lon FLOAT NOT NULL,
shape_pt_sequence INT NOT NULL);

CREATE TABLE routes (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
route_id INT NOT NULL UNIQUE,
agency_id INT NOT NULL,
route_short_name INT NOT NULL,
route_long_name TEXT NOT NULL);

CREATE TABLE agency (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
agency_id INT NOT NULL UNIQUE,
agency_name TEXT NOT NULL,
agency_url TEXT NOT NULL);

CREATE TABLE calendar_dates (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
service_id INT NOT NULL,
date INT NOT NULL);

CREATE TABLE calendar (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
service_id INT NOT NULL UNIQUE,
monday BOOL NOT NULL,
tuesday BOOL NOT NULL,
wednesday BOOL NOT NULL,
thursday BOOL NOT NULL,
friday BOOL NOT NULL,
saturday BOOL NOT NULL,
sunday BOOL NOT NULL,
start_date INT NOT NULL,
end_date INT NOT NULL);


CREATE TABLE arretsData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
latitude FLOAT NOT NULL,
longitude FLOAT NOT NULL,
libelle TEXT NOT NULL,
vehicule TEXT NOT NULL,
type TEXT NOT NULL,
actif BOOLEAN NOT NULL,
voirie BOOLEAN NOT NULL,
mdate DATETIME NOT NULL);

CREATE TABLE lignesData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
coordonnees LONGTEXT NOT NULL,
libelle TEXT NOT NULL,
sens TEXT NOT NULL,
vehicule TEXT NOT NULL,
principale BOOLEAN NOT NULL,
groupe TEXT NOT NULL,
rs_sv_ligne_a INT NOT NULL,
rg_sv_arret_p_nd INT NOT NULL,
rg_sv_arret_p_na INT NOT NULL,
mdate DATETIME NOT NULL);

CREATE TABLE tronconsData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
coordonnees LONGTEXT NOT NULL,
vehicule TEXT NOT NULL,
rg_sv_arret_p_nd INT NOT NULL,
rg_sv_arret_p_na INT NOT NULL,
mdate DATETIME NOT NULL);

CREATE TABLE relationsLignesTronconsData (
rs_sv_chem_l INT NOT NULL,
rs_sv_tronc_l INT NOT NULL);

CREATE TABLE horairesData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
hor_theo DATETIME NOT NULL,
hor_app DATETIME NOT NULL,
hor_real DATETIME,
rs_sv_arret_p INT NOT NULL,
rs_sv_cours_a INT NOT NULL,
mdate DATETIME NOT NULL);

CREATE TABLE CoursesData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
rs_sv_ligne_a INT NOT NULL,
rs_sv_chem_l INT NOT NULL,
rg_sv_arret_p_nd INT NOT NULL,
rg_sv_arret_p_na INT NOT NULL,
mdate DATETIME NOT NULL);

CREATE TABLE nomCommercialData (
gid INT PRIMARY KEY NOT NULL UNIQUE,
libelle TEXT NOT NULL,
vehicule TEXT NOT NULL,
mdate DATETIME NOT NULL);



CREATE TABLE horaires (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
gid INT NOT NULL,
ligne INT NOT NULL,
arret INT NOT NULL,
direction INT NOT NULL,
horaire TEXT NOT NULL
);

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
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
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
nom TEXT,
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

CREATE TABLE situer_gares_ter (
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
vehicule TEXT NOT NULL,
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
ALTER TABLE situer_gares_ter ADD CONSTRAINT situer_gares_ter_gare_ter_gares_ter_id FOREIGN KEY (gare_ter) REFERENCES gares_ter(id);
ALTER TABLE situer_gares_ter ADD CONSTRAINT situer_gares_ter_coordonnee_coordonnees_gares_ter_id FOREIGN KEY (coordonnee) REFERENCES coordonnees_gares_ter(id);
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
ALTER TABLE horaires ADD CONSTRAINT horaires_ligne_lignes_id FOREIGN KEY (ligne) REFERENCES lignes(id);
ALTER TABLE horaires ADD CONSTRAINT horaires_arret_arrets_id FOREIGN KEY (arret) REFERENCES arrets(id);
ALTER TABLE horaires ADD CONSTRAINT horaires_direction_arrets_id FOREIGN KEY (direction) REFERENCES arrets(id);



ALTER TABLE lignesData ADD CONSTRAINT lignesData_rs_sv_ligne_a_nomCommercialData_gid FOREIGN KEY (rs_sv_ligne_a) REFERENCES nomCommercialData(gid);
ALTER TABLE lignesData ADD CONSTRAINT lignesData_rg_sv_arret_p_nd_arretsData_gid FOREIGN KEY (rg_sv_arret_p_nd) REFERENCES arretsData(gid);
ALTER TABLE lignesData ADD CONSTRAINT lignesData_rg_sv_arret_p_na_arretsData_gid FOREIGN KEY (rg_sv_arret_p_na) REFERENCES arretsData(gid);
ALTER TABLE tronconsData ADD CONSTRAINT tronconsData_rg_sv_arret_p_nd_arretsData_gid FOREIGN KEY (rg_sv_arret_p_nd) REFERENCES arretsData(gid);
ALTER TABLE tronconsData ADD CONSTRAINT tronconsData_rg_sv_arret_p_na_arretsData_gid FOREIGN KEY (rg_sv_arret_p_na) REFERENCES arretsData(gid);
ALTER TABLE relationsLignesTronconsData ADD CONSTRAINT relationsLignesTronconsData_rs_sv_chem_l_lignesData_gid FOREIGN KEY (rs_sv_chem_l) REFERENCES lignesData(gid);
ALTER TABLE relationsLignesTronconsData ADD CONSTRAINT relationsLignesTronconsData_rs_sv_tronc_l_tronconsData_gid FOREIGN KEY (rs_sv_tronc_l) REFERENCES tronconsData(gid);
ALTER TABLE horairesData ADD CONSTRAINT horairesData_rs_sv_arret_p_arretsData_gid FOREIGN KEY (rs_sv_arret_p) REFERENCES arretsData(gid);
ALTER TABLE horairesData ADD CONSTRAINT horairesData_rs_sv_cours_a_CoursesData_gid FOREIGN KEY (rs_sv_cours_a) REFERENCES CoursesData(gid);
ALTER TABLE CoursesData ADD CONSTRAINT CoursesData_rs_sv_ligne_a_nomCommercialData_gid FOREIGN KEY (rs_sv_ligne_a) REFERENCES nomCommercialData(gid);
ALTER TABLE CoursesData ADD CONSTRAINT CoursesData_rs_sv_chem_l_lignesData_gid FOREIGN KEY (rs_sv_chem_l) REFERENCES lignesData(gid);
ALTER TABLE CoursesData ADD CONSTRAINT CoursesData_rg_sv_arret_p_nd_arretsData_gid FOREIGN KEY (rg_sv_arret_p_nd) REFERENCES arretsData(gid);
ALTER TABLE CoursesData ADD CONSTRAINT CoursesData_rg_sv_arret_p_na_arretsData_gid FOREIGN KEY (rg_sv_arret_p_na) REFERENCES arretsData(gid);

ALTER TABLE stop_times ADD CONSTRAINT stop_times_stop_id_stop_stop_id FOREIGN KEY (stop_id) REFERENCES stop(stop_id);
ALTER TABLE trips ADD CONSTRAINT trips_route_id_routes_route_id FOREIGN KEY (route_id) REFERENCES routes(route_id);
ALTER TABLE trips ADD CONSTRAINT trips_service_id_calendar_service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id);
-- ALTER TABLE trips ADD CONSTRAINT stop_times_trip_id_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips(trip_id);
-- ALTER TABLE trips ADD CONSTRAINT trips_shape_id_shapes_shape_id FOREIGN KEY (shape_id) REFERENCES shapes(shape_id);
ALTER TABLE routes ADD CONSTRAINT routes_agency_id_agency_agency_id FOREIGN KEY (agency_id) REFERENCES agency(agency_id);
ALTER TABLE calendar_dates ADD CONSTRAINT calendar_dates_service_id_calendar_service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id);


