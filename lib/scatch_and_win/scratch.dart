import 'dart:math';

import 'package:flutter/material.dart';

class ScratchScreen extends StatefulWidget {
  const ScratchScreen({super.key});

  @override
  State<ScratchScreen> createState() => _ScratchScreenState();
}

class _ScratchScreenState extends State<ScratchScreen> {
  //TODO import images
  AssetImage circle = const AssetImage("assets/circle.png");
  AssetImage lucky = const AssetImage("assets/rupee.png");
  AssetImage unluck = const AssetImage("assets/sadFace.png");

  //Todo get an array
  late List<String> itemArray;
  late int luckyNumber;

  //Todo init array with 25 element
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //Todo define a getImage method
  getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
      case "unluck":
        return unluck;
    }
    return circle;
  }

  //Todo play game method
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unluck";
      });
    }
  }

  //Todo show all
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //Todo reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scratch and win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemCount: itemArray.length,
            itemBuilder: (context, i) => SizedBox(
              width: 50.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () {
                    playGame(i);
                  },
                  child: Image(
                    image: getImage(i),
                  )),
            ),
          )),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                onPressed: () {
                  showAll();
                },
                child: const Text("Show All")),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                onPressed: () {
                  resetGame();
                },
                child: const Text("reset All")),
          )
        ],
      ),
    );
  }
}
