

import 'package:borsatakibim/ConstValues/ConstValues.dart';
import 'package:borsatakibim/Models.dart';
import 'package:borsatakibim/Screens/cryptoDetail.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoWidget extends StatelessWidget {
  CryptoWidget({super.key, this.crypto});
  Crypto? crypto;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(
          top: Get.size.height / 25,
          left: Get.size.width / 25,
          right: Get.size.width / 25),
      child: GestureDetector(
        onTap: () => Get.to(CryptoDetail(
          crypto: crypto,
        )),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.network(
                    "https://s2.coinmarketcap.com/static/img/coins/64x64/" +
                        crypto!.id.toString() +
                        ".png",
                    width: Get.size.width / 10,
                  )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      crypto!.cryptoName!,
                      style: GoogleFonts.lato(
                          fontSize: Get.size.width / 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(crypto!.symbol!),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(
                        crypto!.price! > 1
                            ? crypto!.price!.toStringAsFixed(2) + " \$"
                            : crypto!.price!.toStringAsFixed(6) + " \$",
                        style: TextStyle(fontSize: Get.size.width / 25),
                      ),
                      Text(" % " + crypto!.percentChange24h!.toStringAsFixed(4))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PriceChangeChart extends StatelessWidget {
  PriceChangeChart({super.key, this.crypto});
  Crypto? crypto;

  List<FlSpot> spots = [];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AspectRatio(
        aspectRatio: 1.70,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: LineChart(showAvg ? avgData() : mainData()),
        ),
      ),
    );
  }

  List<Color> gradientColors = [Colors.cyanAccent, ConstValues.purple];

  bool showAvg = false;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Yesterday', style: style);
        break;
      case 10:
        text = const Text('Today', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 2:
        if (crypto!.yesterDayPrice! < crypto!.price!) {
          text = crypto!.yesterDayPrice!.toStringAsFixed(4);
        } else {
          text = crypto!.price!.toStringAsFixed(4);
        }
        break;
      case 5:
        if (crypto!.yesterDayPrice! < crypto!.price!) {
          text = crypto!.price!.toStringAsFixed(4);
        } else {
          text = crypto!.yesterDayPrice!.toStringAsFixed(4);
        }
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    if (crypto!.yesterDayPrice! > crypto!.price!) {
  spots = [
    
    FlSpot(0, 2),
    FlSpot(11, 5),
  ];
} else {
  spots = [
    FlSpot(11, 2),
    FlSpot(0, 6),
  ];
}
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
