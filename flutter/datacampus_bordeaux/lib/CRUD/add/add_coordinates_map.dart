import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class AddCoordinatesMap extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  const AddCoordinatesMap({super.key, required this.controllers});

  @override
  State<AddCoordinatesMap> createState() => _AddCoordinatesMapState();
}

class _AddCoordinatesMapState extends State<AddCoordinatesMap> {
  int _nbClics = 0;
  LatLng? _currentPosition;

  double lat = 44.79517;
  double long = -0.603537;
  @override
  Widget build(BuildContext context) {
    print('build');
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
                child: const Icon(Icons.local_parking_outlined, size: 50),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _currentPosition = latlng;
      widget.controllers['latitude']?.text =
          _currentPosition!.latitude.toString();
      widget.controllers['longitude']?.text =
          _currentPosition!.longitude.toString();
      //print(_currentPosition);
      _nbClics++;
    });
  }
}
