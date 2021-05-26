import 'dart:math';

/// Example of setting an initial viewport for ordinal axis.
///
/// This allows for specifying the specific range of data to show that differs
/// from what was provided in the series list.
///
/// In this example, the series list has ordinal data from year 2014 to 2030,
/// but we want to show starting at 2018 and we only want to show 4 values.
/// We can do this by specifying an [OrdinalViewport] in [OrdinalAxisSpec].
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/widget/coustm_text.dart';

class OrdinalInitialViewport extends StatelessWidget {
  final List<charts.Series> seriesList;
  final List<charts.Series> seriesList2;
  final bool animate;

  OrdinalInitialViewport(this.seriesList, this.seriesList2, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory OrdinalInitialViewport.withSampleData() {
    return OrdinalInitialViewport(
      _createSampleData(),
      _createSampleData2(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              child: CustomText(
                text: 'PH',
                color: primaryColor,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: Get.height * 0.3,
              child: new charts.BarChart(
                seriesList,
                animate: true,
                domainAxis: charts.OrdinalAxisSpec(
                    viewport: charts.OrdinalViewport('Sun', 6)),
                behaviors: [charts.PanAndZoomBehavior()],
              ),
            ),
            Container(
              width: Get.width,
              child: CustomText(
                text: 'Time',
                color: primaryColor,
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              width: Get.width,
              child: CustomText(
                text: 'Moisture',
                color: primaryColor,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: Get.height * 0.3,
              child: new charts.BarChart(
                seriesList2,
                animate: true,
                domainAxis: charts.OrdinalAxisSpec(
                    viewport: charts.OrdinalViewport('Sun', 6)),
                behaviors: [charts.PanAndZoomBehavior()],
              ),
            ),
            Container(
              width: Get.width,
              child: CustomText(
                text: 'Time',
                color: primaryColor,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    var rng = new Random();
    final data = [
      new OrdinalSales('Sun', rng.nextInt(14)),
      new OrdinalSales('Mon', rng.nextInt(14)),
      new OrdinalSales('Tus', rng.nextInt(14)),
      new OrdinalSales('Wed', rng.nextInt(14)),
      new OrdinalSales('Thu', rng.nextInt(14)),
      new OrdinalSales('Fri', rng.nextInt(14)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData2() {
    var rng = new Random();
    final data = [
      new OrdinalSales('Sun', rng.nextInt(2)),
      new OrdinalSales('Mon', rng.nextInt(2)),
      new OrdinalSales('Tus', rng.nextInt(2)),
      new OrdinalSales('Wed', rng.nextInt(2)),
      new OrdinalSales('Thu', rng.nextInt(2)),
      new OrdinalSales('Fri', rng.nextInt(2)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
