import 'package:datacampus_bordeaux/warning.dart';
import 'package:datacampus_bordeaux/crud_select_table.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login_admin.dart';
import 'export_tables.dart';

import 'global.dart' as globals;

void main() async {
  globals.isLoggedIn = false;
  runApp(MaterialApp(
    routes: {
      '/': (context) => const menu(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const menu(),
    );
  }
}

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  //variable globale pour toute la session qui dit si l'utilisateur est connecté ou pas
  static bool connected = false;

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: // 2 colonnes : celle de gauche fait 50px et le reste correspond à la deuxieme colone, leur hauteur prend toutes la page
            // la premiere colonne a une liste view, l'autre du texte
            Row(
      children: [
        Container(
          color: const Color.fromARGB(255, 28, 103, 215),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                //background bleu sur toute la colonne

                child: ListView(
                  physics:
                      const NeverScrollableScrollPhysics(), // pour centrer verticalement
                  shrinkWrap: true, // pour centrer verticalement
                  //background bleu sur toute la liste view
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 0;
                        });
                      },
                    ),
                    //espace entre les icones de 10px
                    // const SizedBox(height: 20),
                    // IconButton(
                    //   icon: const Icon(Icons.local_parking_outlined,
                    //       color: Colors.white),
                    //   onPressed: () {
                    //     setState(() {
                    //       currentPageIndex = 1;
                    //     });
                    //   },
                    // ),
                    //espace entre les icones de 10px
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.table_chart, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (globals.isLoggedIn == true) {
                            currentPageIndex = 1;
                          } else {
                            currentPageIndex = 3;
                          }
                          // currentPageIndex = 2;
                        });
                      },
                    ),
                    // const SizedBox(height: 20),
                    // IconButton(
                    //   icon: const Icon(Icons.login, color: Colors.white),
                    //   onPressed: () {
                    //     setState(() {
                    //       currentPageIndex = 3;
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.login, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 2;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.plus_one, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (globals.isLoggedIn == true) {
                            currentPageIndex = 4;
                          } else {
                            currentPageIndex = 3;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: currentPageIndex,
            children: [
              const Center(
                child: home(),
              ),
              const CrudSelectTable(),
              //LoginView(),
              LoginPage(),
              const warning(),
              ExportTable(),
            ],
          ),
        ),
      ],
    ));
  }
}
