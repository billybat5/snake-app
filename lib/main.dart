import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const SnakeApp());
}

class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SnakeGameScreen(),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

enum Direction { up, down, left, right }

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int boardSize = 20; // 20x20 grid
  static const Duration gameSpeed = Duration(milliseconds: 200);

  List<int> snakePosition = [];
  int foodPosition = 0;
  Direction currentDirection = Direction.right;
  bool isPlaying = false;
  Timer? gameTimer;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      snakePosition = [45, 44, 43]; // Initial snake position
      foodPosition = 0;
      currentDirection = Direction.right;
      isPlaying = true;
      score = 0;
    });
    generateFood();
    gameTimer = Timer.periodic(gameSpeed, (timer) {
      if (isPlaying) {
        moveSnake();
      }
    });
  }

  void generateFood() {
    foodPosition = Random().nextInt(boardSize * boardSize);
    // Ensure food doesn't spawn on the snake
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(boardSize * boardSize);
    }
  }

  void moveSnake() {
    setState(() {
      int head = snakePosition.first;
      int newHead = 0;

      switch (currentDirection) {
        case Direction.up:
          newHead = head - boardSize;
          if (newHead < 0) newHead += (boardSize * boardSize); // Wrap around
          break;
        case Direction.down:
          newHead = head + boardSize;
          if (newHead >= (boardSize * boardSize)) newHead -= (boardSize * boardSize); // Wrap around
          break;
        case Direction.left:
          newHead = head - 1;
          if (head % boardSize == 0) newHead += boardSize; // Wrap around
          break;
        case Direction.right:
          newHead = head + 1;
          if ((head + 1) % boardSize == 0) newHead -= boardSize; // Wrap around
          break;
      }

      // Check for self-collision
      if (snakePosition.contains(newHead)) {
        endGame();
        return;
      }

      snakePosition.insert(0, newHead); // Add new head

      if (newHead == foodPosition) {
        score++;
        generateFood();
      } else {
        snakePosition.removeLast(); // Remove tail if no food eaten
      }
    });
  }

  void changeDirection(Direction newDirection) {
    if (isPlaying) {
      // Prevent immediate reverse
      if (newDirection == Direction.up && currentDirection == Direction.down) return;
      if (newDirection == Direction.down && currentDirection == Direction.up) return;
      if (newDirection == Direction.left && currentDirection == Direction.right) return;
      if (newDirection == Direction.right && currentDirection == Direction.left) return;
      currentDirection = newDirection;
    }
  }

  void endGame() {
    gameTimer?.cancel();
    setState(() {
      isPlaying = false;
    });
    _showGameOverDialog();
  }

  Future<void> _showGameOverDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your score: $score'),
                const Text('Do you want to play again?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  changeDirection(Direction.down);
                } else if (details.delta.dy < 0) {
                  changeDirection(Direction.up);
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  changeDirection(Direction.right);
                } else if (details.delta.dx < 0) {
                  changeDirection(Direction.left);
                }
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: boardSize,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (snakePosition.contains(index)) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  } else if (index == foodPosition) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }
                },
                itemCount: boardSize * boardSize,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: isPlaying ? endGame : startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPlaying ? Colors.red : Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: Text(isPlaying ? 'End Game' : 'Start Game'),
                ),
              ],
            ),
          ),
          // Control buttons for non-swipe input (optional, for desktop/keyboard)
          // You can add these if you want explicit buttons
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(onPressed: () => changeDirection(Direction.up), icon: Icon(Icons.arrow_upward)),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(onPressed: () => changeDirection(Direction.left), icon: Icon(Icons.arrow_back)),
          //     IconButton(onPressed: () => changeDirection(Direction.right), icon: Icon(Icons.arrow_forward)),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     IconButton(onPressed: () => changeDirection(Direction.down), icon: Icon(Icons.arrow_downward)),
          //   ],
          // ),
        ],
      ),
    );
  }
}