import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/record_page.dart';
import 'screens/results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark
        ),
        home: HomeScreen(),
        routes: {
          RecordScreen.routeName: (ctx) => RecordScreen(),
          ResultScreen.routeName: (cts) => ResultScreen(),
        });
  }
}
