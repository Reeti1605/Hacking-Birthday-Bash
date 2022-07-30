import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'results_page.dart';
import 'dart:math';

class RecordScreen extends StatefulWidget {
  static const routeName = '/recordScreen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  StreamController<int> controller = StreamController<int>();

  //int moodIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.close();
    super.dispose();
  }

  static const moods = <String>[
    'Neutral',
    'Energetic',
    'Surprise',
    'Sad',
    'Just Sing!'
  ];
  int moodIndex = Random().nextInt(moods.length);
  String displayMood = "...";

  void spin() {
    moodIndex = Random().nextInt(moods.length);
    setState(() {
      controller.add(moodIndex);
      print(moodIndex);
    });
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        displayMood=moods[moodIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ResultScreen.routeName);
          },
          child: Text('Show results!'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              height: 300,
              child: GestureDetector(
                onTap: () {
                  spin();
                },
                child: Column(
                  children: [
                    Expanded(
                        child: FortuneWheel(
                      selected: controller.stream,
                      items: [
                        for (String mood in moods)
                          FortuneItem(child: Text(mood))
                      ],
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mood selected: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(displayMood)
              ],
            )
          ],
        ),
      ),
    );
  }
}
