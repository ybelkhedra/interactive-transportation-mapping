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

class parkings extends StatelessWidget {
  const parkings({Key? key}) : super(key: key);

  //fonction qui retourne une liste de card à partir d'une liste de parkings (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/parkings.php"
  Future<List<Widget>> getparkings() async {
    var url = Uri.http("145.239.198.30", "/sources/requetes/parkings.php");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final data = jsonDecode(response.body);
    List<Widget> cards = [];
    for (var i = 0; i < data.length; i++) {
      cards.add(Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.directions_car),
              //title : nom du parking
              title: Text(data[i]['nom']),
              subtitle: const Text('Parking'),
            ),
            Column(
              children: [
                //afficher une petite carte avec le parking en question (latitude et longitude) sur un marker,
                //pour cela on utilise la librairie flutter_map
                Container(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          double.parse(data[i]['coordonnees'][0]["latitude"]),
                          double.parse(data[i]['coordonnees'][0]["longitude"])),
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      Container(
                        child: MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(
                                  double.parse(
                                      data[i]['coordonnees'][0]["latitude"]),
                                  double.parse(
                                      data[i]['coordonnees'][0]["longitude"])),
                              builder: (ctx) => Container(
                                child: IconButton(
                                  icon: Icon(Icons.directions_car),
                                  color: Colors.red,
                                  iconSize: 45.0,
                                  onPressed: () {
                                    print('Marker pressed');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Plus d\'informations'),
                      onPressed: () {
                        /* Afficher une card en dessous de la carte avec les informations du parkings */
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Réserver'),
                      onPressed: () {
                        /* ... */
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
          future: getparkings(),
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
