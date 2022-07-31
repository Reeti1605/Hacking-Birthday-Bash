import 'dart:ffi';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:async';
import 'results_page.dart';
import 'dart:math';
import 'package:record/record.dart';

class RecordScreen extends StatefulWidget {
  static const routeName = '/recordScreen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  StreamController<int> controller = StreamController<int>();

  //int moodIndex = 0;
  int score = 0;
  bool showLeaderBoard = false;

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
        displayMood = moods[moodIndex];
      });
    });
  }

  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  final record = Record();
  String _recorderTxt = "00:00:00";
  bool isRecording = false;
  String? path = '';
  String displayMessage = 'Tap the button and sing!';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () async {
                //Navigator.of(context).pushNamed(ResultScreen.routeName);
                if (!isRecording) {
                  setState(() {
                    isRecording = !isRecording;
                    displayMessage = 'Listening...';
                  });
                  if (await record.hasPermission()) {
                    // Start recording
                    await record.start(
                      encoder: AudioEncoder.wav, // by default
                      bitRate: 128000, // by default
                    );
                    print("RECORDING STARTED");
                  }
                } else {
                  setState(() {
                    isRecording = !isRecording;
                    displayMessage = 'Stopped';
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        score = Random().nextInt(10);
                        displayMessage = "Score: $score / 10";
                        showLeaderBoard = true;
                      });
                    });
                  });
                  path = await record.stop();
                  print("RECORDING STOPPED");
                  print("Path iss -- $path");
                }
              },
              child: Icon(isRecording ? Icons.stop : Icons.mic_sharp),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            const Text(
              'Tap to spin!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Mood selected: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(displayMood)
              ],
            ),
            const Divider(
              height: 20,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            displayMessage == 'Stopped'
                ? Center(child: CircularProgressIndicator())
                : Text(
                    displayMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
            SizedBox(
              height: 20,
            ),
            showLeaderBoard
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ResultScreen.routeName);
                    },
                    child: Text('Show leaderboard'))
                : Container()
          ],
        ),
      ),
    );
  }
}
