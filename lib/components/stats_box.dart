import 'package:flutter/material.dart';
import 'package:wordle/components/stats_tile.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/keys_map.dart';
import 'package:wordle/main.dart';
import 'package:wordle/utils/calculate_stats.dart';

class StatsBox extends StatefulWidget {
  const StatsBox({super.key});

  @override
  State<StatsBox> createState() => _StatsBoxState();
}

class _StatsBoxState extends State<StatsBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
