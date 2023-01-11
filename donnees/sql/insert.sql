INSERT INTO parkings (nom, payant, handicape, hors_voirie, informations_complementaires) VALUES ('Parking Pessac Centre', 1, 1, 0, 'Parking souterrain de 200 places');

INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8071, -0.6446);
INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8072, -0.6447);
INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8073, -0.6448);
INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8074, -0.6449);

INSERT INTO emplacements_parkings (point, reference) VALUES (1, 1);
INSERT INTO emplacements_parkings (point, reference) VALUES (2, 1);
INSERT INTO emplacements_parkings (point, reference) VALUES (3, 1);
INSERT INTO emplacements_parkings (point, reference) VALUES (4, 1);






INSERT INTO parkings (nom, payant, handicape, hors_voirie, informations_complementaires) VALUES ('Parking Pessac Gare', 0, 1, 0, 'Parking gratuit et accessible aux personnes à mobilité réduite');

INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8091, -0.6429);
INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8092, -0.6428);
INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8093, -0.6427);

INSERT INTO emplacements_parkings (point, reference) VALUES (5, 2);
INSERT INTO emplacements_parkings (point, reference) VALUES (6, 2);
INSERT INTO emplacements_parkings (point, reference) VALUES (7, 2);




INSERT INTO points_de_charges (nom, payant, prive) VALUES ('Chargeur Pessac Centre', 1, 0);

INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8061, -0.6439);

INSERT INTO emplacement_pdc (point, reference) VALUES (8, 1);



INSERT INTO points_de_charges (nom, payant, prive) VALUES ('Chargeur Pessac Gare', 0, 1);

INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8082, -0.6425);

INSERT INTO emplacement_pdc (point, reference) VALUES (9, 2);


INSERT INTO points_de_charges (nom, payant, prive) VALUES ('Chargeur Pessac Université', 1, 0);

INSERT INTO coordonnees_gps (latitude, longitude) VALUES (44.8053, -0.6457);

INSERT INTO emplacement_pdc (point, reference) VALUES (10, 3);




