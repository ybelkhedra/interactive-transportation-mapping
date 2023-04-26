import 'package:flutter/material.dart';

class CoordinatesLines extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final List<Map<String, TextEditingController>> listCoordinates;
  final int controllerOrlistCoordinates; // 0 = controller, 1 = listCoordinates

  const CoordinatesLines(
      {Key? key,
      required this.controllers,
      required this.listCoordinates,
      required this.controllerOrlistCoordinates})
      : super(key: key);

  @override
  State<CoordinatesLines> createState() => _CoordinatesLinesState();
}

class _CoordinatesLinesState extends State<CoordinatesLines> {
  Widget latLongLine(TextEditingController lat, TextEditingController long,
      {bool plus = false, bool moins = false, int indexToDel = -1}) {
    return Row(
        children: [
              Flexible(
                  child: TextFormField(
                controller: lat,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Latitude',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une latitude';
                  }
                  return null;
                },
              )),
              Flexible(
                child: TextFormField(
                  controller: long,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Longitude',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une longitude';
                    }
                    return null;
                  },
                ),
              )
            ] +
            [
              if (moins)
                Flexible(
                    child: ElevatedButton(
                        onPressed: () => {
                              setState(() => {
                                    widget.listCoordinates.remove(
                                        widget.listCoordinates[indexToDel]),
                                  })
                            },
                        child: const Icon(Icons.remove)))
            ] +
            [
              if (plus)
                Flexible(
                    child: ElevatedButton(
                        onPressed: () => {
                              setState(() => {
                                    //if the previous line is empty, we don't add a new line
                                    if (widget.listCoordinates.last["latitude"]
                                                ?.text !=
                                            "" &&
                                        widget.listCoordinates.last["longitude"]
                                                ?.text !=
                                            "")
                                      widget.listCoordinates.add({
                                        "latitude": TextEditingController(),
                                        "longitude": TextEditingController()
                                      })
                                  })
                            },
                        child: const Icon(Icons.add)))
            ]);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controllerOrlistCoordinates == 0) {
      return latLongLine(
          widget.controllers["latitude"]!, widget.controllers["longitude"]!);
    } else {
      return Column(
        children: [
          for (int i = 0; i < widget.listCoordinates.length; ++i)
            latLongLine(widget.listCoordinates[i]["latitude"]!,
                widget.listCoordinates[i]["longitude"]!,
                plus: i == widget.listCoordinates.length - 1,
                moins: widget.listCoordinates.length > 1,
                indexToDel: i)
        ],
      );
    }
  }
}
