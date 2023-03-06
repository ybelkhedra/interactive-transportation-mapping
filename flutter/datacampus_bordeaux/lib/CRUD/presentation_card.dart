import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'table_helper.dart';

class PresentationCard extends StatelessWidget {
  final e;
  final void Function(Widget, int, String) deleteVoid;
  final String tableName;
  const PresentationCard(
      {Key? key,
      required this.e,
      required this.deleteVoid,
      required this.tableName})
      : super(key: key);

  Widget getInformation(Map e, String key) {
    if (e[key] is List && key != 'coordonnees') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${tableHelper[tableName]![key]!["nom"]} : '),
          for (int i = 0; i < e[key].length; i++) Text(e[key][i]),
        ],
      );
    } else if (key != 'latitude' &&
        key != 'longitude' &&
        (e[key] is String || e[key] is int || e[key] is double)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${tableHelper[tableName]![key]!["nom"]} : '),
          Text(e[key]),
        ],
      );
    } else if (key == 'coordonnnes') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(double.parse(e['coordonnees'][0]["latitude"]),
                    double.parse(e['coordonnees'][0]["longitude"])),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                            double.parse(e['coordonnees'][0]["latitude"]),
                            double.parse(e['coordonnees'][0]["longitude"])),
                        builder: (ctx) => IconButton(
                          icon: const Icon(Icons.local_parking_sharp,
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
                else if (["coordonnees"].length > 1)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [
                          for (var j = 0; j < e["coordonnees"].length; j++)
                            LatLng(
                                double.parse(e["coordonnees"][j]["latitude"]),
                                double.parse(e["coordonnees"][j]["longitude"]))
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
      );
    } else if (key == 'latitude') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(
                    double.parse(e["latitude"]), double.parse(e["longitude"])),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                // si data[i]["coordonnees"] est un tableau de taille 1 alors on affiche un marker sinon on affiche un polyline
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(double.parse(e["latitude"]),
                          double.parse(e["longitude"])),
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
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: const Icon(Icons.directions_car),
        //title : nom de la table
        title: Text(e['nom']),
      ),
      Column(
          children: [for (String key in e.keys) getInformation(e, key)] +
              [
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
                        onPressed: () async {
                          deleteVoid(this, e['id'], tableName);
                        }),
                    const SizedBox(width: 8),
                  ],
                )
              ])
    ]));
  }
}
