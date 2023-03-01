import 'package:datacampus_bordeaux/CRUD/parkings.dart';
import 'package:datacampus_bordeaux/CRUD/points_de_charge.dart';
import 'package:datacampus_bordeaux/CRUD/freefloating.dart';
import 'package:datacampus_bordeaux/CRUD/points_de_covoiturage.dart';
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
      List<String> tables = [
        "Parkings",
        "Recharges elec",
        "Freefloating",
        "Pistes cyclabes",
        "Emplacement parking",
        "Coivoiturage",
      ];
      return tables; //sense appeler le script php sources/requetes/all_tables.php
    }

    final _controller = SidebarXController(selectedIndex: 0, extended: true);

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
                SideBarXExample(
                    controller: _controller, tableNames: snapshot.data!),
                // Your app screen body
                Expanded(
                    child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      //sense contenir le crud pour la table selectionnee
                      if (snapshot.data![_controller.selectedIndex] ==
                          "Parkings") {
                        return const Parkings();
                      } else if (snapshot.data![_controller.selectedIndex] ==
                          "Recharges elec") {
                        return const PointsDeCharge();
                      } else if (snapshot.data![_controller.selectedIndex] ==
                          "Freefloating") {
                        return const Freefloating();
                      } else if (snapshot.data![_controller.selectedIndex] ==
                          "Coivoiturage") {
                        return const PointDeCovoiturage();
                      } else {
                        return Center(
                            child: Text(
                                snapshot.data![_controller.selectedIndex]));
                      }
                    },
                  ),
                ))
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

class SideBarXExample extends StatelessWidget {
  final canvasColor = const Color(0xFF2E2E48);
  final scaffoldBackgroundColor = const Color(0xFF464667);
  final accentCanvasColor = const Color(0xFF3E3E61);
  final white = Colors.white;
  final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
  final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);

  final SidebarXController _controller;
  final List<String> tableNames;
  SideBarXExample(
      {Key? key,
      required SidebarXController controller,
      required this.tableNames})
      : _controller = controller,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xFF2E2E48),
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo-chair.png'),
          ),
        );
      },
      items: tableNames
          .map((e) => SidebarXItem(
              icon: e == "Parkings"
                  ? Icons.local_parking_outlined
                  : e == "Recharges elec"
                      ? Icons.electric_car
                      : e == "Freefloating"
                          ? Icons.electric_scooter
                          : Icons.table_chart,
              label: e))
          .toList(),
    );
  }
}
