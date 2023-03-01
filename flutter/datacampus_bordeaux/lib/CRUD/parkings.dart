import 'dart:js';

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

import 'addParkings.dart';
// import 'parkings_edit.dart';

class Parkings extends StatefulWidget {
  const Parkings({Key? key}) : super(key: key);

  @override
  State<Parkings> createState() => _ParkingsState();
}

class _ParkingsState extends State<Parkings> {
  //fonction qui retourne une liste de card à partir d'une liste de parkings (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/parkings.php"
  Future<List<Widget>> getparkings(BuildContext context) async {
    var url =
        Uri.https("datacampus-bordeaux.fr", "/sources/requetes/parkings.php");
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

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
              //title : nom du parking
              title: Text(data[i]['nom']),
              subtitle: const Text('Parking'),
            ),
            Column(
              children: [
                //afficher les informations du parking
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Nombre de places max : '),
                        Text(data[i]['nb_places_max']),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Nombre de places handicapés : '),
                        Text(data[i]['nb_places_handicapes']),
                      ],
                    ),
                    //si data[i]['payant'] = 0 alors le parking est gratuit est vice versa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Payant : '),
                        Text(data[i]['payant'] == '0' ? 'Non' : 'Oui'),
                      ],
                    ),
                    // si data[i]['hors_voirie'] = 0 alors le parking est en voirie et vice versa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Hors voirie : '),
                        Text(data[i]['hors_voirie'] == '0' ? 'Non' : 'Oui'),
                      ],
                    ),
                    // si data[i]['prive'] = 0 alors le parking est public et vice versa
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Privé : '),
                        Text(data[i]['prive'] == '0' ? 'Non' : 'Oui'),
                      ],
                    ),
                    // afficher les informations complementaires data[i]['informations_complementaires'] si elles existent et non null
                    if (data[i]['informations_complementaires'] != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Informations complémentaires : '),
                          Text(data[i]['informations_complementaires']),
                        ],
                      ),
                  ],
                ),
                //afficher une petite carte avec le parking en question (latitude et longitude) sur un marker,
                //pour cela on utilise la librairie flutter_map
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
                                  data[i]['coordonnees'][0]["latitude"]),
                              double.parse(
                                  data[i]['coordonnees'][0]["longitude"])),
                          zoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          // si data[i]["coordonnees"] est un tableau de taille 1 alors on affiche un marker sinon on affiche un polyline
                          if (data[i]["coordonnees"].length == 1)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(
                                      double.parse(data[i]['coordonnees'][0]
                                          ["latitude"]),
                                      double.parse(data[i]['coordonnees'][0]
                                          ["longitude"])),
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
                          else if (data[i]["coordonnees"].length > 1)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: [
                                    for (var j = 0;
                                        j < data[i]["coordonnees"].length;
                                        j++)
                                      LatLng(
                                          double.parse(data[i]["coordonnees"][j]
                                              ["latitude"]),
                                          double.parse(data[i]["coordonnees"][j]
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Modifier'),
                      onPressed: () {
                        /* Passe à la page parkings_edit.dart avec toutes les infos de la carte */
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Supprimer',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () async {
                        /* Popup pour supprimer le parking */
                        var url = Uri.https(
                            "datacampus-bordeaux.fr",
                            "/sources/requetes/API_flutter/parking_delete.php",
                            {"id": data[i]['id']});
                        print(url);
                        await http.post(url);
                        //supprimer la card correspondante
                        setState(() {
                          cards.removeAt(i);
                        });
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
      appBar: AppBar(
        title: const Text('Liste des parkings'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // aller à la page d'ajout de parking
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const addParkings()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getparkings(context),
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
