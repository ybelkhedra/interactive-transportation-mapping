INSERT INTO parkings (nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('Parking 1', 100, 50, 0, 10, 0, 0, 'Parking 1');
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (44.8171, -0.6152219);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (1, 1);

INSERT INTO parkings (nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES ('Parking 2', 100, 50, 0, 10, 0, 0, 'Parking 1');
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (44.8181, -0.6152219);
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (44.8191, -0.6152219);
INSERT INTO coordonnees_parkings (latitude, longitude) VALUES (44.8191, -0.6162219);

INSERT INTO situer_parkings (parking, coordonnee) VALUES (2, 2);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (2, 3);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (2, 4);


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


INSERT INTO arrets (nom, vehicule, info_complementaires, station_vcube_proximite) VALUES ('Arts et Metiers', 'Tramway', 'nil', 1);
INSERT INTO coordonnees_arrets (latitude, longitude) VALUES (44.81814, -0.615221);
INSERT INTO situer_arrets (arret, coordonnee) VALUES (1, 1);

INSERT INTO arrets (nom, vehicule, info_complementaires, station_vcube_proximite) VALUES ('Bethanie', 'Bus', 'nil', 1);
INSERT INTO coordonnees_arrets (latitude, longitude) VALUES (44.81814, -0.613221);
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

INSERT INTO types_lignes (nom) VALUES ('Liane');
INSERT INTO lignes (nom, direction, type, info_complementaires) VALUES ('Liane 9', 1, 2, 'nil');
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.808806, -0.593735);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.80992, -0.595816);
INSERT INTO coordonnees_lignes (latitude, longitude) VALUES (44.801328, -0.600099);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (4, 8);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (4, 9);
INSERT INTO situer_lignes (ligne, coordonnee) VALUES (4, 10);

INSERT INTO desservir (arret, ligne, heure_premier_passage, heure_dernier_passage, heure_prochain_passage, frequence, diurne, nocturne)
VALUES (1, 4, CURRENT_TIME, CURRENT_TIME, CURRENT_TIME, CURRENT_TIME, 1, 0);



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


-- Insertion des vrais parkings repérés sur le campus

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (1, 'Parking Université', 250, 250, 0, 0, 1, 0, '351 Cr de la Libération, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (1, 44.807919, -0.599133);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (1, 1);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (2, 'Parking IMB', 110, 110, 0, 0, 1, 0, 'A39, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (2, 44.809612, -0.592534);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (2, 2);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (3, 'Parking bâtiment A4', 110, 110, 0, 0, 1, 0, '29 Av. Roul, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (3, 44.807360, -0.592937);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (3, 3);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (4, 'Parking stade de Notre Dame de Sévigné', 140, 140, 0, 0, 1, 0, 'C1, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (4, 44.810810, -0.594487);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (4, 4);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (5, 'Parking bâtiment A12', 260, 260, 0, 0, 1, 0, 'A12, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (5, 44.807419, -0.596523);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (5, 5);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (6, 'Parking Béthanie', 160, 160, 0, 0, 1, 0, '144 Av. Roul, 33400 Talence');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (6, 44.806307, -0.599201);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (6, 6);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (7, 'Parking PolymerExpert', 60, 60, 0, 0, 1, 1, '3 All. du Doyen Georges Brus, 33600 Pessac');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (7, 44.793479, -0.623359);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (7, 7);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (8, 'Parking Cluster Aquitaine Robotics', 110, 110, 0, 0, 1, 0, 'Parc Scientifique Unitec, 6 All. du Doyen Georges Brus, 33600 Pessac');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (8, 44.794073, -0.624431);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (8, 8);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (9, 'Parking Cosec', 180, 180, 0, 0, 1, 0, '8 Av. Jean Babin, 33600 Pessac');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (9, 44.791010, -0.621348);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (9, 9);

INSERT INTO parkings (id, nom, nb_places_max, nb_places_disponibles, payant, nb_places_handicapes, hors_voirie, prive, informations_complementaires) VALUES (10, 'Parking', 100, 100, 0, 0, 1, 0, '18 Av. Jean Babin, 33600 Pessac');
INSERT INTO coordonnees_parkings (id, latitude, longitude) VALUES (10, 44.791882, -0.622788);
INSERT INTO situer_parkings (parking, coordonnee) VALUES (10, 10);


-- Insertion des capteurs

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 1", 'caméra', 44.793676, -0.608054);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 2", 'radar TagMaster', 44.795955, -0.606845);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 3", 'radar TagMaster', 44.798725, -0.604840);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 4", 'double radar Viking (1 par sens)', 44.801930, -0.598160);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 5", 'simple radar Viking (pour les 2 sens)', 44.805100, -0.601285);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 6", 'caméra', 44.806624, -0.600472);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 7", 'caméra', 44.806329, -0.600102);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 8", 'caméra', 44.807904, -0.598249);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 9", 'tube Mixtra', 44.808745, -0.596255);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 10", 'caméra', 44.809965, -0.595267);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 11", 'tube Mixtra', 44.809855, -0.594220);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 12", 'caméra', 44.809073, -0.592110);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 13", 'caméra', 44.807627, -0.603279);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 14", 'caméra', 44.805924, -0.606976);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 15", 'tube cycliste Delta', 44.804900, -0.605485);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 16 (sans données)", 'caméra', 44.800822, -0.609455);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 17", 'double radar Viking (1 par sens)', 44.803100, -0.610180);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 18", 'caméra', 44.802224, -0.612889);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 19", 'tube Mixtra', 44.799970, -0.616420);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 20", 'caméra', 44.797881, -0.619399);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 21", 'caméra', 44.796562, -0.620754);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 22", 'caméra', 44.793596, -0.623093);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 23", 'tube Mixtra', 44.792770, -0.619310);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 24", 'tube Mixtra', 44.791040, -0.621735);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 25", 'caméra', 44.790336, -0.613347);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 26", 'tube Mixtra', 44.792600, -0.613200);

INSERT INTO capteurs(nom, type_capteur, latitude, longitude) VALUES ("Poste 27", 'caméra', 44.796368, -0.609520);