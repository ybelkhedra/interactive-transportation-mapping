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

class addFreefloating extends StatefulWidget {
  const addFreefloating({Key? key}) : super(key: key);

  @override
  State<addFreefloating> createState() => _addFreefloatingState();
}

//page qui affiche un formulaire d'ajout de parking
class _addFreefloatingState extends State<addFreefloating> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _infoComplementaireController = TextEditingController();
  final List<String> _vehiculesAutorise = [];
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();

  LatLng? _currentPosition;

  //fonction qui permet de récupérer la liste des vehicules de la base de données en se connectant à l'API datacampus-bordeaux.fr/sources/requetes/API_fluter/vehicules_freefloating.php
  Future<List<List<String>>> getVehicules() async {
    var url = Uri.https("datacampus-bordeaux.fr",
        "/sources/requetes/API_flutter/vehicules_freefloating.php");
    var response = await http.get(url);
    print("response status: ${response.statusCode}");
    print("response body: ${response.body}");
    final responseJson = json.decode(response.body);
    print("vehicules: $responseJson");
    List<List<String>> vehicules = [];
    for (var vehicule in responseJson) {
      vehicules.add([vehicule['nom'], vehicule['id']]);
    }
    return vehicules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un point de freefloating'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(
                hintText: 'Nom du point de freefloating',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            // selection d'un ou plusieurs vehicules autorisés
            FutureBuilder<List<List<String>>>(
              future: getVehicules(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (var vehicule in snapshot.data!)
                        CheckboxListTile(
                          title: Text(vehicule[0]),
                          value: _vehiculesAutorise.contains(vehicule[1]),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _vehiculesAutorise.add(vehicule[1]);
                              } else {
                                _vehiculesAutorise.remove(vehicule[1]);
                              }
                            });
                          },
                        ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            TextFormField(
              controller: _infoComplementaireController,
              decoration: const InputDecoration(
                hintText: 'Informations complémentaires',
              ),
            ),
            //latitude et longitude
            TextFormField(
              controller: _latitude,
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
            //affichage de la carte pour positionner le point de freefloating
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
                          child: const Icon(Icons.electric_scooter, size: 50),
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
    final infoComplementaires = _infoComplementaireController.text;
    final latitude = _latitude.text;
    final longitude = _longitude.text;
    //on crée un objet parking
    final parking = {
      'nom': nom,
      'infoComplementaires': infoComplementaires,
      'latitude': latitude,
      'longitude': longitude,
    };
    // //on encode l'objet parking en json
    final body = jsonEncode(parking);

    //on envoie la requête https get pour récupérer les données vers le fichier php : datacampus-bordeaux.fr/sources/requetes/API_flutter/parking_add.php
    final url = Uri.https('datacampus-bordeaux.fr',
        '/sources/requetes/API_flutter/parking_add.php', {
      'nom': nom,
      'infoComplementaires': infoComplementaires,
      'latitude': latitude,
      'longitude': longitude,
    });
    final response = await http.get(url);
    //faire une animation qui dit que le produit est ajouter et revenir a la page précédente
    Navigator.pop(context);
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _currentPosition = latlng;
      _latitude.text = _currentPosition!.latitude.toString();
      _longitude.text = _currentPosition!.longitude.toString();
      print(_currentPosition);
    });
  }
}
