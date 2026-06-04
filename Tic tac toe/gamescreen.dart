import 'package:flutter/material.dart';

class Gamescreen extends StatefulWidget {
  const Gamescreen({super.key});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  bool oTurn = true;
  List<String> board = List.filled(9, '');

  int oScore = 0;
  int xScore = 0;
  int fillBox = 0;

  void _tap(int index) {
    if (board[index] != '') return;

    setState(() {
      board[index] = oTurn ? 'O' : 'X';
      fillBox++;
      oTurn = !oTurn;
    });

    _checkWinner();
  }

  void _checkWinner() {
    // Rows
    if (board[0] == board[1] && board[0] == board[2] && board[0] != '') {
      _showWinDialog(board[0]);
      return;
    }

    if (board[3] == board[4] && board[3] == board[5] && board[3] != '') {
      _showWinDialog(board[3]);
      return;
    }

    if (board[6] == board[7] && board[6] == board[8] && board[6] != '') {
      _showWinDialog(board[6]);
      return;
    }

    // Columns
    if (board[0] == board[3] && board[0] == board[6] && board[0] != '') {
      _showWinDialog(board[0]);
      return;
    }

    if (board[1] == board[4] && board[1] == board[7] && board[1] != '') {
      _showWinDialog(board[1]);
      return;
    }

    if (board[2] == board[5] && board[2] == board[8] && board[2] != '') {
      _showWinDialog(board[2]);
      return;
    }

    // Diagonals
    if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
      _showWinDialog(board[0]);
      return;
    }

    if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
      _showWinDialog(board[2]);
      return;
    }

    // Draw
    if (fillBox == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    setState(() {
      if (winner == 'O') {
        oScore++;
      } else {
        xScore++;
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Winner is $winner 🎉'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _clearBoard();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Draw 🤝'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _clearBoard();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      board = List.filled(9, '');
      fillBox = 0;
      oTurn = true;
    });
  }

  void _clearScoreBoard() {
    setState(() {
      board = List.filled(9, '');
      fillBox = 0;
      oTurn = true;
      oScore = 0;
      xScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC56ECA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Score Board
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Player X',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      xScore.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 60),

                Column(
                  children: [
                    const Text(
                      'Player O',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      oScore.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double boardSize = constraints.maxWidth > 700
                        ? 400
                        : constraints.maxWidth * 0.75;

                    return SizedBox(
                      width: boardSize,
                      height: boardSize,
                      child: GridView.builder(
                        itemCount: 9,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _tap(index),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  board[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: boardSize * 0.12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
                onPressed: _clearScoreBoard,
                child: const Text(
                  'Clear Score Board',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
