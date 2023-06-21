import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage one = const AssetImage("assets/one.png");
  AssetImage two = const AssetImage("assets/two.png");
  AssetImage three = const AssetImage("assets/three.png");
  AssetImage four = const AssetImage("assets/four.png");
  AssetImage five = const AssetImage("assets/five.png");
  AssetImage six = const AssetImage("assets/six.png");

  late AssetImage diceimage;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      diceimage = one;
    });
  }

  void rollDice() {
    int random = (1 + Random().nextInt(6));
    AssetImage? newImage;

    switch (random) {
      case 1:
        newImage = one;
        break;
      case 2:
        newImage = two;
        break;
      case 3:
        newImage = three;
        break;
      case 4:
        newImage = four;
        break;
      case 5:
        newImage = five;
        break;
      case 6:
        newImage = six;
        break;
    }
    setState(() {
      diceimage = newImage!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dice Roller"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: diceimage,
                width: 200.0,
                height: 200.0,
              ),
              Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: ElevatedButton(
                    onPressed: rollDice,
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Background color of the button
                      textStyle: TextStyle(
                          color:
                              Colors.white), // Text color of the button's child
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8), // Padding around the button's child
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Border radius of the button
                      ),
                    ),
                    child: Text(
                      'Click Me',
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
