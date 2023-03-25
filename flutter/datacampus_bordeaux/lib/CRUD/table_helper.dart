import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

final Map tableHelper = {
  'parkings': {
    'nom_jolie': 'Parkings',
    'script': 'parkings',
    'id': createMap('id', 'int'),
    'nom': createMap('Parkings', 'String'),
    'nb_places_max': createMap('Nombre de places max', 'int'),
    'payant': createMap('Payant', 'bool'),
    'nb_places_disponibles': createMap('Nombre de places disponibles', 'int'),
    'nb_places_handicapes': createMap('Nombre de places handicapés', 'int'),
    'hors_voirie': createMap('Hors voirie', 'bool'),
    'prive': createMap('Privé', 'bool'),
    'nb_pts_recharge': createMap('Nombre de points de recharge', 'int'),
    'nb_pts_covoit': createMap('Nombre de points de covoiturage', 'int'),
    'informations_complementaires':
        createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'icon': Icons.local_parking,
  },
  'pts_recharge': {
    'nom_jolie': 'Points de recharge',
    'script': 'points_de_charges',
    'id': createMap('id', 'int'),
    'nom': createMap('Point de recharge', 'String'),
    'parking_correspondant':
        createMap('Parking correspondant', 'int', isForeignKey: true),
    'type_prise': createMap('Types de prise disponibles', 'List'),
    'puissance': createMap('Puissances', 'List'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.ev_station_rounded, //ou Icons.electric_car
  },
  'types_de_prises': {
    'nom_jolie': 'Types de prises' ' A FINIR',
    'script': 'types_de_prises', //not made yet
    'id': createMap('id', 'int'),
    'nom': createMap('Type de prise', 'String'),
    'icon': Icons.electrical_services,
  },
  'puissances': {
    'nom_jolie': 'Puissances' ' A FINIR',
    'script': 'puissances',
    'id': createMap('id', 'int'),
    'puissance': createMap('Puissance', 'float'),
    'icon': Icons.power,
  },
  'pts_covoit': {
    'nom_jolie': 'Points de covoiturage',
    'script': 'points_de_covoiturage',
    'id': createMap('id', 'int'),
    'nom': createMap('Point de covoiturage', 'String'),
    'nombre_de_places': createMap('Nombre de places', 'int'),
    'parking_correspondant':
        createMap('Parking correspondant', 'int', isForeignKey: true),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_car,
  },
  'stations_velo': {
    'nom_jolie': 'Stations de vélo',
    'script': 'points_stationnement_velo',
    'id': createMap('id', 'int'),
    'nb_places': createMap('Nombre de places', 'int'),
    'securise': createMap('Sécurisée', 'bool'),
    'abrite': createMap('Abritée', 'bool'),
    'type_accroche': createMap('Type d\'accroche', 'List'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_bike,
  },
  'types_accroches_velo': {
    'nom_jolie': 'Types d\'accroches de vélo' ' A FINIR',
    'script': 'types_d_accroches_de_velo', //not made yet
    'id': createMap('id', 'int'),
    'nom': createMap('Type d\'accroche', 'String'),
    'icon': Icons.directions_bike,
  },
  'pistes_velo': {
    'nom_jolie': 'Pistes de vélo' ' A FINIR',
    'script': 'pistes_cyclables', //ne fonctionne pas
    'id': createMap('id', 'int'),
    'type_piste': createMap('Type de piste', 'int', isForeignKey: true),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'icon': Icons.directions_bike,
  },
  'types_pistes_velo': {
    'nom_jolie': 'Types de pistes de vélo' ' A FINIR',
    'script': 'types_de_pistes_cyclables', //not made yet
    'id': createMap('id', 'int'),
    'nom': createMap('Type de pistes de vélo', 'String'),
    'icon': Icons.directions_bike,
  },
  'lignes_cars': {
    'nom_jolie': 'Lignes de cars',
    'script': 'lignes_cars',
    'id': createMap('id', 'int'),
    'numero': createMap('Nom', 'int'),
    'depart': createMap('Départ', 'int', isForeignKey: true),
    'arret_cars_depart': createMap('Arrêts de départ', 'List'),
    'destination': createMap('Déstination', 'int', isForeignKey: true),
    'arret_cars_destination': createMap('Arrêts de destination', 'List'),
    'car_express': createMap('Car express', 'bool'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap(
        'Longitude', 'float'), //PROBLEME CA DEVRAIT ETRE DES COORDONNES NON ?
    'icon': Icons.directions_bus_filled_outlined,
  },
  'arrets_cars': {
    'nom_jolie': 'Arrêts de cars' ' A FINIR',
    'script': 'arrets_cars', //bug
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'ligne_car': createMap('Lignes de car', 'List'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_bus_filled_outlined,
  },
  'gares_ter': {
    'nom_jolie': 'Gares TER' ' A FINIR',
    'script': 'gares_ter', //probleme de requetes sql ??? + script marche pas
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.train,
  },
  'pt_freefloat': {
    'nom_jolie': 'Points de Freefloat',
    'script': 'stations_freefloating',
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'vehicules_freefloating': createMap('Véhicules Freefloating', 'List'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'icon': Icons.electric_scooter,
  },
  'vehicules_freefloating': {
    'nom_jolie': 'Véhicules Freefloating' ' A FINIR',
    'script': 'vehicules_freefloating', //pas fait
    'id': createMap('id', 'int'),
    'vehicule': createMap('Nom du véhicule', 'String'),
    'icon': Icons.electric_scooter,
  },
  'stations_vcube': {
    'nom_jolie': 'Stations Vcube' ' A FINIR',
    'script': 'stations_vcube', //pas fait
    'id': createMap('id', 'int'),
    'nom': createMap('Nom de la station vcube', 'String'),
    'nb_velos_max': createMap('Nombre de vélos max', 'int'),
    'nb_velos_dispo': createMap('Nombre de vélos disponibles', 'int'),
    'velos_electriques': createMap('Vélos électriques', 'bool'),
    'vcube_plus': createMap('Vcube plus', 'bool'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'arrets_proximite': createMap('Arrêts à proximité', 'List'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.electric_bike_outlined,
  },
  'arrets': {
    'nom_jolie': 'Arrêts',
    'script': 'arrets_perso',
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'vehicule': createMap('Véhicule', 'String'),
    'station_vcube_proximite':
        createMap('Station Vcube à proximité', 'int', isForeignKey: true),
    'ligne': createMap('Ligne', 'List'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_bus,
  },
  'lignes': {
    'nom_jolie': 'Lignes',
    'script': 'lignes', //info complémentaires renvoie null ???
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'direction': createMap('Direction', 'int', isForeignKey: true),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'type': createMap('Type', 'String'),
    'icon': Icons.directions_bus,
  },
  'types_lignes': {
    'nom_jolie': 'Types de lignes' ' A FINIR',
    'script': 'types_de_lignes', // pas fait
    'id': createMap('id', 'int'),
    'nom': createMap('Nom', 'String'),
    'icon': Icons.directions_bus,
  },
};

Map createMap(String nom, String type,
    {bool isForeignKey = false, Map otherTables = const {}}) {
  return {
    'nom': nom,
    'type': type,
    'isForeignKey': isForeignKey,
  };
}

List<String> getPrettyTablesNames() {
  return nomsJolies;
}

List<String> getTablesNames() {
  return nomsTables;
}

List<SidebarXItem> getIcons() {
  List<SidebarXItem> icons = [];
  for (var i = 0; i < nomsTables.length; i++) {
    icons.add(SidebarXItem(
        icon: tableHelper[nomsTables[i]]['icon'], label: nomsJolies[i]));
  }
  return icons;
}

final List<String> nomsJolies = [
  'Parkings',
  'Points de recharge',
  'Types de prise',
  'Puissances',
  'Points de covoiturage',
  'Stations de vélo',
  'Types d\'accroche de vélo',
  'Pistes de vélo',
  'Types de pistes de vélo',
  'Lignes de car',
  'Arrêts de car',
  'Gares TER',
  'Points de Freefloat',
  'Véhicules Freefloating',
  'Stations Vcube',
  'Arrêts',
  'Lignes',
  'Types de ligne',
];

final List<String> nomsTables = [
  'parkings',
  'pts_recharge',
  'types_de_prises',
  'puissances',
  'pts_covoit',
  'stations_velo',
  'types_accroches_velo',
  'pistes_velo',
  'types_pistes_velo',
  'lignes_cars',
  'arrets_cars',
  'gares_ter',
  'pt_freefloat',
  'vehicules_freefloating',
  'stations_vcube',
  'arrets',
  'lignes',
  'types_lignes',
];
