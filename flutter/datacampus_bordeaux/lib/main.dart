import 'package:flutter/material.dart';
import 'login.dart';
import 'MapView.dart';

void main() async {
  runApp(const MyApp());
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
          color: Color.fromARGB(255, 28, 103, 215),
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
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.map, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 1;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.login, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 2;
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
                child: Text('Home'),
              ),
              //const MapView(),
              const MapView(),
              const LoginView(),
            ],
          ),
        ),
      ],
    ));
  }
}
