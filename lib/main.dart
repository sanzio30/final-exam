import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = List.generate(3, (_) => List.generate(3, (_) => ' '));
  String currentPlayer = 'X';
  bool gameWon = false;

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ' '));
      currentPlayer = 'X';
      gameWon = false;
    });
  }

  bool checkWin(String player) {
    for (int i = 0; i < 3; i++) {
      if ((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
          (board[0][i] == player && board[1][i] == player && board[2][i] == player)) {
        return true;
      }
    }
    if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
        (board[0][2] == player && board[1][1] == player && board[2][0] == player)) {
      return true;
    }
    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains(' ')) {
        return false;
      }
    }
    return true;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == ' ' && !gameWon) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(currentPlayer)) {
          gameWon = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Game Over'),
              content: Text('Player $currentPlayer wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetBoard();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else if (isBoardFull()) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Game Over'),
              content: Text('It\'s a draw!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetBoard();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int row = 0; row < 3; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 3; col++)
                  GestureDetector(
                    onTap: () => makeMove(row, col),
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
