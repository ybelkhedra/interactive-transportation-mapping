ALTER TABLE stop_times DROP FOREIGN KEY stop_times_stop_id_stop_stop_id;
ALTER TABLE trips DROP FOREIGN KEY trips_route_id_routes_route_id;
ALTER TABLE trips DROP FOREIGN KEY trips_service_id_calendar_service_id;
-- ALTER TABLE trips DROP FOREIGN KEY stop_times_trip_id_trips_trip_id;
-- ALTER TABLE trips DROP FOREIGN KEY trips_shape_id_shapes_shape_id;
ALTER TABLE routes DROP FOREIGN KEY routes_agency_id_agency_agency_id;
ALTER TABLE calendar_dates DROP FOREIGN KEY calendar_dates_service_id_calendar_service_id;





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


ALTER TABLE stop_times ADD CONSTRAINT stop_times_stop_id_stop_stop_id FOREIGN KEY (stop_id) REFERENCES stop(stop_id);
ALTER TABLE trips ADD CONSTRAINT trips_route_id_routes_route_id FOREIGN KEY (route_id) REFERENCES routes(route_id);
ALTER TABLE trips ADD CONSTRAINT trips_service_id_calendar_service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id);
-- ALTER TABLE trips ADD CONSTRAINT stop_times_trip_id_trips_trip_id FOREIGN KEY (trip_id) REFERENCES trips(trip_id);
-- ALTER TABLE trips ADD CONSTRAINT trips_shape_id_shapes_shape_id FOREIGN KEY (shape_id) REFERENCES shapes(shape_id);
ALTER TABLE routes ADD CONSTRAINT routes_agency_id_agency_agency_id FOREIGN KEY (agency_id) REFERENCES agency(agency_id);
ALTER TABLE calendar_dates ADD CONSTRAINT calendar_dates_service_id_calendar_service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id);
