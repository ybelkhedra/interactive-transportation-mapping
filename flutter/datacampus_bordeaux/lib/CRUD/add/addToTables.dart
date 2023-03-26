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
import '../table_helper.dart';
import '../parkings.dart';
import 'addParkings.dart';

class AddToTable extends StatefulWidget {
  final String tableName;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _boolControllers = {};
  bool isCoordonnees = false;
  AddToTable({Key? key, required this.tableName}) : super(key: key) {
    for (String key in tableHelper[tableName].keys) {
      if (isValidKey(key)) {
        if (tableHelper[tableName][key]["type"] == 'bool') {
          _boolControllers[key] = false;
        } else if (tableHelper[tableName][key]["type"] == 'int' ||
            tableHelper[tableName][key]["type"] == 'String') {
          _controllers[key] = TextEditingController();
        } else if (key == 'coordonnees' || key == 'latitude') {
          _controllers['latitude'] = TextEditingController();
          _controllers['longitude'] = TextEditingController();
          isCoordonnees = true;
        }
      }
    }
  }

  bool isValidKey(String key) {
    return key != 'nom_jolie' &&
        key != 'script' &&
        key != 'id' &&
        key != 'icon' &&
        tableHelper[tableName][key]["isSetable"];
  }

  @override
  State<AddToTable> createState() => _AddToTableState();
}

//page qui affiche un formulaire d'ajout de parking
class _AddToTableState extends State<AddToTable> {
  final _formKey = GlobalKey<FormState>();
  //tableau qui contient les coordonnées de la position du parking (latitude, longitude)
  int _nbClics = 0;
  LatLng? _currentPosition;
  double lat = 44.79517;
  double long = -0.603537;

  Widget makeForm(String key) {
    String type = '';
    if (widget.isValidKey(key)) {
      type = tableHelper[widget.tableName][key]["type"];
    }
    if (type == 'int' ||
        type == 'String' ||
        (type == 'float' && key != 'latitude' && key != 'longitude')) {
      return TextFormField(
        controller: widget._controllers[key],
        decoration: InputDecoration(
          labelText: tableHelper[widget.tableName][key]["nom"],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez remplir ce champ';
          }
          return null;
        },
      );
    } else if (type == 'bool') {
      return CheckboxListTile(
        title: Text('${tableHelper[widget.tableName][key]["nom"]}'),
        value: widget._boolControllers[key],
        onChanged: (bool? value) {
          setState(() {
            widget._boolControllers[key] = value!;
          });
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    String nomJolie = tableHelper[widget.tableName]!['nom_jolie'];
    if (widget.tableName == "parkings") {
      return const addParkings();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un $nomJolie'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
                for (String key in tableHelper[widget.tableName].keys)
                  makeForm(key),
              ] +
              [
                if (widget.isCoordonnees)
                  TextFormField(
                    controller: widget._controllers['latitude'],
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
              ] +
              [
                if (widget.isCoordonnees)
                  TextFormField(
                    controller: widget._controllers['longitude'],
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
                  )
              ] +
              [
                ElevatedButton(
                  onPressed: () {
                    addData(context);
                  },
                  child: const Text('Ajouter'),
                )
              ] +
              [
                if (widget.isCoordonnees)
                  SizedBox(
                    height: 200,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                          double.parse(lat.toString()),
                          double.parse(long.toString()),
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
                                    double.parse(lat.toString()),
                                    double.parse(long.toString()),
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
                  )
              ],
        ),
      ),
    );
  }

  Future<void> addData(BuildContext context) async {}

  // //fonction qui ajoute le parking à la base de données
  // Future<void> addParking(BuildContext context) async {
  //   //on récupère les données du formulaire
  //   final nom = _nomController.text;
  //   final nbPlacesMax = _nbPlacesMaxController.text;
  //   final infoComplementaires = _infoComplementaireController.text;
  //   final nbPlacesDisponibles = _nbPlacesDisponiblesController.text;
  //   final nbPlacesHandicapes = _nbPlacesHandicapesController.text;
  //   final latitude = _latitude.text;
  //   final longitude = _longitude.text;
  //   final payant = _boolPayant == true ? 1 : 0;
  //   final horsVoirie = _boolHorsVoirie == true ? 1 : 0;
  //   final prive = _boolPrive == true ? 1 : 0;
  //   //on crée un objet parking
  //   final parking = {
  //     'nom': nom,
  //     'nbPlacesMax': nbPlacesMax,
  //     'infoComplementaires': infoComplementaires,
  //     'nbPlacesHandicapes': nbPlacesHandicapes,
  //     'nbPlacesDisponibles': nbPlacesDisponibles,
  //     'boolPayant': payant.toString(),
  //     'boolHorsVoirie': horsVoirie.toString(),
  //     'boolPrive': prive.toString(),
  //     'latitude': latitude,
  //     'longitude': longitude,
  //   };
  //   // //on encode l'objet parking en json
  //   final body = jsonEncode(parking);
  //   // print(body);

  //   //on envoie la requête https get pour récupérer les données vers le fichier php : datacampus-bordeaux.fr/sources/requetes/API_flutter/parking_add.php
  //   final url = Uri.https('datacampus-bordeaux.fr',
  //       '/sources/requetes/API_flutter/parking_add.php', {
  //     'nom': nom,
  //     'nbPlacesMax': nbPlacesMax,
  //     'infoComplementaires': infoComplementaires,
  //     'nbPlacesHandicapes': nbPlacesHandicapes,
  //     'nbPlacesDisponibles': nbPlacesDisponibles,
  //     'boolPayant': payant.toString(),
  //     'boolHorsVoirie': horsVoirie.toString(),
  //     'boolPrive': prive.toString(),
  //     'latitude': latitude,
  //     'longitude': longitude,
  //   });
  //   // print(url);
  //   final response = await http.get(url);
  //   //print(response.statusCode);
  //   //print(response.body);
  //   //faire une animation qui dit que le produit est ajouter et revenir a la page précédente
  //   Navigator.pop(context);
  // }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _currentPosition = latlng;
      widget._controllers['latitude']?.text =
          _currentPosition!.latitude.toString();
      widget._controllers['longitude']?.text =
          _currentPosition!.longitude.toString();
      //print(_currentPosition);
      _nbClics++;
    });
  }
}
