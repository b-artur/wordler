import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/components/stats_box.dart';
import 'package:wordle/constants/words.dart';
import 'package:wordle/pages/settings.dart';
import 'package:wordle/providers/controller.dart';

import '../components/grid.dart';
import '../components/keyboard_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;

  @override
  void initState() {
    // TODO: implement initState
    final r = Random().nextInt(words.length);
    _word = words[r];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => StatsBox());
              },
              icon: Icon(Icons.bar_chart_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
                // Provider.of<ThemeProvider>(context, listen: false).setTheme();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 2,
          ),
          const Expanded(flex: 7, child: Grid()),
          Expanded(
              flex: 4,
              child: const Column(
                children: [
                  KeyboardRow(
                    min: 1,
                    max: 10,
                  ),
                  KeyboardRow(
                    min: 11,
                    max: 19,
                  ),
                  KeyboardRow(
                    min: 20,
                    max: 29,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
