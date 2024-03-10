import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/pages/settings.dart';
import 'package:wordle/providers/controller.dart';
import 'package:wordle/providers/theme_provider.dart';
import 'package:wordle/themes/theme_preferences.dart';
import 'package:wordle/themes/themes.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Controller()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: false,
      future: ThemePreferences.getTheme(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            print('snapshot data ${snapshot.data}');
            Provider.of<ThemeProvider>(context, listen: false)
                .setTheme(turnOn: snapshot.data as bool);
          });
        }
        return Consumer<ThemeProvider>(
          builder: (_, notifier, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wordle',
            theme: notifier.isDark ? darkTheme : lightTheme,
            home: const HomePage(),
          ),
        );
      },
    );
  }
}