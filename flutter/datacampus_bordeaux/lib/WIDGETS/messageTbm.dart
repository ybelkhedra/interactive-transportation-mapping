import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class MessageTbm extends StatefulWidget {
  @override
  _MessageTbmState createState() => _MessageTbmState();
}

class _MessageTbmState extends State<MessageTbm> {
  //fonction pour récupérer les messages via http et renvoi un horizontallistview de card avec les messages
  Future<Widget> getMessages() async {
    var url = Uri.https("data.bordeaux-metropole.fr", "geojson",
        {"key": "177BEEMTWZ", "typename": "sv_messa_a"});
    //print("URL : " + url.toString());
    final response = await http.get(url);
    var jsonData = json.decode(utf8.decode(response.bodyBytes));
    List messages = [];
    for (var u in jsonData["features"]) {
      if (u["properties"]["message"] != null &&
          u["properties"]["rs_sv_ligne_a"] != null) {
        String message = u["properties"]["message"].toString();
        String ligne = u["properties"]["rs_sv_ligne_a"].toString();
        messages.add([message, ligne]);
      }
    }
    //pour chaque message demander à datacampus-bordeaux.fr/sources/requetes/API_flutter/convert_id_ligne_nom.php?rs_sv_ligne_a=[ligne] pour avoir l'appellation commercial de la ligne
    for (var i = 0; i < messages.length; i++) {
      String ligne = messages[i][1];
      final url = Uri.https(
          "datacampus-bordeaux.fr",
          "/sources/requetes/API_flutter/convert_id_ligne_nom.php",
          {"ligne": ligne});
      final response = await http.get(url);
      messages[i][1] = response.body.toString();
    }
    final listLignes = messages.map((e) => e[1]).toSet().toList();
    //supprimer les doublons et duplications dans la liste des lignes
    listLignes.removeWhere((element) => element == "null");
    //print(listLignes);
    final listMessages = [];
    //pour chaque ligne on recupere les messages correspondant
    for (var i = 0; i < listLignes.length; i++) {
      final listMessagesLigne = [];
      for (var j = 0; j < messages.length; j++) {
        if (messages[j][1] == listLignes[i]) {
          listMessagesLigne.add(messages[j][0]);
        }
      }
      if (listLignes[i].contains("TRAM") ||
          listLignes[i].contains("Tram") ||
          listLignes[i].contains("tram")) {
        listMessages.add([
          listLignes[i],
          listMessagesLigne,
          const Icon(Icons.directions_transit_rounded, color: Colors.white)
        ]);
      } else {
        listMessages.add([
          listLignes[i],
          listMessagesLigne,
          const Icon(Icons.directions_bus_rounded, color: Colors.white)
        ]);
      }
    }
    //retourner une listview horizontale de card avec les messages
    return Column(
      children: [
        //titre : Messages TBM
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: SelectableText(
            "Messages TBM",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          child: //faire un menu accordeon representant chaque ligne et quand on clique on affiche tous les messages correspondant,
              //pour cela on utilise le package accordion
              ListView(children: [
            for (var i = 0; i < listMessages.length; i++)
              Accordion(
                paddingListTop: 2,
                paddingListBottom: 2,
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: [
                  AccordionSection(
                    leftIcon: listMessages[i][2],
                    headerBackgroundColor: Colors.black,
                    headerBackgroundColorOpened: Colors.red,
                    header: Text(
                      listMessages[i][0],
                      style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: //parcourir tout les messages de la ligne et les afficher avec un retour a la ligne,
                        //pour cela on utilise le package flutter_html
                        ListView.builder(
                      shrinkWrap: true,
                      itemCount: listMessages[i][1].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Text(
                            listMessages[i][1][index],
                            style: const TextStyle(
                                color: Color(0xff999999),
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                    ),
                    contentHorizontalPadding: 2,
                    contentBorderWidth: 1,
                  ),
                ],
              ),
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMessages(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: SelectableText("Loading..."),
          );
        } else {
          return snapshot.data;
        }
      },
    );
  }
}
