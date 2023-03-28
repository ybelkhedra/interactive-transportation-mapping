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
INSERT INTO coordonnees_stations_velo (latitude, longitude) VALUES (44.788326, -0.596485);
INSERT INTO situer_stations_velo (pt_velo, coordonnee) VALUES (1, 1);

INSERT INTO types_accroches_velo (nom) VALUES ('Vélo classique');
INSERT INTO types_accroches_velo (nom) VALUES ('Vélo autre');

INSERT INTO installer (station_velo, type_accroche) VALUES (1, 1);
INSERT INTO installer (station_velo, type_accroche) VALUES (1, 2);


INSERT INTO types_pistes_velo (nom) VALUES ('piste cyclable');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable1');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable2');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable3');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable4');

INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.817156, -0.617791);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.813771, -0.622004);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.815886, -0.623101);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (13, 10);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (28, 16);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (14, 11);

INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.843340, -0.599602);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.831474, -0.598435);
INSERT INTO coordonnees_pistes_velo (latitude, longitude) VALUES (44.821408, -0.582957);

INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 1);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 2);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 3);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (2, 4);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (2, 5);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (3, 6);

INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (4, 7);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (4, 8);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (4, 9);

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

INSERT INTO stations_vcube (nom, nb_velos_max, nb_velos_dispo, vcube_plus, velos_electriques, info_complementaires) VALUES ('vcube bethanie', 31, 13, 1, 0, 'nil');
INSERT INTO coordonnees_stations_vcube (latitude, longitude) VALUES (44.91815, -0.6254321);
INSERT INTO situer_stations_vcube (station_vcube, coordonnee) VALUES (2, 2);


INSERT INTO arrets (nom, info_complementaires, station_vcube_proximite) VALUES ('Arts et Metiers', 'nil', 1);
INSERT INTO coordonnees_arrets (latitude, longitude) VALUES (44.81814, -0.615221);
INSERT INTO situer_arrets (arret, coordonnee) VALUES (1, 1);

INSERT INTO arrets (nom, info_complementaires, station_vcube_proximite) VALUES ('Bethanie', 'nil', 1);
INSERT INTO coordonnees_arrets (latitude, longitude) VALUES (45.81814, -0.625221);
INSERT INTO situer_arrets (arret, coordonnee) VALUES (2, 2);


INSERT INTO types_lignes (nom) VALUES ('Tramway');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne A', 1, 1, 'nil');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne B', 1, 1, 'nil');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Ligne C', 1, 1, 'nil');
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.806806, -0.591735);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.801792, -0.593816);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.799328, -0.598099);
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
INSERT INTO coordonnees_gares_ter (latitude, longitude) VALUES (44.805251, -0.6075868);
INSERT INTO situer_gares_ter (gare_ter, coordonnee) VALUES (1,1);

INSERT INTO pt_freefloat(nom, info_complementaires) VALUES ("Victoire", 'nil');
INSERT INTO coordonnees_pt_freefloat(latitude, longitude) VALUES (44.789602, -0.605252);
INSERT INTO situer_pt_freefloat(pt_freefloat, coordonnee) VALUES (1,1);

INSERT INTO pt_freefloat(nom, info_complementaires) VALUES ("Stade thouars", 'nil');
INSERT INTO coordonnees_pt_freefloat(latitude, longitude) VALUES (44.792168, -0.597060);
INSERT INTO situer_pt_freefloat(pt_freefloat, coordonnee) VALUES (2,2);

INSERT INTO vehicules_freefloating(vehicule) VALUES ("trotinette");
INSERT INTO vehicules_freefloating(vehicule) VALUES ("scooter");

INSERT INTO autoriser(pt_freefloat, vehicule) VALUES (1,1);
INSERT INTO autoriser(pt_freefloat, vehicule) VALUES (1,2);

INSERT INTO autoriser(pt_freefloat, vehicule) VALUES (2,1);
INSERT INTO autoriser(pt_freefloat, vehicule) VALUES (2,2);