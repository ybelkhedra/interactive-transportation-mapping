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
    'nb_places_handicapes': createMap('Nombre de places handicapés', 'int'),
    'hors_voirie': createMap('Hors voirie', 'bool'),
    'prive': createMap('Privé', 'bool'),
    'nb_pts_recharge':
        createMap('Nombre de points de recharge', 'int', isSetable: false),
    'nb_pts_covoit':
        createMap('Nombre de points de covoiturage', 'int', isSetable: false),
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
    'parking_correspondant': createMap('Parking correspondant', 'int',
        isForeignKey: true, table: "parkings"),
    'type_prise': createMap('Types de prise disponibles', 'List',
        isForeignKey: true, table: "types_de_prises"),
    'puissance': createMap('Puissances', 'List',
        isForeignKey: true, table: "puissances", champs: 'puissance'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.ev_station_rounded, //ou Icons.electric_car
  },
  'types_de_prises': {
    'nom_jolie': 'Types de prises',
    'script': 'types_de_prises',
    'id': createMap('id', 'int'),
    'nom': createMap('Type de prise', 'String'),
    'icon': Icons.electrical_services,
  },
  'puissances': {
    'nom_jolie': 'Puissances',
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
    'parking_correspondant': createMap('Parking correspondant', 'int',
        isForeignKey: true, table: "parkings"),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_car,
  },
  'stations_velo': {
    'nom_jolie': 'Stations de vélo',
    'script': 'points_stationnement_velo',
    'id': createMap('id', 'int'),
    'nom': createMap('Station de vélo', 'String'),
    'nb_places': createMap('Nombre de places', 'int'),
    'securise': createMap('Sécurisée', 'bool'),
    'abrite': createMap('Abritée', 'bool'),
    'type_accroche': createMap('Types d\'accroche', 'List',
        isForeignKey: true, table: "types_accroches_velo"),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'latitude': createMap('Latitude', 'float'),
    'longitude': createMap('Longitude', 'float'),
    'icon': Icons.directions_bike,
  },
  'types_accroches_velo': {
    'nom_jolie': 'Types d\'accroches de vélo',
    'script': 'types_d_accroches_de_velo',
    'id': createMap('id', 'int'),
    'nom': createMap('Type d\'accroche', 'String'),
    'icon': Icons.directions_bike,
  },
  'pistes_velo': {
    'nom_jolie': 'Pistes de vélo',
    'script': 'pistes_cyclables',
    'id': createMap('id', 'int'),
    'type_piste': createMap('Type de piste', 'int',
        isForeignKey: true, table: "types_pistes_velo"),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'icon': Icons.directions_bike,
  },
  'types_pistes_velo': {
    'nom_jolie': 'Types de pistes de vélo',
    'script': 'types_de_pistes_cyclables',
    'id': createMap('id', 'int'),
    'nom': createMap('Type de pistes de vélo', 'String'),
    'icon': Icons.directions_bike,
  },
  'gares_ter': {
    'nom_jolie': 'Gares TER',
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
    'vehicules_freefloating': createMap('Véhicules Freefloating', 'List',
        isForeignKey: true,
        table: "vehicules_freefloating",
        champs: 'vehicule'),
    'info_complementaires': createMap('Informations complémentaires', 'String'),
    'coordonnees': createMap('Coordonnées', 'List'),
    'icon': Icons.electric_scooter,
  },
  'vehicules_freefloating': {
    'nom_jolie': 'Véhicules Freefloating',
    'script': 'vehicules_freefloating',
    'id': createMap('id', 'int'),
    'vehicule': createMap('Nom du véhicule', 'String'),
    'icon': Icons.electric_scooter,
  },
};

Map createMap(String nom, String type,
    {bool isForeignKey = false,
    String table = '',
    String champs = 'nom',
    bool isSetable = true}) {
  return {
    'nom': nom,
    'type': type,
    'isForeignKey': isForeignKey,
    'table': table,
    'champs': champs,
    'isSetable': isSetable,
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
  'Gares TER',
  'Points de Freefloat',
  'Véhicules Freefloating',
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
  'gares_ter',
  'pt_freefloat',
  'vehicules_freefloating',
];
