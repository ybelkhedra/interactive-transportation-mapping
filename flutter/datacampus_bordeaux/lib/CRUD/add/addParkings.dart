import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../parkings.dart';

class addParkings extends StatefulWidget {
  const addParkings({Key? key}) : super(key: key);

  @override
  State<addParkings> createState() => _addParkingsState();
}

//page qui affiche un formulaire d'ajout de parking
class _addParkingsState extends State<addParkings> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _nbPlacesMaxController = TextEditingController();
  final _nbPlacesDisponiblesController = TextEditingController();
  final _nbPlacesHandicapesController = TextEditingController();
  final _infoComplementaireController = TextEditingController();
  bool _boolPayant = false;
  bool _boolHorsVoirie = false;
  bool _boolPrive = false;
  //tableau qui contient les coordonnées de la position du parking (latitude, longitude)
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  int _nbClics = 0;

  LatLng? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un parking'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(
                hintText: 'Nom du parking',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nbPlacesMaxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nombre de places max',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre de places max';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nbPlacesDisponiblesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nombre de places disponibles',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre de places max';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nbPlacesHandicapesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nombre de places handicapées',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre de places handicapées';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _infoComplementaireController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Informations complémentaires',
              ),
            ),
            //checkbox pour savoir si le parking est payant ou non
            CheckboxListTile(
              title: const Text('Payant'),
              value: _boolPayant,
              onChanged: (bool? value) {
                setState(() {
                  _boolPayant = value!;
                });
              },
            ),
            //checkbox pour savoir si le parking est hors voirie ou non
            CheckboxListTile(
              title: const Text('Hors voirie'),
              value: _boolHorsVoirie,
              onChanged: (bool? value) {
                setState(() {
                  _boolHorsVoirie = value!;
                });
              },
            ),
            //checkbox pour savoir si le parking est privé ou non
            CheckboxListTile(
              title: const Text('Privé'),
              value: _boolPrive,
              onChanged: (bool? value) {
                setState(() {
                  _boolPrive = value!;
                });
              },
            ),
            //textformfield pour entrer les coordonnées du parking
            TextFormField(
              controller: _latitude,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Latitude',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une latitude';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _longitude,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Longitude',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une longitude';
                }
                return null;
              },
            ),
            //afficher une carte pour choisir les coordonnées du parking,  le marker doit pouvoir bouger pour choisir les coordonnées du parking et mettre a jour le champs latitude et longitude
            ElevatedButton(
              onPressed: () {
                addParking(context);
              },
              child: const Text('Ajouter'),
            ),
            SizedBox(
              height: 200,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(
                    double.parse(48.8534.toString()),
                    double.parse(2.3488.toString()),
                  ),
                  zoom: 15.0,
                  onTap: _handleTap,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentPosition ??
                            LatLng(
                              double.parse(48.8534.toString()),
                              double.parse(2.3488.toString()),
                            ),
                        builder: (ctx) => Container(
                          child: const Icon(Icons.local_parking_outlined,
                              size: 50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //fonction qui ajoute le parking à la base de données
  Future<void> addParking(BuildContext context) async {
    //on récupère les données du formulaire
    final nom = _nomController.text;
    final nbPlacesMax = _nbPlacesMaxController.text;
    final infoComplementaires = _infoComplementaireController.text;
    final nbPlacesDisponibles = _nbPlacesDisponiblesController.text;
    final nbPlacesHandicapes = _nbPlacesHandicapesController.text;
    final latitude = _latitude.text;
    final longitude = _longitude.text;
    final payant = _boolPayant == true ? 1 : 0;
    final horsVoirie = _boolHorsVoirie == true ? 1 : 0;
    final prive = _boolPrive == true ? 1 : 0;
    //on crée un objet parking
    final parking = {
      'nom': nom,
      'nbPlacesMax': nbPlacesMax,
      'infoComplementaires': infoComplementaires,
      'nbPlacesHandicapes': nbPlacesHandicapes,
      'nbPlacesDisponibles': nbPlacesDisponibles,
      'boolPayant': payant.toString(),
      'boolHorsVoirie': horsVoirie.toString(),
      'boolPrive': prive.toString(),
      'latitude': latitude,
      'longitude': longitude,
    };
    // //on encode l'objet parking en json
    final body = jsonEncode(parking);
    // print(body);

    //on envoie la requête https get pour récupérer les données vers le fichier php : datacampus-bordeaux.fr/sources/requetes/API_flutter/parking_add.php
    final url = Uri.https('datacampus-bordeaux.fr',
        '/sources/requetes/API_flutter/parking_add.php', {
      'nom': nom,
      'nbPlacesMax': nbPlacesMax,
      'infoComplementaires': infoComplementaires,
      'nbPlacesHandicapes': nbPlacesHandicapes,
      'nbPlacesDisponibles': nbPlacesDisponibles,
      'boolPayant': payant.toString(),
      'boolHorsVoirie': horsVoirie.toString(),
      'boolPrive': prive.toString(),
      'latitude': latitude,
      'longitude': longitude,
    });
    // print(url);
    final response = await http.get(url);
    //print(response.statusCode);
    //print(response.body);
    //faire une animation qui dit que le produit est ajouter et revenir a la page précédente
    Navigator.pop(context);
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _currentPosition = latlng;
      _latitude.text = _currentPosition!.latitude.toString();
      _longitude.text = _currentPosition!.longitude.toString();
      //print(_currentPosition);
      _nbClics++;
    });
  }
}
