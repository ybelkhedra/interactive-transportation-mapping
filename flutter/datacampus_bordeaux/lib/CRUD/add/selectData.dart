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
  final List<String>? selected;
  final bool multiple;
  SelectData(
      {super.key,
      required this.tableName,
      required this.champs,
      required this.multiple,
      required this.selected}) {
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
              return const Text("Chargement...");
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
          canTapOnHeader: true,
          body: Column(
            children: [
              for (int i = 0; i < idNames!.length; i++)
                CheckboxListTile(
                  title: Text("${idNames[i][0]}-${idNames[i][1]}"),
                  value: widget.selected?.contains(idNames[i][0]),
                  onChanged: (bool? value) {
                    setState(() {
                      if (widget.multiple) {
                        if (value == true) {
                          widget.selected?.add(idNames[i][0]);
                        } else {
                          widget.selected?.remove(idNames[i][0]);
                        }
                      } else {
                        if (value == true) {
                          widget.selected?.clear();
                          widget.selected?.add(idNames[i][0]);
                        }
                      }
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
