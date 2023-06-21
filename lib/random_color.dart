import 'dart:math';
import 'package:flutter/material.dart';

class RandomColors extends StatefulWidget {
  const RandomColors({super.key});

  @override
  State<RandomColors> createState() => _RandomColorsState();
}

class _RandomColorsState extends State<RandomColors> {
  var colors = [
    Colors.blue,
    Colors.black,
    Colors.amber,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.green,
    Colors.red,
    Colors.orange,
  ];

  var currentColor = Colors.white;

  setRandomColors() {
    var rnd = Random().nextInt(colors.length);
    setState(() {
      currentColor = colors[rnd];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: currentColor,
          child: Container(
            child: ElevatedButton(
              // color: Colors.black,
              // padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text(
                "click",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setRandomColors();
              },
            ),
          ),
        ),
      ),
    );
  }
}
