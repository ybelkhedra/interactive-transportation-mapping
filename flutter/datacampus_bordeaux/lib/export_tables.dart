// Page qui permet à l'utilisateur d'ajouter des tables à la base de données du site web

import 'package:flutter/material.dart';
import 'CRUD/table_helper.dart';

import 'dart:js';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExportTable extends StatefulWidget {
  const ExportTable({Key? key}) : super(key: key);

  @override
  _ExportTableState createState() => _ExportTableState();
}

class _ExportTableState extends State<ExportTable> {
  int _currentStep = 0;
  late String nomTable = "";
  late String format = "";

  // TODO : fonction qui appelle le script php datacampus-bordeaux.fr/sources/requetes/API_flutter/export_table.php avec les paramètres suivants : nom de la table, format, et qui permet de telecharger les donnees en format CSV ou Json

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: [
        Step(
          isActive: _currentStep == 0,
          title: const Text('Choisir une table'),
          content: // menu déroulant pour selectionner la table. La liste des tables est dans table_helper le tableau tableHelper avec le champ nom_jolie
              Text("Choisir une table"),
        ),
        Step(
          isActive: _currentStep == 1,
          title: const Text("Selection du format d'exportation"),
          content: // liste déroulante avec les 2 champs : GeoJson ou CSV
              Column(
            children: [
              Row(
                children: [
                  const Text('Format d\'exportation'),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          isActive: _currentStep == 2,
          title: const Text('Telecharment du fichier'),
          content: // bouton qui permet de télécharger le fichier
              Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Télécharger le fichier'),
              ),
            ],
          ),
        ),
      ],
      onStepTapped: (int newIndex) {
        setState(() {
          _currentStep = newIndex;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        setState(() {
          if (_currentStep < 2) {
            _currentStep++;
          } else {
            _currentStep = 0;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep--;
          } else {
            _currentStep = 0;
          }
        });
      },
      //modifier le texte du bouton continue par suivant
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            TextButton(
              onPressed: details.onStepContinue,
              child: const Text('Suivant'),
            ),
            TextButton(
              onPressed: details.onStepCancel,
              child: const Text('Retour'),
            ),
          ],
        );
      },
    );
  }
}