import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_PopulationData>? data;
  final double _totalPopulation = 439719008;

  @override
  void initState() {
    super.initState();
    data = [
      _PopulationData('0-4', 15687321, 15039014),
      _PopulationData('5-9', 16577877, 15890115),
      _PopulationData('10-14', 16888377, 16197733),
      _PopulationData('15-19', 17136711, 16484380),
      _PopulationData('20-24', 17472667, 16960958),
      _PopulationData('25-29', 17616377, 17303882),
      _PopulationData('30-34', 17318629, 17186302),
      _PopulationData('35-39', 16836127, 16902230),
      _PopulationData('40-44', 15723691, 16027059),
      _PopulationData('45-49', 13959888, 14450695),
      _PopulationData('50-54', 12313479, 13002373),
      _PopulationData('55-59', 11037894, 11955793),
      _PopulationData('60-64', 9388603, 10557282),
      _PopulationData('65-69', 7297733, 8619037),
      _PopulationData('70-74', 5269323, 6634432),
      _PopulationData('75-79', 3357561, 4560921),
      _PopulationData('80-84', 1911079, 2936309),
      _PopulationData('85-89', 781112, 1481688),
      _PopulationData('90-94', 209008, 541978),
      _PopulationData('95-99', 37879, 137868),
      _PopulationData('100+', 4440, 23175),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: 'Population Pyramid of ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Females',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' vs ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              TextSpan(
                text: 'Males',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Expanded(
            child: SfCartesianChart(
              backgroundColor: Colors.white,
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.all(12),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(
                  width: 0,
                ),
              ),
              primaryYAxis: NumericAxis(
                minimum: -20000000,
                maximum: 20000000,
                majorGridLines: const MajorGridLines(
                  width: 0,
                ),
                axisLabelFormatter: (AxisLabelRenderDetails args) {
                  int value = ((args.value / _totalPopulation) * 100).round();
                  String text = '${value.toString().replaceAll('-', ' ')}%';
                  return ChartAxisLabel(
                    text,
                    args.textStyle,
                  );
                },
              ),
              onDataLabelRender: (DataLabelRenderArgs dataLabelArgs) {
                if (dataLabelArgs.text != null) {
                  double population =
                      ((dataLabelArgs.dataPoints[dataLabelArgs.pointIndex].y /
                                  _totalPopulation) *
                              100) /
                          100;
                  String percentageString =
                      NumberFormat("##0.0%").format(population);
                  dataLabelArgs.text = percentageString.replaceAll('-', ' ');
                }
              },
              tooltipBehavior: TooltipBehavior(enable: true),
              onTooltipRender: (TooltipArgs tooltipArgs) {
                if (tooltipArgs.text != null) {
                  String text = tooltipArgs.text!.replaceAll(' -', ' ');
                  tooltipArgs.text = text;
                }
              },
              series: <CartesianSeries<_PopulationData, String>>[
                BarSeries<_PopulationData, String>(
                  dataSource: data,
                  xValueMapper: (_PopulationData population, int index) =>
                      population.x,
                  yValueMapper: (_PopulationData population, int index) =>
                      population.y1,
                  name: 'Female',
                  color: Colors.pink,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    labelIntersectAction: LabelIntersectAction.none,
                    textStyle: TextStyle(
                      color: Colors.pink,
                    ),
                  ),
                ),
                BarSeries<_PopulationData, String>(
                  dataSource: data,
                  xValueMapper: (_PopulationData population, int index) =>
                      population.x,
                  yValueMapper: (_PopulationData population, int index) =>
                      population.y2,
                  name: 'Male',
                  color: Colors.blue,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    labelIntersectAction: LabelIntersectAction.none,
                    textStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PopulationData {
  _PopulationData(this.x, this.y1, this.y2) {
    y1 = -y1;
  }

  final String x;
  double y1;
  double y2;
}
