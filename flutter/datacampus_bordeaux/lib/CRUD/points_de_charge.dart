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

class PointsDeCharge extends StatelessWidget {
  const PointsDeCharge({Key? key}) : super(key: key);

  //fonction qui retourne une liste de card à partir d'une liste de pointsDeChargess (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/pointsDeChargess.php"
  Future<List<Widget>> getpointsDeChargess() async {
    var url =
        Uri.http("145.239.198.30", "/sources/requetes/points_de_charges.php");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //print('Response body: ${response.body}');
    final data = jsonDecode(response.body);
    List<Widget> cards = [];
    for (var i = 0; i < data.length; i++) {
      cards.add(Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.directions_car),
              //title : nom du points de charges
              title: Text(data[i]['nom']),
              subtitle: const Text('Points de charge electrique'),
            ),
            Column(
              children: [
                //afficher les informations du pointsDeCharges
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Les types de prise disponibles : '),
                        for (var j = 0; j < data[i]['type_prise'].length; j++)
                          Text(data[i]['type_prise'][j]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Les puissances disponibles : '),
                        for (var j = 0; j < data[i]['puissance'].length; j++)
                          Text(data[i]['puissance'][j]),
                      ],
                    ),
                    // afficher les informations complementaires data[i]['informations_complementaires'] si elles existent et non null
                    if (data[i]['informations_complementaires'] != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Informations complémentaires : '),
                          Text(data[i]['info_complementaires']),
                        ],
                      ),
                  ],
                ),
                //afficher une petite carte avec le pointsDeCharges en question (latitude et longitude) sur un marker,
                //pour cela on utilise la librairie flutter_map
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(double.parse(data[i]["latitude"]),
                              double.parse(data[i]["longitude"])),
                          zoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          // si data[i]["coordonnees"] est un tableau de taille 1 alors on affiche un marker sinon on affiche un polyline
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(double.parse(data[i]["latitude"]),
                                    double.parse(data[i]["longitude"])),
                                builder: (ctx) => IconButton(
                                  icon: const Icon(Icons.electric_car,
                                      color: Colors.lightBlue, size: 25.0),
                                  color: Colors.red,
                                  iconSize: 45.0,
                                  onPressed: () {
                                    print('Marker pressed');
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Modifier'),
                      onPressed: () {
                        /* Formulaire pour modifier les informations */
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Supprimer',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        /* Demande confirmation avant suppression */
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getpointsDeChargess(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: snapshot.data[index],
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
