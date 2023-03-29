//page d'accueil de l'application
import 'package:flutter/material.dart';
import 'WIDGETS/courbe_frequentation.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'WIDGETS/jauge_frequentation.dart';
import 'WIDGETS/messageTbm.dart';
import 'WIDGETS/jauge_vcub.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int currentPageIndex = 0;

  // fonction qui retourne une liste de FlSpot qui sont les points de la courbe en faisant une requete à la base de données
  Future<List<List<FlSpot>>> getSpotsInfoApi() async {
    List<FlSpot> spots = [];

    List<FlSpot> spotsReffluid = [];
    List<FlSpot> spotsRefdense = [];
    List<FlSpot> spotsRefexcep = [];
    List<FlSpot> spotsPrevision = [];

    var url = Uri.https(
        "data.bordeaux-metropole.fr", //"key=177BEEMTWZ&typename=ci_courb_a"
        "/geojson",
        {"key": "177BEEMTWZ", "typename": "ci_courb_a"});
    //print("URL : " + url.toString());
    var response = await http.get(url);
    //print(response.statusCode);
    //print(response.body);
    var jsonData = jsonDecode(response.body); //
    //on parcourt le json pour recuperer les valeurs de la courbe : ident et actuel
    for (var u in jsonData["features"]) {
      if (u["properties"]["ident"] != null &&
          u["properties"]["actuel"] != null) {
        double ident = double.parse(u["properties"]["ident"].toString());
        double actuel = double.parse(u["properties"]["actuel"].toString());
        spots.add(FlSpot(ident, actuel));

        if (u["properties"]["ident"] != null &&
            u["properties"]["reffluid"] != null) {
          double ident = double.parse(u["properties"]["ident"].toString());
          double reffluid =
              double.parse(u["properties"]["reffluid"].toString());
          spotsReffluid.add(FlSpot(ident, reffluid));
        }
        if (u["properties"]["ident"] != null &&
            u["properties"]["refdense"] != null) {
          double ident = double.parse(u["properties"]["ident"].toString());
          double refdense =
              double.parse(u["properties"]["refdense"].toString());
          spotsRefdense.add(FlSpot(ident, refdense));
        }
        if (u["properties"]["ident"] != null &&
            u["properties"]["refexcep"] != null) {
          double ident = double.parse(u["properties"]["ident"].toString());
          double refexcep =
              double.parse(u["properties"]["refexcep"].toString());
          spotsRefexcep.add(FlSpot(ident, refexcep));
        }
        if (u["properties"]["ident"] != null &&
            u["properties"]["prevision"] != null) {
          double ident = double.parse(u["properties"]["ident"].toString());
          double prevision =
              double.parse(u["properties"]["prevision"].toString());
          spotsPrevision.add(FlSpot(ident, prevision));
        }
      }
    }

    double minX = spots[0].x;
    double maxX = spots[0].x;

    for (int i = 0; i < spots.length; i++) {
      if (spots[i].x < minX) {
        minX = spots[i].x;
      }
      if (spots[i].x > maxX) {
        maxX = spots[i].x;
      }
    }

    // faire ne sorte que la liste des X commence à 0
    for (int i = 0; i < spots.length; i++) {
      spots[i] = FlSpot(spots[i].x - minX, spots[i].y);
      spotsReffluid[i] = FlSpot(spotsReffluid[i].x - minX, spotsReffluid[i].y);
      spotsRefdense[i] = FlSpot(spotsRefdense[i].x - minX, spotsRefdense[i].y);
      spotsRefexcep[i] = FlSpot(spotsRefexcep[i].x - minX, spotsRefexcep[i].y);
      spotsPrevision[i] =
          FlSpot(spotsPrevision[i].x - minX, spotsPrevision[i].y);
    }

    return [spots, spotsReffluid, spotsRefdense, spotsRefexcep, spotsPrevision];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Stack(
              // Sur la meme ligne et sur fond bleu mettre à gauche le titre : "Bordeaux Métropole" et à droite le logo dans un demi rond de couleur blanche
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 28, 103, 215),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Chaire MTI : Innover pour la mobilité intelligente",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Fédérons l'écosystème néo-aquitain pour anticiper les transports de demain",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/logo-chair.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Color.fromARGB(168, 247, 250, 255),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    height: 250,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FutureBuilder<List<List<FlSpot>>>(
                        future: getSpotsInfoApi(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<List<FlSpot>>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            return LineChartSample2(Data: snapshot.data!);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color.fromARGB(168, 247, 250, 255),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    height: 250,
                    width: 500,
                    child: FutureBuilder<List<List<FlSpot>>>(
                      future: getSpotsInfoApi(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<List<FlSpot>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return JaugeFrequentation(Data: snapshot.data!);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            MessageTbm(),
          ],
        ),
        const Center(child: Text("Vcub", style: TextStyle(fontSize: 50))),
        const JaugeVcub(),
      ],
    );
  }
}
