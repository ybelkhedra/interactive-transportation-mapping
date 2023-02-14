import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;

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
              icon: Icon(Icons.directions_bus),
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
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: Colors.green[700],
      ),
      body: FlutterMap(
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
              future: getBusStop(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
                if (snapshot.hasData) {
                  return MarkerLayer(
                    markers: snapshot.data as List<Marker>,
                  );
                } else if (snapshot.hasError) {
                  return Text('An error occurred');
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
