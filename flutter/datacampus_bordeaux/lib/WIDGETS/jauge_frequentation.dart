import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fl_chart/fl_chart.dart';

class JaugeFrequentation extends StatefulWidget {
  final List<List<FlSpot>> Data;
  const JaugeFrequentation({Key? key, required this.Data}) : super(key: key);
  @override
  State<JaugeFrequentation> createState() => _JaugeFrequentationState();
}

class _JaugeFrequentationState extends State<JaugeFrequentation> {
  @override
  Widget build(BuildContext context) {
    //derniere valeur de la courbe
    FlSpot trafic = widget.Data[0][widget.Data[0].length - 1];
    FlSpot fluid = widget.Data[1][widget.Data[1].length - 1];
    FlSpot dense = widget.Data[2][widget.Data[2].length - 1];
    FlSpot exce = widget.Data[3][widget.Data[3].length - 1];
    FlSpot prev = widget.Data[4][widget.Data[4].length - 1];

    List<double> list = [trafic.y, fluid.y, dense.y, exce.y, prev.y];
    double maxY = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] > maxY) {
        maxY = list[i];
      }
    }
    //print("fluid.y = ${fluid.y}"
    // "dense.y = ${dense.y}"
    // "exce.y = ${exce.y}"
    // "prev.y = ${prev.y}"
    // "actual = ${trafic.y}");
    return Column(
      children: [
        //Titre de la gauge : "Etat du trafic actuel :"
        Text("Etat du trafic actuel :",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        Container(
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: maxY, ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0, endValue: fluid.y, color: Colors.green),
                GaugeRange(
                    startValue: fluid.y,
                    endValue: dense.y,
                    color: Color.fromARGB(255, 25, 143, 198)),
                GaugeRange(
                    startValue: dense.y,
                    endValue: dense.y * 1.4,
                    color: Colors.red),
                GaugeRange(
                    startValue: dense.y * 1.4,
                    endValue: maxY,
                    color: Colors.purple),
              ], pointers: <GaugePointer>[
                NeedlePointer(
                  value: trafic.y,
                  needleColor: Colors.black,
                  needleStartWidth: 1,
                  needleEndWidth: 5,
                  needleLength: 0.8,
                  lengthUnit: GaugeSizeUnit.factor,
                )
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text(trafic.y.toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 90,
                    positionFactor: 0.5)
              ])
            ],
            animationDuration: 4000,
            enableLoadingAnimation: true,
          ),
        ),
      ],
    );
  }
}
