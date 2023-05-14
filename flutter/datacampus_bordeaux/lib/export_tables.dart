// Page qui permet à l'utilisateur d'ajouter des tables à la base de données du site web

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'CRUD/table_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'display_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExportTable extends StatefulWidget {
  final List<String> tableNames = getTablesNames();

  ExportTable({Key? key}) : super(key: key);

  @override
  _ExportTableState createState() => _ExportTableState();
}

class _ExportTableState extends State<ExportTable> {
  int _currentStep = 0;
  String nomTable = "";
  String format = "";

  Future<String> getFile() async {
    String fileName = tableHelper[nomTable]!['script'];
    final Uri url =
        Uri.https("datacampus-bordeaux.fr", "/sources/requetes/$fileName.php");
    // if (await canLaunchUrl(url)) { //on pourrait faire qu'il lance directement le script aussi
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
    var response = await http.get(url);
    var jsonReponse = jsonDecode(response.body);
    return jsonReponse.toString();
  }

  // TODO : fonction qui appelle le script php datacampus-bordeaux.fr/sources/requetes/API_flutter/export_table.php avec les paramètres suivants : nom de la table, format, et qui permet de telecharger les donnees en format CSV ou Json

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: [
        Step(
            isActive: _currentStep == 0,
            title: const Text('Choisir une table'),
            content: // menu déroulant pour selectionner la table. La liste des tables est dans table_helper le tableau tableHelper avec le champ nom_jolie
                Column(
                    children: widget.tableNames
                        .map((e) => CheckboxListTile(
                              title: Text(tableHelper[e]['nom_jolie']!),
                              value: e == nomTable,
                              onChanged: (bool? value) {
                                setState(() {
                                  nomTable = e;
                                });
                              },
                            ))
                        .toList())),
        Step(
          isActive: _currentStep == 1,
          title: const Text("Selection du format d'exportation"),
          content: // liste déroulante avec les 2 champs : GeoJson ou CSV
              Column(
            children: [
              Row(
                children: const [
                  Text('Format d\'exportation'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text('json'),
                value: format == 'json',
                onChanged: (bool? value) {
                  setState(() {
                    format = 'json';
                  });
                },
              )
            ],
          ),
        ),
        Step(
          isActive: _currentStep == 2,
          title: const Text('Voir les données'),
          content: // bouton qui permet de télécharger le fichier
              Column(
            children: [
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayData(textFuture: getFile()),
                    ),
                  )
                },
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
