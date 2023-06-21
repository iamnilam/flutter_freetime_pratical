import 'package:flutter/material.dart';

class HomeTic extends StatefulWidget {
  const HomeTic({super.key});

  @override
  State<HomeTic> createState() => _HomeTicState();
}

class _HomeTicState extends State<HomeTic> {
  //Todo link upimages

  bool iscross = true;
  late String message;
  late List<String> gameState;

  AssetImage cross = const AssetImage("assets/cross.png");
  AssetImage circle = const AssetImage("assets/circle.png");
  AssetImage edit = const AssetImage("assets/edit.png");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.iscross) {
          this.gameState[index] = "cross";
          // this.iscross = false;
        } else {
          this.gameState[index] = "circle";
          // this.iscross = true;
        }
        this.iscross = !this.iscross;
        this.checkWin();
      });
    }
  }

  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case 'empty':
        return edit;
      case 'cross':
        return cross;
      case 'circle':
        return circle;
      default:
        return edit; // Add a default case here or choose an appropriate fallback image
    }
  }

  checkWin() {
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} Wins';
      });
    } else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} Wins';
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} Wins';
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} Wins';
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} Wins';
      });
    } else if (!gameState.contains("empty")) {
      setState(() {
        this.message = "Game Draw";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    playGame(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Image(
                        image: getImage(gameState[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Reset'),
          ),
          Text(message),
        ],
      ),
    );
  }
}
