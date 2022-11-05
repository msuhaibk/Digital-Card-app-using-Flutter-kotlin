import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Create one series with sample hard coded data.
 List<charts.Series<LinearSales, int>> _createSampleData() {
final data = [
new LinearSales(0, 100),
new LinearSales(1, 75),
new LinearSales(2, 25),
new LinearSales(3, 5),
];

return [
new charts.Series<LinearSales, int>(
id: 'Sales',
domainFn: (LinearSales sales, _) => sales.year,
measureFn: (LinearSales sales, _) => sales.sales,
data: data,
)
];
}

class GridDashboard extends StatelessWidget {






    @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);
    //charts.PieChart(seriesList, animate: animate)
   // _createSampleData();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: SizeConfig.screenWidth/2-20,
          height: SizeConfig.screenWidth/2-20,
          decoration: BoxDecoration(
              color: Color(COLOR_SECONDARY),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              commonTitleBigBold(context, providerListener.TotalVisits.toString()),
              SizedBox(
                height: 5,
              ),
              commonTitleSmall(context, "Total Visits made"),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    commonSubTitleSmall(context, "No. of people viewed your FliQCard"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: SizeConfig.screenWidth/2-20,
          height: SizeConfig.screenWidth/2-20,
          decoration: BoxDecoration(
              color: Color(COLOR_SECONDARY),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              commonTitleBigBold(context, providerListener.TotalSaved.toString()),
              SizedBox(
                height: 5,
              ),
              commonTitleSmall(context, "Total Saved"),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    commonSubTitleSmall(context, "No. of people saved your FliQCard in address book"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
}


class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
