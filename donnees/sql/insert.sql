INSERT INTO parkings (nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('Parking 1', 100, 50, 0, 10, 0, 0, 'Parking 1');
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (48.856614, 2.3522219);
INSERT INTO situer_parkings (id, parking, coordonnee) VALUES (1, 1, 1);

INSERT INTO pts_recharge (nom, parking_correspondant, info_complementaires) VALUES ('Point de recharge 1', 1, 'Info complémentaire 1');
INSERT INTO coordonnees_pts_recharge (id, latitude, longitude) VALUES (1, 48.856614, 2.3522219);
INSERT INTO situer_pts_recharge (id, point_de_recharge, coordonnee) VALUES (1, 1, 1);

INSERT INTO puissances (puissance) VALUES (3.7);
INSERT INTO types_de_prises (nom) VALUES ('Type 1');
INSERT INTO compatible (type_de_prise, point_de_recharge) VALUES (1, 1);
INSERT INTO recharger (puissance, point_de_recharge) VALUES (1, 1);

INSERT INTO pts_covoit (nom, nombre_de_places, parking_correspondant, info_complementaires) VALUES ('Parking de la gare', 5, 1, 'Parking de la gare de truc');
INSERT INTO coordonnees_pts_covoit (latitude, longitude) VALUES (48.856614, 2.3522219000000177);
INSERT INTO situer_pts_covoit (point_de_covoiturage, coordonnee) VALUES (1, 1);

INSERT INTO stations_velo (nb_places, securise, abrite, info_complementaires) VALUES (10, 1, 1, "test");
INSERT INTO coordonnees_stations_velo (latitude, longitude) VALUES (48.856614, 2.3522219000000177);
INSERT INTO situer_stations_velo (pt_velo, coordonnee) VALUES (1, 1);

INSERT INTO types_accroches_velo (nom) VALUES ('Vélo classique');
INSERT INTO types_accroches_velo (nom) VALUES ('Vélo autre');

INSERT INTO installer (station_velo, type_accroche) VALUES (1, 1);
INSERT INTO installer (station_velo, type_accroche) VALUES (1, 2);


INSERT INTO types_pistes_velo (nom) VALUES ('piste cyclable');
INSERT INTO pistes_velo (type_piste, info_complementaires) VALUES (1, 'piste cyclable');
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (1, 48.111111, 2.222222);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (2, 48.333333, 2.444444);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (3, 48.555555, 2.666666);
INSERT INTO coordonnees_pistes_velo (id, latitude, longitude) VALUES (4, 48.777777, 2.888888);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 1);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 2);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 3);
INSERT INTO situer_pistes_velo (piste_velo, coordonnee) VALUES (1, 4);

INSERT INTO arrets_cars (nom, info_complementaires) VALUES ('Gare de Pessax', 'nil');
INSERT INTO coordonnees_arrets_cars (latitude, longitude) VALUES (48.914, 2.372221);
INSERT INTO situer_arrets_cars (arret_car, coordonnee) VALUES (1, 1);


INSERT INTO lignes_cars (numero, depart, destination, car_express, info_complementaires) VALUES (1, 1, 1, 0, 'test');
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (48.856614, 2.352221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (48.856614, 2.352221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (48.856614, 2.352221);
INSERT INTO coordonnees_lignes_cars (latitude, longitude) VALUES (48.856614, 2.352221);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 1);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 2);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 3);
INSERT INTO situer_lignes_cars (ligne_car, coordonnee) VALUES (1, 4);








