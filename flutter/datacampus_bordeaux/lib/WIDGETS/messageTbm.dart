import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageTbm extends StatefulWidget {
  @override
  _MessageTbmState createState() => _MessageTbmState();
}

class _MessageTbmState extends State<MessageTbm> {
  //fonction pour récupérer les messages via http et renvoi un horizontallistview de card avec les messages
  Future<Widget> getMessages() async {
    print("messageTbm.dart : getMessages() :");
    var url = Uri.https("data.bordeaux-metropole.fr", "geojson",
        {"key": "177BEEMTWZ", "typename": "sv_messa_a"});
    print("URL : " + url.toString());
    final response = await http.get(url);
    var jsonData = jsonDecode(response.body);
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
      print(url);
      print(response.statusCode);
      print(response.body);
      messages[i][1] = response.body.toString();
    }
    //retourner une listview horizontale de card avec les messages
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < messages.length; i++)
            Card(
              color: Colors.blue,
              borderOnForeground: true,
              child: Column(
                children: [
                  Text(messages[i][1]),
                  //si le message on ecrit dans un zone de texte sur plusieur ligne
                  if (messages[i][0].length > 50)
                    Container(
                      width: 300,
                      child: Text(messages[i][0]),
                    )
                  //sinon on ecrit dans un zone de texte sur une ligne
                  else
                    Text(messages[i][0]),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getMessages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: const Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return snapshot.data;
          }
        },
      ),
    );
  }
}
