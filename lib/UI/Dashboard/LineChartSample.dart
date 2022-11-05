import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {

  List<charts.FlSpot>  listOfList = [];

  List<Color> gradientColors = [
    const Color(COLOR_SECONDARY),
    const Color(COLOR_SECONDARY),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(COLOR_PRIMARY)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: charts.LineChart(
                mainData(providerListener.ListOfScan.length>0?providerListener.ListOfScan:providerListener.ListOfScanZero),
              ),
            ),
          ),
        ),
      ],
    );
  }

  charts.LineChartData mainData(List<String> ListOfScan) {

    for(int k=0;k<12;k++){
     /* if(double.parse(ListOfScan[k]??"0")>0){
        listOfList.add(FlSpot(double.parse(k.toString()), double.parse(ListOfScan[k]??"0")));
      }*/
      listOfList.add(charts.FlSpot(double.parse(k.toString()), double.parse(ListOfScan[k]??"0")));
    }

    return charts.LineChartData(
      gridData: charts.FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return charts.FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return charts.FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: charts.FlTitlesData(
        show: true,
        bottomTitles: charts.SideTitles(
          showTitles: true,
          reservedSize: 22,
//          getTextStyles: (value) => TextStyle(
//              color: Color(COLOR_SECONDARY),
//              fontWeight: FontWeight.bold,
//              fontSize: 8),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'JAN';
              case 1:
                return 'FEB';
              case 2:
                return 'MAR';
              case 3:
                return 'APR';
              case 4:
                return 'MAY';
              case 5:
                return 'JUN';
              case 6:
                return 'JULY';
              case 7:
                return 'AUG';
              case 8:
                return 'SEPT';
              case 9:
                return 'OCT';
              case 10:
                return 'NOV';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: charts.SideTitles(
          showTitles: true,
//          getTextStyles: (value) => const TextStyle(
//            color: Color(COLOR_SECONDARY),
//            fontWeight: FontWeight.bold,
//            fontSize: 15,
//          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '50';
              case 3:
                return '150';
              case 5:
                return '250';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: charts.FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        charts.LineChartBarData(
          spots: listOfList,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: charts.FlDotData(
            show: false,
          ),
          belowBarData: charts.BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
