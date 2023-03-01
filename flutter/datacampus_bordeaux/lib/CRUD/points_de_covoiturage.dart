import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'presentation_card.dart';

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

    final List data = jsonDecode(response.body);

    print("Salut");
    print("" + data[0]["nom"]);

    //Iterable<Widget> cards = data.map((e) => makeCard(e));

    List<Widget> cards = [];
    for (int i = 0; i < data.length; i++) {
      cards.add(PresentationCard(e: data[i]));
    }

    print("Salut LIBERATEUR");
    return cards;
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
