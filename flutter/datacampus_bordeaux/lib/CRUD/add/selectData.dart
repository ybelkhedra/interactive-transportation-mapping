import 'package:flutter/material.dart';
import 'dart:convert';
import '../table_helper.dart';
import 'package:http/http.dart' as http;

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class SelectData extends StatefulWidget {
  final String tableName;
  final String champs;
  final List<Item> _data = [];
  SelectData({super.key, required this.tableName, required this.champs}) {
    _data.add(Item(
        expandedValue: "hello",
        headerValue: tableHelper[tableName][champs]["nom"]));
  }

  @override
  State<SelectData> createState() => _SelectDataState();
}

class _SelectDataState extends State<SelectData> {
  Future<List<List<String>>> getElementFromTable(String nameTable) async {
    var url = Uri.https("datacampus-bordeaux.fr",
        "/sources/requetes/${tableHelper[nameTable]["script"]}.php");
    var response = await http.get(url);
    final responseJson = json.decode(response.body);
    List<List<String>> names = [];
    for (var data in responseJson) {
      //print("DEBUG: ${data["id"]}-${data[value]} ${value}");
      names.add([
        data["id"],
        data[tableHelper[widget.tableName][widget.champs]["champs"]]
      ]);
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<List<List<String>>>(
            future: getElementFromTable(
                tableHelper[widget.tableName][widget.champs]["table"]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildPanel(snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  Widget _buildPanel(List<List<String>>? idNames) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget._data[index].isExpanded = !isExpanded;
        });
      },
      children: widget._data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Column(
            children: [
              for (int i = 0; i < idNames!.length; i++)
                CheckboxListTile(
                  title: Text("${idNames[i][0]}-${idNames[i][1]}"),
                  value: false,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                      } else {}
                    });
                  },
                ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
