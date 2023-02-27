import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;

import 'package:loading_animation_widget/loading_animation_widget.dart';

class PointDeCovoiturage extends StatefulWidget {
  const PointDeCovoiturage({Key? key}) : super(key: key);

  @override
  State<PointDeCovoiturage> createState() => _PointDeCovoiturageState();
}

class _PointDeCovoiturageState extends State<PointDeCovoiturage> {
  //fonction qui retourne une liste de card à partir d'une liste de PointDeCovoituragess (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/PointDeCovoituragess.php"
  Future<List<Widget>> getPointDeCovoiturages() async {
    var url = Uri.https("datacampus-bordeaux.fr",
        "/sources/requetes/points_de_covoiturage.php");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    print("Salut");
    print("" + data[0]["nom"]);

    // List<Widget> cards = data
    //     .map((e) => Card(
    //             child:
    //                 Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //           ListTile(
    //             leading: const Icon(Icons.directions_car),
    //             //title : nom de la table
    //             title: Text(e['nom']),
    //             subtitle: const Text('Points de quelquechose'),
    //           ),
    //           Column(children: [
    //             //afficher les informations du PointDeCovoiturages
    //             Column(
    //                 children: e.keys
    //                     .map((key) => {
    //                           if (e[key] is List && key != 'coordonnees')
    //                             {
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 children: [
    //                                   Text('$key'),
    //                                   for (var j = 0; j < e[key].length; j++)
    //                                     Text(e[key][j]),
    //                                 ],
    //                               )
    //                             }
    //                           else if (e[key] is String ||
    //                               e[key] is int ||
    //                               e[key] is double)
    //                             {
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 children: [
    //                                   Text('$key : '),
    //                                   Text(e[key]),
    //                                 ],
    //                               )
    //                             }
    //                           else if (key == 'coordonnnes')
    //                             {
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.end,
    //                                 children: [
    //                                   SizedBox(
    //                                     height: 100,
    //                                     width: 200,
    //                                     child: FlutterMap(
    //                                       options: MapOptions(
    //                                         center: LatLng(
    //                                             double.parse(e['coordonnees'][0]
    //                                                 ["latitude"]),
    //                                             double.parse(e['coordonnees'][0]
    //                                                 ["longitude"])),
    //                                         zoom: 15.0,
    //                                       ),
    //                                       children: [
    //                                         TileLayer(
    //                                           urlTemplate:
    //                                               "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    //                                           subdomains: const ['a', 'b', 'c'],
    //                                         ),
    //                                         // si data[i]["coordonnees"] est un tableau de taille 1 alors on affiche un marker sinon on affiche un polyline
    //                                         if (e["coordonnees"].length == 1)
    //                                           MarkerLayer(
    //                                             markers: [
    //                                               Marker(
    //                                                 width: 80.0,
    //                                                 height: 80.0,
    //                                                 point: LatLng(
    //                                                     double.parse(
    //                                                         e['coordonnees'][0]
    //                                                             ["latitude"]),
    //                                                     double.parse(
    //                                                         e['coordonnees'][0]
    //                                                             ["longitude"])),
    //                                                 builder: (ctx) =>
    //                                                     IconButton(
    //                                                   icon: const Icon(
    //                                                       Icons
    //                                                           .local_parking_sharp,
    //                                                       color:
    //                                                           Colors.lightBlue,
    //                                                       size: 25.0),
    //                                                   color: Colors.red,
    //                                                   iconSize: 45.0,
    //                                                   onPressed: () {
    //                                                     print('Marker pressed');
    //                                                   },
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           )
    //                                         else if (["coordonnees"].length > 1)
    //                                           PolylineLayer(
    //                                             polylines: [
    //                                               Polyline(
    //                                                 points: [
    //                                                   for (var j = 0;
    //                                                       j <
    //                                                           e["coordonnees"]
    //                                                               .length;
    //                                                       j++)
    //                                                     LatLng(
    //                                                         double.parse(
    //                                                             e["coordonnees"]
    //                                                                     [j][
    //                                                                 "latitude"]),
    //                                                         double.parse(
    //                                                             e["coordonnees"]
    //                                                                     [j][
    //                                                                 "longitude"]))
    //                                                 ],
    //                                                 strokeWidth: 4.0,
    //                                                 color: Colors.lightBlue,
    //                                               ),
    //                                             ],
    //                                           ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               )
    //                             },
    //                         })
    //                     .toList())
    //           ])
    //         ])))
    //     .toList();

    List<Widget> cards2 = [];
    for (var e in data) {
      print("ALLOOOOOOO");
      cards2.add(Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          leading: const Icon(Icons.directions_car),
          //title : nom de la table
          title: Text(e['nom']),
          subtitle: const Text('Points de quelquechose'),
        ),
        Column(
            children: e.keys
                .map((key) => {
                      print("key : $key"),
                      if (e[key] is List && key != 'coordonnees')
                        {
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('$key'),
                              for (var j = 0; j < e[key].length; j++)
                                Text(e[key][j]),
                            ],
                          )
                        }
                      else if (e[key] is String ||
                          e[key] is int ||
                          e[key] is double)
                        {
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('$key : '),
                              Text(e[key]),
                            ],
                          )
                        }
                      else if (key == 'coordonnnes')
                        {
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 200,
                                child: FlutterMap(
                                  options: MapOptions(
                                    center: LatLng(
                                        double.parse(
                                            e['coordonnees'][0]["latitude"]),
                                        double.parse(
                                            e['coordonnees'][0]["longitude"])),
                                    zoom: 15.0,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: const ['a', 'b', 'c'],
                                    ),
                                    // si data[i]["coordonnees"] est un tableau de taille 1 alors on affiche un marker sinon on affiche un polyline
                                    if (e["coordonnees"].length == 1)
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            width: 80.0,
                                            height: 80.0,
                                            point: LatLng(
                                                double.parse(e['coordonnees'][0]
                                                    ["latitude"]),
                                                double.parse(e['coordonnees'][0]
                                                    ["longitude"])),
                                            builder: (ctx) => IconButton(
                                              icon: const Icon(
                                                  Icons.local_parking_sharp,
                                                  color: Colors.lightBlue,
                                                  size: 25.0),
                                              color: Colors.red,
                                              iconSize: 45.0,
                                              onPressed: () {
                                                print('Marker pressed');
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    else if (["coordonnees"].length > 1)
                                      PolylineLayer(
                                        polylines: [
                                          Polyline(
                                            points: [
                                              for (var j = 0;
                                                  j < e["coordonnees"].length;
                                                  j++)
                                                LatLng(
                                                    double.parse(
                                                        e["coordonnees"][j]
                                                            ["latitude"]),
                                                    double.parse(
                                                        e["coordonnees"][j]
                                                            ["longitude"]))
                                            ],
                                            strokeWidth: 4.0,
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        },
                    })
                .toList())
      ])));
    }

    print("Salut LIBERATEUR");
    return cards2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getPointDeCovoiturages(),
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
