DROP TRIGGER IF EXISTS delete_stations_velo;

DELIMITER $$
CREATE TRIGGER delete_stations_velo BEFORE DELETE ON stations_velo
FOR EACH ROW
BEGIN
DELETE FROM situer_stations_velo WHERE pt_velo = OLD.id;
END$$
DELIMITER ;