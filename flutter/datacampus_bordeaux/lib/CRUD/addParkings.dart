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

import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  final _nbPlacesDispoController = TextEditingController();
  final _nbPlacesHandicapesController = TextEditingController();
  bool _boolPayant = false;
  bool _boolHorsVoirie = false;
  bool _boolPrive = false;
  //tableau qui contient les coordonnées de la position du parking (latitude, longitude)
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();

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
              controller: _nbPlacesDispoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nombre de places disponibles',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre de places disponibles';
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
                addParking();
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  //fonction qui ajoute le parking à la base de données
  Future<void> addParking() async {
    //on récupère les données du formulaire
    final nom = _nomController.text;
    // final nbPlacesMax = _nbPlacesMaxController;
    // final nbPlacesDispo = _nbPlacesDispoController;
    // final nbPlacesHandicapes = _nbPlacesHandicapesController;
    // final coordonnees = [_latitude, _longitude];
    // //on crée un objet parking
    // final parking = {
    //   'nom': nom,
    //   'nbPlacesMax': nbPlacesMax,
    //   'nbPlacesDispo': nbPlacesDispo,
    //   'nbPlacesHandicapes': nbPlacesHandicapes,
    //   'boolPayant': _boolPayant,
    //   'boolHorsVoirie': _boolHorsVoirie,
    //   'boolPrive': _boolPrive,
    //   'coordonnees': coordonnees,
    // };

    // //on encode l'objet parking en json
    // final body = jsonEncode(parking);
    // print(body);
  }
}
