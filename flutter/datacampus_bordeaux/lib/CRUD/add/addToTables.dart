import 'package:flutter/material.dart';
import 'addParkings.dart';
import 'addFreefloating.dart';

class addToTables extends StatefulWidget {
  final String tableName;
  const addToTables({Key? key, required this.tableName}) : super(key: key);

  @override
  State<addToTables> createState() => _addToTablesState();
}

//page qui affiche un formulaire d'ajout de parking
class _addToTablesState extends State<addToTables> {
  @override
  Widget build(BuildContext context) {
    if (widget.tableName == "parkings") {
      return const addParkings();
    } else if (widget.tableName == "stations_freefloating") {
      return const addFreefloating();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.tableName),
        ),
        body: Center(
          child: Text("Ajouter un ${widget.tableName}"),
        ),
      );
    }
  }
}
