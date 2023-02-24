import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
// import 'dart:convert';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:http/http.dart' as http;

class CrudSelectTable extends StatefulWidget {
  const CrudSelectTable({Key? key}) : super(key: key);

  @override
  State<CrudSelectTable> createState() => _CrudSelectTableState();
}

class _CrudSelectTableState extends State<CrudSelectTable> {
  @override
  Widget build(BuildContext context) {
    Future<List<String>> getTables() async {
      // var url = Uri.http("145.239.198.30", "/sources/requetes/all_tables.php");
      // var response = await http.get(url);

      // var data = jsonDecode(response.body);
      // List<String> tables = data["name"];
      List<String> tables = ["table1", "table2", "table3"];
      return tables;
    }

    return FutureBuilder<List<String>>(
      future: getTables(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tables'),
            ),
            body: Row(
              children: [
                SidebarX(
                  controller:
                      SidebarXController(selectedIndex: 0, extended: true),
                  items: snapshot.data!
                      .map((e) =>
                          SidebarXItem(icon: Icons.table_chart, label: e))
                      .toList(),
                  // items: const [
                  //   SidebarXItem(icon: Icons.home, label: 'Home'),
                  //   SidebarXItem(icon: Icons.search, label: 'Search'),
                  // ],
                ),
                // Your app screen body
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
