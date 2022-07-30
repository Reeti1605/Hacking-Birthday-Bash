import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../screens/record_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int numberOfPlayers = 2;
  List<TextEditingController> _controllers = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            for (TextEditingController c in _controllers) {
              print(c.text);
            }
            Navigator.of(context).pushNamed(RecordScreen.routeName);
          },
          child: const Text('Sing!'),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter number of players: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      value: numberOfPlayers,
                      onChanged: (int? newValue) {
                        setState(() {
                          numberOfPlayers = newValue!;
                          print("Players = $numberOfPlayers");
                        });
                      },
                      items: <int>[2, 3, 4]
                          .map<DropdownMenuItem<int>>(
                            (value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              const Text(
                "Player names:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  _controllers.add(new TextEditingController());
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "P${index + 1} name",
                          fillColor: Colors.white70),
                    ),
                  );
                },
                itemCount: numberOfPlayers,
              )
            ],
          ),
        ),
      ),
    );
  }
}
