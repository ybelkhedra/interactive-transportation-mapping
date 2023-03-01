import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

class PresentationCard extends StatelessWidget {
  final e;
  const PresentationCard({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("e : $e");
    return Card(
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
                            Text('$key : '),
                            for (int i = 0; i < e[key].length; i++)
                              Text(e[key][i]),
                          ],
                          // children: [Text('$key')] +
                          //      e[key].map((t) => Text(t)).toList(),
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
                                          points: e["coordonnees"]
                                              .map((j) => LatLng(
                                                  double.parse(j["latitude"]),
                                                  double.parse(j["longitude"])))
                                              .toList(),
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
    ]));
  }
}
