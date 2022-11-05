import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

var ischart = 0;

class DonutPieChart extends StatelessWidget {
  final bool animate = true;

  DonutPieChart();

  factory DonutPieChart.withSampleData() {
    return new DonutPieChart();
  }

  @override
  Widget build(BuildContext context) {
    // print(providerListener.contactsBUSINESS_COUNT);

    final List<charts.Series> seriesList = _createFliqData(context);

    return Container(
      width: SizeConfig.screenWidth,
      height: 200,
      child: (Row(children: [
        Expanded(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            child: (ischart > 0
                ? charts.PieChart(seriesList,
                    animate: animate,

                    // palette: <Color>[Colors.amber, Colors.brown, Colors.green, Colors.redAccent, Colors.blueAccent, Colors.teal],
                    behaviors: [
                      new charts.DatumLegend(
                        // Positions for "start" and "end" will be left and right respectively
                        // for widgets with a build context that has directionality ltr.
                        // For rtl, "start" and "end" will be right and left respectively.
                        // Since this example has directionality of ltr, the legend is
                        // positioned on the right side of the chart.
                        position: charts.BehaviorPosition.start,
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        // By default, if the position of the chart is on the left or right of
                        // the chart, [horizontalFirst] is set to false. This means that the
                        // legend entries will grow as new rows first instead of a new column.
                        horizontalFirst: false,
                        // This defines the padding around each legend entry.
                        cellPadding: new EdgeInsets.only(
                            left: 10, right: 4.0, bottom: 4.0),
                        // Set [showMeasures] to true to display measures in series legend.
                        // showMeasures: true,
                        // Configure the measure value to be shown by default in the legend.
                        legendDefaultMeasure:
                            charts.LegendDefaultMeasure.firstValue,
                        // Optionally provide a measure formatter to format the measure value.
                        // If none is specified the value is formatted as a decimal.
                        // measureFormatter: (num value) {
                        //   return value == null ? '-' : '${value}k';
                        // },
                      ),
                    ],
                    // Configure the width of the pie slices to 60px. The remaining space in
                    // the chart will be left as a hole in the center.
                    // defaultRenderer:
                    //     new charts.ArcRendererConfig(arcWidth: 60)))
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 60,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator()
                        ]))
                : Text(
                    "You don't have Sent or Received FliQ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
                  ))),
      ])),
      // ],
    );
  }
}

List<charts.Series<LinearFliq, Object>> _createFliqData(context) {
  final providerListener = Provider.of<CustomViewModel>(context);

  final Ncount =
      providerListener.sharedNEW_COUNT + providerListener.contactsNEW_COUNT;

  final Ccount = providerListener.sharedCLIENT_COUNT +
      providerListener.contactsCLIENT_COUNT;

  final Fmcount = providerListener.sharedFAMILY_COUNT +
      providerListener.contactsFAMILY_COUNT;

  final Frcount = providerListener.sharedFRIEND_COUNT +
      providerListener.contactsFRIEND_COUNT;

  final Bcount = providerListener.contactsBUSINESS_COUNT +
      providerListener.sharedBUSINESS_COUNT;

  final Vcount = providerListener.sharedVENDOR_COUNT +
      providerListener.contactsVENDOR_COUNT;

  final Ocount =
      providerListener.sharedOTHER_COUNT + providerListener.contactsOTHER_COUNT;

  ischart = Ncount + Ccount + Fmcount + Frcount + Bcount + Vcount + Ocount;

  final data = [
    new LinearFliq('New', Ncount, charts.MaterialPalette.cyan.shadeDefault),
    new LinearFliq('Clients', Ccount, charts.MaterialPalette.teal.shadeDefault),
    new LinearFliq('Family', Fmcount, charts.MaterialPalette.red.shadeDefault),
    new LinearFliq(
        'Friends', Frcount, charts.MaterialPalette.indigo.shadeDefault),
    new LinearFliq(
        'Business', Bcount, charts.MaterialPalette.deepOrange.shadeDefault),
    new LinearFliq('Vendor', Vcount, charts.MaterialPalette.black),
    new LinearFliq('Others', Ocount, charts.MaterialPalette.gray.shadeDefault),
  ];

  return [
    new charts.Series<LinearFliq, Object>(
      id: 'Sales',
      domainFn: (LinearFliq sales, _) => sales.category,
      measureFn: (LinearFliq sales, _) => sales.count,
      colorFn: (LinearFliq sales, _) => sales.color,
      data: data,
      // Set a label accessor to control the text of the arc label.
      labelAccessorFn: (LinearFliq row, _) => '${row.count}',
    )
  ];
}

class LinearFliq {
  final String category;
  final int count;
  final charts.Color color;

  LinearFliq(this.category, this.count, this.color);
}
