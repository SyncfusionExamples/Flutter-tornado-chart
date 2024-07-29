import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_PopulationData>? data;

  @override
  void initState() {
    super.initState();
    data = [
      _PopulationData('0-4', 70.12, 69.12),
      _PopulationData('5-9', 75.23, 74.23),
      _PopulationData('10-14', 76.34, 74.44),
      _PopulationData('15-19', 76.15, 76.11),
      _PopulationData('20-24', 75.63, 77.22),
      _PopulationData('25-29', 75.75, 75.45),
      _PopulationData('30-34', 74.21, 75.67),
      _PopulationData('35-39', 73.50, 73.78),
      _PopulationData('40-44', 67.65, 70.12),
      _PopulationData('45-49', 65.33, 70.32),
      _PopulationData('50-54', 60.44, 63.54),
      _PopulationData('55-59', 54.67, 55.63),
      _PopulationData('60-64', 42.87, 43.71),
      _PopulationData('65-69', 34.98, 33.87),
      _PopulationData('70-74', 25.12, 25.66),
      _PopulationData('75-79', 18.11, 19.22),
      _PopulationData('80-84', 15.11, 14.22),
      _PopulationData('85-89', 10.11, 9.22),
      _PopulationData('90-94', 3.11, 3.22),
      _PopulationData('95-99', 1.11, 1.22),
      _PopulationData('100+', 0.3, 0.25),
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
                majorGridLines: const MajorGridLines(
                  width: 0,
                ),
                axisLabelFormatter: (AxisLabelRenderDetails args) {
                  String text = args.text.replaceAll('-', ' ');
                  return ChartAxisLabel(
                    text,
                    args.textStyle,
                  );
                },
              ),
              onDataLabelRender: (DataLabelRenderArgs dataLabelArgs) {
                if (dataLabelArgs.text != null) {
                  dataLabelArgs.text =
                      '${dataLabelArgs.text!.replaceAll('-', ' ')}M';
                }
              },
              tooltipBehavior: TooltipBehavior(enable: true),
              onTooltipRender: (TooltipArgs tooltipArgs) {
                if (tooltipArgs.text != null) {
                  String text = '${tooltipArgs.text!.replaceAll(' -', ' ')}M';
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
