import 'package:flutter/material.dart';
import 'package:wordle/components/stats_tile.dart';

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
              onPressed: () {},
              icon: Icon(Icons.clear)),
          const Expanded(
              child: Text(
            'STATISTICS',
            textAlign: TextAlign.center,
          )),
          const Expanded(
              child: Row(
            children: [
              StatsTile(
                heading: 'Played',
                value: 50,
              ),
              StatsTile(
                heading: 'Win %',
                value: 90,
              ),
              StatsTile(
                heading: 'Current\nStreak',
                value: 12,
              ),
              StatsTile(
                heading: 'Max\nStreak',
                value: 15,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
