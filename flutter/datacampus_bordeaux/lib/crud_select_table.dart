import 'package:datacampus_bordeaux/CRUD/viewTable.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'CRUD/table_helper.dart';
import 'main.dart';

class CrudSelectTable extends StatefulWidget {
  const CrudSelectTable({Key? key}) : super(key: key);

  @override
  State<CrudSelectTable> createState() => _CrudSelectTableState();
}

class _CrudSelectTableState extends State<CrudSelectTable> {
  @override
  Widget build(BuildContext context) {
    final _controller = SidebarXController(selectedIndex: 0, extended: true);
    List<String> tableNames = getTablesNames();
    List<String> tablePrettyName = getPrettyTablesNames();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
      ),
      body: Row(
        children: [
          SideBarXExample(controller: _controller, tableNames: tablePrettyName),
          // Your app screen body
          Expanded(
              child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ViewTable(
                    tableName: tableNames[_controller.selectedIndex]);
              },
            ),
          ))
        ],
      ),
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
      items: getIcons(),
    );
  }
}
