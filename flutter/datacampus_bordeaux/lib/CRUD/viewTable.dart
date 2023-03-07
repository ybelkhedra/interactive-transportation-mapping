import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'presentation_card.dart';
import 'add/addToTables.dart';
//import 'add/addParkings.dart';

class ViewTable extends StatefulWidget {
  final String tableName;

  const ViewTable({Key? key, required this.tableName}) : super(key: key);

  @override
  State<ViewTable> createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {
  //fonction qui retourne une liste de card à partir d'une liste de ViewTabless (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/ViewTabless.php"
  Future<List<Widget>> getViewTables() async {
    String fileName = widget.tableName;
    var url =
        Uri.https("datacampus-bordeaux.fr", "/sources/requetes/$fileName.php");
    var response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    final List data = jsonDecode(response.body);

    //Iterable<Widget> cards = data.map((e) => makeCard(e))

    List<Widget> cards = [];

    for (int i = 0; i < data.length; i++) {
      cards.add(PresentationCard(e: data[i], tableName: widget.tableName));
    }

    return cards;
  }

  // void deleteVoid(int id) async {
  //   /* Popup pour supprimer le parking */
  //   String s = widget.tableName;
  //   var url = Uri.https("datacampus-bordeaux.fr",
  //       "/sources/requetes/API_flutter/${s}_delete.php", {"id": id.toString()});
  //   print(url);
  //   //print(url);
  //   await http.post(url);
  //   //supprimer la card correspondante

  //   //TODO setState(cards.remove(e));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // aller à la page d'ajout de parking
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        addToTables(tableName: widget.tableName)),
                //addParkings()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getViewTables(),
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
