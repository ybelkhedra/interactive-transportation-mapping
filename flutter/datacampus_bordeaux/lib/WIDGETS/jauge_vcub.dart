import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JaugeVcub extends StatefulWidget {
  const JaugeVcub({Key? key}) : super(key: key);
  @override
  State<JaugeVcub> createState() => _JaugeVcubState();
}

class _JaugeVcubState extends State<JaugeVcub> {
  //fonction qui se connecte à l'API et récupère les données : datacampus-bordeaux.fr/sources/requetes/API_flutter/nb_vcub.php
  Future<Widget> getDataVcub() async {
    var url = Uri.https(
        "datacampus-bordeaux.fr", "/sources/requetes/API_flutter/nb_vcub.php");
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    double nbPlacesTotales =
        jsonData['nb_places_libres'] + jsonData['nb_velos_disponibles'];
    double nbPlacesDispo = jsonData['nb_velos_disponibles'];
    double nbPlacesOccupees = nbPlacesTotales - nbPlacesDispo;
    double nbVelosDispo = jsonData['nb_velos_elec_disponibles'] +
        jsonData['nb_velos_classiques_disponibles'];
    double nbVelosDispoElectriques = jsonData['nb_velos_elec_disponibles'];
    double nbVelosDispoClassique = jsonData['nb_velos_classiques_disponibles'];
    double nbStationsSuivies = jsonData['nb_stations'];

    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "Nombre de stations suivies : $nbStationsSuivies",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de places totales : $nbPlacesTotales",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de places occupées : $nbPlacesOccupees",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de places disponibles : $nbPlacesDispo",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de vélos disponibles : $nbVelosDispo",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de vélos disponibles électriques : $nbVelosDispoElectriques",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nombre de vélos disponibles classiques : $nbVelosDispoClassique",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              //multiple linear pointers horizontal
              SfLinearGauge(
                minimum: 0,
                maximum: nbPlacesTotales,
                ranges: [
                  LinearGaugeRange(
                    startValue: 0,
                    endValue: nbVelosDispoClassique,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  ),
                ],
                markerPointers: [
                  LinearShapePointer(
                    value: nbVelosDispo,
                    enableAnimation: true,
                    animationDuration: 2000,
                  ),
                ],
                barPointers: [
                  LinearBarPointer(
                      value: nbVelosDispoElectriques,
                      animationDuration: 2000,
                      enableAnimation: true)
                ],
                //legende
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return FutureBuilder(
          future: getDataVcub(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SelectableText("Loading..."),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: SelectableText("Error"),
              );
            } else {
              return snapshot.data;
            }
          },
        );
      },
    );
  }
}
