import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class LineChartSample2 extends StatefulWidget {
  final List<List<FlSpot>> Data;
  const LineChartSample2({Key? key, required this.Data}) : super(key: key);
  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColorsBleu = [
    const Color.fromARGB(255, 86, 228, 253),
    const Color.fromARGB(255, 16, 120, 205),
  ];
  List<Color> gradientColorsVert = [
    const Color.fromARGB(255, 64, 227, 205),
    const Color.fromARGB(255, 5, 165, 125),
  ];
  List<Color> gradientColorsRouge = [
    Color.fromARGB(255, 232, 126, 126),
    Color.fromARGB(255, 180, 39, 75),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Titre de la courbe : courbe du trafic routier de la journée
        const Text(
          "Courbe du trafic routier de la journée",
          style: TextStyle(
            color: Color.fromARGB(255, 19, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        AspectRatio(aspectRatio: 2.5, child: LineChart(mainData())),
      ],
    );
  }

  LineChartData mainData() {
    List<FlSpot> spotsData = widget.Data[0];
    List<FlSpot> spotsReffluid = widget.Data[1];
    List<FlSpot> spotsRefdense = widget.Data[2];
    List<FlSpot> spotsRefexcep = widget.Data[3];
    List<FlSpot> spotsPrevision = widget.Data[4];

    double minY = spotsData[0].y;
    double maxY = spotsData[0].y;

    int cpt_appel_legende = 0;

    for (int i = 0; i < spotsData.length; i++) {
      if (spotsData[i].y > maxY) {
        maxY = spotsData[i].y;
      }
      if (spotsReffluid[i].y > maxY) {
        maxY = spotsReffluid[i].y;
      }
      if (spotsRefdense[i].y > maxY) {
        maxY = spotsRefdense[i].y;
      }
      if (spotsData[i].y < minY) {
        minY = spotsData[i].y;
      }
      if (spotsReffluid[i].y < minY) {
        minY = spotsReffluid[i].y;
      }
      if (spotsRefdense[i].y < minY) {
        minY = spotsRefdense[i].y;
      }
    }

    LineChartBarData lineDense = LineChartBarData(
      // on appelle la fonction qui recupere les valeurs de la courbe getSpots() async
      spots: spotsRefdense,
      isCurved: true,
      curveSmoothness: 0.6,
      gradient: LinearGradient(
        colors: gradientColorsRouge,
      ),
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: gradientColorsRouge
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
    );

    LineChartBarData lineReffluid = LineChartBarData(
      // on appelle la fonction qui recupere les valeurs de la courbe getSpots() async
      spots: spotsReffluid,
      isCurved: true,
      curveSmoothness: 0.6,
      gradient: LinearGradient(
        colors: gradientColorsVert,
      ),
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: gradientColorsVert
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
    );

    LineChartBarData lineActuel = LineChartBarData(
      // on appelle la fonction qui recupere les valeurs de la courbe getSpots() async
      spots: spotsData,
      isCurved: true,
      curveSmoothness: 0.6,
      gradient: LinearGradient(
        colors: gradientColorsBleu,
      ),
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: gradientColorsBleu
              .map((color) => color.withOpacity(0.3))
              .toList(),
        ),
      ),
    );

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 10,
          );
        },
      ),
      titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (double value, TitleMeta meta) {
                cpt_appel_legende++;
                if (cpt_appel_legende % 4 == 0) {
                  return Text(
                      //avec la taille de spotsData, on sait que une data correspond à 5 min et que l'on a les dernière data jusqu'à maintenant. Afficher la legende avec : il y a 5 min, il y a 10 min, il y a 15 min, il y a 20 min, il y a 25 min, il y a 30 min ... en fonction de la taille de la liste
                      "il y a ${spotsData.length * 5 - value.toInt() * 5} min",
                      style: const TextStyle(
                          color: Color.fromARGB(179, 38, 129, 179),
                          fontWeight: FontWeight.bold,
                          fontSize: 17));
                } else {
                  return const Text("");
                }
              },
            ),
          )),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: Color.fromARGB(116, 107, 123, 136)),
      ),
      //minX est la valeur de X la plus petite de spotsData et maxX est la valeur de X la plus grande de spotsData
      minX: spotsData[0].x,
      maxX: spotsData[spotsData.length - 1].x,
      //minY est la valeur minimal de Y et maxY est la valeur maximal de Y
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        lineDense,
        lineReffluid,
        lineActuel,
      ],
      //enlever l'affiche du curseur
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              // spotsReferenceY est un tableau contenant tout les y des spots de la courbe de reference. le faire avec une map
              final spotsRefDenseY = spotsRefdense.map((e) => e.y).toList();
              final spotsRefFluidY = spotsReffluid.map((e) => e.y).toList();
              final spotsDataY = spotsData.map((e) => e.y).toList();
              if (spotsRefDenseY.contains(flSpot.y)) {
                return LineTooltipItem(
                  "Trafic dense : ${flSpot.y.toStringAsFixed(2)}",
                  const TextStyle(color: Color.fromARGB(255, 241, 187, 187)),
                );
              } else if (spotsRefFluidY.contains(flSpot.y)) {
                return LineTooltipItem(
                  "Trafic fluide : ${flSpot.y.toStringAsFixed(2)}",
                  const TextStyle(color: Color.fromARGB(255, 176, 242, 205)),
                );
              } else {
                return LineTooltipItem(
                  "Trafic actuel : ${flSpot.y.toStringAsFixed(2)}",
                  const TextStyle(color: Color.fromARGB(255, 173, 209, 246)),
                );
              }
            }).toList();
          },
        ),
      ),
    );
  }
}
