-- Insertion des données des capteurs

TRUNCATE TABLE donnees_capteurs;

LOAD DATA INFILE '/var/lib/mysql-files/P1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P2_semaine_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P2_semaine_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P3_semaine_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P3_semaine_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P4.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P5.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P6.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P7.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P8.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P9_Vers_Fac_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P9_Vers_Fac_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P9_Vers_Talence_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P9_Vers_Talence_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P10.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P11.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P12.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P13.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P14.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P17_Vers_Avenue_Schweitzer.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P17_Vers_P16.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P18.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P19_Entrée.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P19_Sortie.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P20.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P21.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P22.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P23_Vers_BEC_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P23_Vers_BEC_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P23_Vers_COSEC.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P24_Vers_Fac.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P24_Vers_Rocade.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P25.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P26_Vers_Fac_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P26_Vers_Fac_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P26_Vers_Fac_3.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P26_Vers_Rocade_1.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P26_Vers_Rocade_2.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');

LOAD DATA INFILE '/var/lib/mysql-files/P27.csv' 
INTO TABLE donnees_capteurs 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' 
IGNORE 1 LINES
(@temp_horodate, classe_vehicule, capteur)
SET horodate = STR_TO_DATE(@temp_horodate, '%Y-%m-%d %H:%i:%s.%f');