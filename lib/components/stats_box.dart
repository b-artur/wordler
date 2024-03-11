import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_tile.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/keys_map.dart';
import 'package:wordle/main.dart';
import 'package:wordle/models/chart_model.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/utils/calculate_stats.dart';
import 'package:wordle/utils/chart_series.dart';

class StatsBox extends StatefulWidget {
  const StatsBox({super.key});

  @override
  State<StatsBox> createState() => _StatsBoxState();
}

class _StatsBoxState extends State<StatsBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12,
          size.width * 0.08, size.height * 0.12),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: Icon(Icons.clear)),
          const Expanded(
              child: Text(
            'STATISTICS',
            textAlign: TextAlign.center,
          )),
          Expanded(
              flex: 2,
              child: FutureBuilder(
                future: getStats(),
                builder: (context, snapshot) {
                  List<String> results = ['0', '0', '0', '0', '0'];
                  if (snapshot.hasData) {
                    results = snapshot.data as List<String>;
                  }
                  return Row(
                    children: [
                      StatsTile(
                        heading: 'Played',
                        value: int.parse(results[0]),
                      ),
                      StatsTile(
                        heading: 'Win %',
                        value: int.parse(results[2]),
                      ),
                      StatsTile(
                        heading: 'Current\nStreak',
                        value: int.parse(results[3]),
                      ),
                      StatsTile(
                        heading: 'Max\nStreak',
                        value: int.parse(results[4]),
                      ),
                    ],
                  );
                },
              )),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: FutureBuilder(
                  future: getSeries(),
                  builder: (context, snapshot) {
                    final List<charts.Series<ChartModel, String>> series;
                    if (snapshot.hasData) {
                      series = snapshot.data
                          as List<charts.Series<ChartModel, String>>;
                      return Consumer<ThemeProvider>(
                        builder: (_, notifier, __) {
                          var color;
                          if (notifier.isDark) {
                            color = charts.MaterialPalette.white;
                          } else {
                            color = charts.MaterialPalette.black;
                          }
                          return charts.BarChart(
                            series,
                            vertical: false,
                            animate: false,
                            domainAxis: charts.OrdinalAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(
                                    lineStyle: charts.LineStyleSpec(
                                      color: charts.MaterialPalette.transparent,
                                    ),
                                    labelStyle: charts.TextStyleSpec(
                                      fontSize: 14,
                                      color: color,
                                    ))),
                            primaryMeasureAxis: const charts.NumericAxisSpec(
                              renderSpec: charts.GridlineRendererSpec(
                                lineStyle: charts.LineStyleSpec(
                                  color: charts.MaterialPalette.transparent,
                                ),
                                labelStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.transparent,
                                ),
                              ),
                            ),
                            barRendererDecorator: charts.BarLabelDecorator(
                                labelAnchor: charts.BarLabelAnchor.end,
                                outsideLabelStyleSpec: charts.TextStyleSpec(
                                  color: color,
                                )),
                            behaviors: [
                              charts.ChartTitle('GUESS DISTRIBUTION')
                            ],
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
          ),
          Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    keysMap.updateAll(
                        (key, value) => value = AnswerStage.notAnswered);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false);
                  },
                  child: const Text(
                    'Replay',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )))
        ],
      ),
    );
  }
}
