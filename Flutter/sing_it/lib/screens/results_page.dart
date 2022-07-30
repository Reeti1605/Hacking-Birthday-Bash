import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/resultScreen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int numberOfPlayers = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            itemCount: 30,
            itemBuilder: (ctx, index) {
              return index == 0
                  ? const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Card(
                      elevation: 5,
                      child: ListTile(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: Text("${index}"),
                        title: Text("P${index} name"),
                        trailing: Icon(TablerIcons.medal),
                      ),
                    );
            }),
      ),
    );
  }
}
