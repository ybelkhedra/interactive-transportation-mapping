import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class AddCoordinatesMap extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final List<Map<String, TextEditingController>> listCoordinates;
  final int controllerOrlistCoordinates; // 0 = controller, 1 = listCoordinates
  const AddCoordinatesMap(
      {super.key,
      required this.controllers,
      required this.listCoordinates,
      required this.controllerOrlistCoordinates});

  @override
  State<AddCoordinatesMap> createState() => _AddCoordinatesMapState();
}

class _AddCoordinatesMapState extends State<AddCoordinatesMap> {
  LatLng? _currentPosition;

  LatLng createCoordinate(String lat, String long) {
    return LatLng(double.parse(lat), double.parse(long));
  }

  double lat = 44.79517;
  double long = -0.603537;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          double.parse(lat.toString()),
          double.parse(long.toString()),
        ),
        zoom: 15.0,
        onTap: _handleTap,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        if (widget.listCoordinates.isNotEmpty)
          MarkerLayer(
            markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _currentPosition ??
                        LatLng(
                          double.parse(lat.toString()),
                          double.parse(long.toString()),
                        ),
                    builder: (ctx) => Container(
                      child: const Icon(Icons.location_on_rounded, size: 40),
                    ),
                  )
                ] +
                [
                  if (widget.controllerOrlistCoordinates >= 1)
                    for (var i = 0; i < widget.listCoordinates.length - 1; i++)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(
                          double.parse(
                              widget.listCoordinates[i]['latitude']?.text ??
                                  lat.toString()),
                          double.parse(
                              widget.listCoordinates[i]['longitude']?.text ??
                                  long.toString()),
                        ),
                        builder: (ctx) => Container(
                          child:
                              const Icon(Icons.location_on_rounded, size: 40),
                        ),
                      ),
                ],
          ),
        if (widget.listCoordinates.length > 1)
          PolylineLayer(polylineCulling: false, polylines: [
            Polyline(
              points: [
                for (var i = 0; i < widget.listCoordinates.length - 1; i++)
                  if ((widget.listCoordinates[i]['latitude']?.text != null &&
                          widget.listCoordinates[i]['longitude']?.text !=
                              null) ||
                      !(widget.listCoordinates[i]['latitude']?.text == "" ||
                          widget.listCoordinates[i]['longitude']?.text == ""))
                    LatLng(
                      double.parse(
                          widget.listCoordinates[i]['latitude']?.text ??
                              lat.toString()),
                      double.parse(
                          widget.listCoordinates[i]['longitude']?.text ??
                              long.toString()),
                    ),
              ],
              color: Colors.red,
              strokeWidth: 4.0,
              borderColor: Colors.black,
              borderStrokeWidth: 1.0,
            ),
          ]),
      ],
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _currentPosition = latlng;
      if (widget.controllerOrlistCoordinates == 0) {
        widget.controllers['latitude']?.text =
            _currentPosition!.latitude.toString();
        widget.controllers['longitude']?.text =
            _currentPosition!.longitude.toString();
      } else {
        // print(widget.listCoordinates);
        widget.listCoordinates[widget.listCoordinates.length - 1]['latitude']
            ?.text = _currentPosition!.latitude.toString();
        widget.listCoordinates[widget.listCoordinates.length - 1]['longitude']
            ?.text = _currentPosition!.longitude.toString();
      }
    });
  }
}
