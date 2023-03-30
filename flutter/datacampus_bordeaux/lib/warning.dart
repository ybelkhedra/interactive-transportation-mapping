//page qui montre une crois rouge avec le message : vous devez vous connecter pour accéder à cette page, avec animation dynamique
import 'package:flutter/material.dart';

class warning extends StatefulWidget {
  const warning({Key? key}) : super(key: key);

  @override
  _warningState createState() => _warningState();
}

class _warningState extends State<warning> {
  //variable globale pour toute la session qui dit si l'utilisateur est connecté ou pas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Vous devez vous connecter pour accéder à cette page",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
