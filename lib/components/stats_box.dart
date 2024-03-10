import 'package:flutter/material.dart';

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
          Expanded(
              child: Text(
            'STATISTICS',
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
