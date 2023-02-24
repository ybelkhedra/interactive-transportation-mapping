import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;

import 'package:loading_animation_widget/loading_animation_widget.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  // fonction de filtre de coordonnées : retourne boolean
  bool isInZone(LatLng point) {
    return point.latitude < 44.81 &&
        point.latitude < 44.76 &&
        point.longitude < -0.579 &&
        point.longitude > -0.65;
  }

  //fonction qui retourne une liste de markers à partir d'une liste d'arrets de bus (json) obtenu par une requete http
  Future<List<Marker>> getBusStop() async {
    var url = Uri.http("145.239.198.30", "/sources/requetes/arrets_api.php");
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    var data = jsonDecode(response.body);
    List<Marker> markers = [];
    for (var i = 0; i < data.length; i++) {
      if (isInZone(LatLng(double.parse(data[i]['latitude']),
          double.parse(data[i]['longitude'])))) {
        markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(double.parse(data[i]['latitude']),
              double.parse(data[i]['longitude'])),
          builder: (ctx) => Container(
            child: IconButton(
              icon: const Icon(Icons.directions_bus),
              color: Colors.red,
              iconSize: 45.0,
              onPressed: () {
                print('Marker pressed');
              },
            ),
          ),
        ));
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 200,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    //menu accordéon
                    ExpansionTile(
                      title: const Text('Poins statiques'),
                      children: [
                        // menu déroulant : Transport en commun
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 170,
                              child: ExpansionTile(
                                title: const Text('Transport en commun'),
                                children: [
                                  //bouton avec icone et texte : BUS TBM
                                  TextButton.icon(
                                    onPressed: () {
                                      //print('tram');
                                    },
                                    icon: const Icon(Icons.directions_train,
                                        color: Colors.black),
                                    label: const Text('Tram'),
                                  ),
                                  //texte bouton ecrit : "tram" avec aussi un icon
                                  TextButton.icon(
                                    onPressed: () {
                                      print('bus');
                                    },
                                    icon: const Icon(Icons.directions_bus,
                                        color: Colors.black),
                                    label: const Text('Bus'),
                                  ),
                                ],
                              ),
                            ),
                            //mobilite douces
                            SizedBox(
                              width: 170,
                              child: ExpansionTile(
                                title: const Text('Mobilite douce'),
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      print('velo');
                                    },
                                    icon: const Icon(Icons.directions_bike,
                                        color: Colors.black),
                                    label: const Text('Velo'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      print('trotinette');
                                    },
                                    icon: const Icon(Icons.directions_bike,
                                        color: Colors.black),
                                    label: const Text('Trotinette'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // menu accordéon point dynamique
                    ExpansionTile(
                      title: Text('Poins dynamiques'),
                      children: [
                        IconButton(
                          icon: const Icon(Icons.directions_bus,
                              color: Colors.black),
                          onPressed: () {
                            print('bus');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Expanded(
              child: FlutterMap(
            options: MapOptions(
              center: LatLng(44.8, -0.61),
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              Container(
                child: FutureBuilder<List<Marker>>(
                  //afficher une animation tant que la requete n'est pas finie
                  future: getBusStop(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Marker>> snapshot) {
                    if (snapshot.hasData) {
                      return MarkerLayer(
                        markers: snapshot.data as List<Marker>,
                      );
                    } else if (snapshot.hasError) {
                      return const Text('An error occurred');
                    } else {
                      return Scaffold(
                        body: Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: Colors.blue,
                            size: 200,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
