import 'package:flutter/material.dart';
import 'package:my_pratical_project/api/api_new_screen.dart';
import 'package:my_pratical_project/api/api_screen.dart';
import 'package:my_pratical_project/camera/camera.dart';
import 'package:my_pratical_project/drawer/signup.dart';
import 'package:my_pratical_project/music/music_screen.dart';
import 'package:my_pratical_project/random_color.dart';
import 'package:my_pratical_project/roller_game/home_page.dart';
import 'package:my_pratical_project/sqflite/screens/note_list.dart';
import 'package:my_pratical_project/tictactoe/hometic.dart';

import 'scatch_and_win/scratch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteList(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  List<String> snapanis = [
    "one",
    "two",
    "tree",
    "four",
    "six",
    "seven",
    "eight",
    "nine",
    "ten"
  ];

  String defaultText = "Snananana";

  void displaysNumber() {
    setState(() {
      defaultText = snapanis[counter];
      if (counter < 10) {
        counter = counter + 1;
      } else {
        counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("fjdklfgdlkgj"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                defaultText,
              ),
              TextButton(
                  onPressed: displaysNumber, child: const Text("click me"))
            ],
          ),
        ));
  }
}
