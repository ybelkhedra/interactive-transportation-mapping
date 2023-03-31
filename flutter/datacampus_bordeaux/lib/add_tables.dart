// Page qui permet à l'utilisateur d'ajouter des tables à la base de données du site web

import 'package:flutter/material.dart';

class AddTables extends StatefulWidget {
  const AddTables({Key? key}) : super(key: key);

  @override
  _AddTablesState createState() => _AddTablesState();
}

class _AddTablesState extends State<AddTables> {
  int _currentStep = 0;
  int _nbAttributs = 0;
  late String nomTable, nomLegende;
  late List<String> attributs;

  var _nomTable = TextEditingController();
  var _nomLegend = TextEditingController();
  var _attributs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: [
        Step(
          isActive: _currentStep == 0,
          title: const Text('Nom de la table'),
          content: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom de la table',
            ),
          ),
        ),
        Step(
          isActive: _currentStep == 1,
          title: const Text('Ajout des attributs'),
          content: // un textentry pour entrer un nom d'attribut mais avec un bouton + et - pour ajouter ou supprimer des attributs
              Column(
            children: [
              Row(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom de l\'attribut',
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ajouter un bouton + pour ajouter un attribut et un bouton - pour supprimer un attribut (si il y en a plus d'un)
        ),
        Step(
          isActive: _currentStep == 2,
          title: const Text('Nom de la legende sur la carte'),
          content: const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom de la legende sur la carte',
            ),
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
