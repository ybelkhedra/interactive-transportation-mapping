INSERT INTO parkings (nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('Parking 1', 100, 50, 0, 10, 0, 0, 'Parking 1');
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (44.8181, -0.6152219);
INSERT INTO situer_parkings (id, parking, coordonnee) VALUES (1, 1, 1);

INSERT INTO pts_recharge (nom, parking_correspondant, info_complementaires) VALUES ('Point de recharge 1', 1, 'Info complémentaire 1');
INSERT INTO coordonnees_pts_recharge (id, latitude, longitude) VALUES (1, 44.8181, -0.6152219);
INSERT INTO situer_pts_recharge (id, point_de_recharge, coordonnee) VALUES (1, 1, 1);

INSERT INTO puissances (puissance) VALUES (3.7);
INSERT INTO types_de_prises (nom) VALUES ('Type 1');
INSERT INTO compatible (type_de_prise, point_de_recharge) VALUES (1, 1);
INSERT INTO recharger (puissance, point_de_recharge) VALUES (1, 1);

INSERT INTO pts_covoit (nom, nombre_de_places, parking_correspondant, info_complementaires) VALUES ('Parking de la gare', 5, 1, 'Parking de la gare de truc');
INSERT INTO coordonnees_pts_covoit (latitude, longitude) VALUES (44.8181, -0.6152219000000177);
INSERT INTO situer_pts_covoit (point_de_covoiturage, coordonnee) VALUES (1, 1);

INSERT INTO stations_velo (nb_places, securise, abrite, info_complementaires) VALUES (10, 1, 1, "test");
INSERT INTO coordonnees_stations_velo (latitude, longitude) VALUES (44.8181, -0.6152219000000177);
INSERT INTO situer_stations_velo (pt_velo, coordonnee) VALUES (1, 1);

INSERT INTO types_accroches_velo (nom) VALUES ('Vélo classique');
INSERT INTO types_accroches_velo (nom) VALUES ('Vélo autre');

INSERT INTO installer (station_velo, type_accroche) VALUES (1, 1);
INSERT INTO installer (station_velo, type_accroche) VALUES (1, 2);


INSERT INTO types_pistes_velo (nom) VALUES ('piste cyclable');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable1');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable2');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable3');
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (1, 44.8181111, -0.6152222);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (2, 36, 64);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (3, 42, 58);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (4, 13, 10);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (5, 28, 16);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (6, 14, 11);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 1);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 2);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 3);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (2, 4);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (2, 5);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (3, 6);

INSERT INTO arrets_cars (nom, info_complementaires) VALUES ('Gare de Pessax', 'nil');
INSERT INTO coordonnees_arrets_cars (latitude, longitude) VALUES (44.81814, -0.61522221);
INSERT INTO situer_arrets_cars (arret_car, coordonnee) VALUES (1, 1);


INSERT INTO lignes_cars (numero, depart, destination, car_express, info_complementaires) VALUES (1, 1, 1, 0, 'test');
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (44.8181, -0.615221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (44.8181, -0.615221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (44.8181, -0.615221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (44.8181, -0.615221);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 1);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 2);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 3);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 4);

INSERT INTO desservir_car (ligne_car, arret_car) VALUES (1, 1);




INSERT INTO stations_vcube (nom, nb_velos_max, nb_velos_dispo, vcube_plus, velos_electriques, info_complementaires) VALUES ('vcube Arts et Metiers', 30, 12, 1, 0, 'nil');
INSERT INTO coordonnees_stations_vcube (latitude, longitude) VALUES (44.81815, -0.6154321);
INSERT INTO situer_stations_vcube (station_vcube, coordonnee) VALUES (1, 1);

 

INSERT INTO arrets (nom, station_vcube_proximite, info_complementaires) VALUES ('Arts et Metiers', 1, 'nil');
INSERT INTO coordonnees_arrets (latitude, longitude) VALUES (44.81814, -0.615221);
INSERT INTO situer_arrets (arret, coordonnee) VALUES (1, 1);


INSERT INTO types_lignes (nom) VALUES ('Tramway');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne A', 1, 1, 'nil');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne B', 1, 1, 'nil');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne C', 1, 1, 'nil');
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.818124, -0.615221);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (13, 56);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (4, 2);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (43, 125);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (128, 256);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (90, 11);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (7, 7);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (1, 1);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (1, 2);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (1, 3);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (2, 4);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (2, 5);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (3, 6);

INSERT INTO desservir (arret, ligne, heure_premier_passage, heure_dernier_passage, heure_prochain_passage, frequence, diurne, nocturne)
VALUES (1, 1, CURRENT_TIME, CURRENT_TIME, CURRENT_TIME, CURRENT_TIME, 1, 0);

INSERT INTO gares_ter (nom, info_complementaires) VALUES ('Gare de Pessac', 'nil');
INSERT INTO coordonnees_gares_ter (latitude, longitude) VALUES (48.624, 2.394222);
INSERT INTO siter_gares_ter (gare_ter, coordonnee) VALUES (1,1);