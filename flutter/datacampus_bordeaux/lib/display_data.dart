import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final Future<String> textFuture;

  const DisplayData({Key? key, required this.textFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Données à copier'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: textFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return SelectableText(
                snapshot.data!,
                style: const TextStyle(fontSize: 17),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
