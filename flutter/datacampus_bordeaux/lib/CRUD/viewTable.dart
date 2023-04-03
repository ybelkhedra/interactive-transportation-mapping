import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'presentation_card.dart';
import 'table_helper.dart';
import 'add/addToTables.dart';

class ViewTable extends StatefulWidget {
  final String tableName;

  const ViewTable({Key? key, required this.tableName}) : super(key: key);

  @override
  State<ViewTable> createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {
  bool isEmpty = false;
  //fonction qui retourne une liste de card à partir d'une liste de ViewTabless (json) obtenu par une requete http sur "145.239.198.30", "/sources/requetes/ViewTabless.php"
  Future<List<Widget>> getViewTables() async {
    isEmpty = false;
    String fileName = tableHelper[widget.tableName]!['script'];
    var url =
        Uri.https("datacampus-bordeaux.fr", "/sources/requetes/$fileName.php");
    var response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //si la requete ne retourne rien, on affiche un message
    if (response.body == "null") {
      isEmpty = true;
      print("empty");
      return [];
    }

    final List data = jsonDecode(response.body);

    List<Widget> cards = [];

    for (int i = 0; i < data.length; i++) {
      cards.add(PresentationCard(
          e: data[i],
          tableName: widget.tableName,
          deleteElement: deleteElement));
    }

    return cards;
  }

  Future<void> deleteElement(String id) async {
    var url = Uri.https(
        "datacampus-bordeaux.fr",
        "/sources/requetes/API_flutter/delete.php",
        {"nom": widget.tableName, "id": id});
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(tableHelper[widget.tableName]!['nom_jolie']),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddToTable(tableName: widget.tableName)),
              );
              setState(() {
                isEmpty = false;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: getViewTables(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (isEmpty) {
              return const Text('Aucun élément dans cette table');
            } else if (snapshot.hasData) {
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
