import 'dart:math';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static const int gridRows = 8;
  static const int gridCols = 8;

  final List<String> candyImages = [
    'assets/redcandy.png',
    'assets/greencandy.png',
    'assets/yellow.png',
    'assets/purple.png',
    'assets/orange.png',
    'assets/blue.png',
  ];

  late List<List<String>> grid;

  int score = 0;
  int? selectedRow;
  int? selectedCol;

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    final random = Random();

    grid = List.generate(
      gridRows,
      (_) => List.filled(gridCols, candyImages.first),
    );

    for (int r = 0; r < gridRows; r++) {
      for (int c = 0; c < gridCols; c++) {
        List<String> validCandies = List.from(candyImages);

        if (c >= 2 && grid[r][c - 1] == grid[r][c - 2]) {
          validCandies.remove(grid[r][c - 1]);
        }

        if (r >= 2 && grid[r - 1][c] == grid[r - 2][c]) {
          validCandies.remove(grid[r - 1][c]);
        }

        grid[r][c] =
            validCandies[random.nextInt(validCandies.length)];
      }
    }

    score = 0;
    selectedRow = null;
    selectedCol = null;
  }

  void _onTileTap(int row, int col) {
    if (selectedRow == null || selectedCol == null) {
      setState(() {
        selectedRow = row;
        selectedCol = col;
      });
      return;
    }

    int rowDiff = (row - selectedRow!).abs();
    int colDiff = (col - selectedCol!).abs();

    if ((rowDiff == 1 && colDiff == 0) ||
        (rowDiff == 0 && colDiff == 1)) {
      swapCandies(
        selectedRow!,
        selectedCol!,
        row,
        col,
      );
    }

    setState(() {
      selectedRow = null;
      selectedCol = null;
    });
  }

  void swapCandies(int r1, int c1, int r2, int c2) {
    setState(() {
      String temp = grid[r1][c1];
      grid[r1][c1] = grid[r2][c2];
      grid[r2][c2] = temp;
    });

    if (!checkAndClearMatches()) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;

        setState(() {
          String temp = grid[r1][c1];
          grid[r1][c1] = grid[r2][c2];
          grid[r2][c2] = temp;
        });
      });
    }
  }

  bool checkAndClearMatches() {
    List<List<bool>> matched = List.generate(
      gridRows,
      (_) => List.generate(gridCols, (_) => false),
    );

    bool foundMatch = false;

    // Horizontal
    for (int r = 0; r < gridRows; r++) {
      int c = 0;

      while (c < gridCols) {
        int count = 1;

        while (c + count < gridCols &&
            grid[r][c] == grid[r][c + count] &&
            grid[r][c].isNotEmpty) {
          count++;
        }

        if (count >= 3) {
          foundMatch = true;
          for (int i = 0; i < count; i++) {
            matched[r][c + i] = true;
          }
        }

        c += count;
      }
    }

    // Vertical
    for (int c = 0; c < gridCols; c++) {
      int r = 0;

      while (r < gridRows) {
        int count = 1;

        while (r + count < gridRows &&
            grid[r][c] == grid[r + count][c] &&
            grid[r][c].isNotEmpty) {
          count++;
        }

        if (count >= 3) {
          foundMatch = true;
          for (int i = 0; i < count; i++) {
            matched[r + i][c] = true;
          }
        }

        r += count;
      }
    }

    if (foundMatch) {
      clearAndFillGrid(matched);
    }

    return foundMatch;
  }

  void clearAndFillGrid(List<List<bool>> matched) {
    int clearedCount = 0;

    setState(() {
      for (int r = 0; r < gridRows; r++) {
        for (int c = 0; c < gridCols; c++) {
          if (matched[r][c]) {
            grid[r][c] = '';
            clearedCount++;
          }
        }
      }

      score += clearedCount * 5;
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;

      setState(() {
        final random = Random();

        for (int c = 0; c < gridCols; c++) {
          List<String> column = [];

          for (int r = 0; r < gridRows; r++) {
            if (grid[r][c].isNotEmpty) {
              column.add(grid[r][c]);
            }
          }

          while (column.length < gridRows) {
            column.insert(
              0,
              candyImages[random.nextInt(candyImages.length)],
            );
          }

          for (int r = 0; r < gridRows; r++) {
            grid[r][c] = column[r];
          }
        }
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          checkAndClearMatches();
        }
      });
    });
  }

  Widget buildCandyTile(int r, int c, bool isSelected) {
    return GestureDetector(
      onTap: () => _onTileTap(r, c),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: isSelected ? 3 : 0,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Colors.white70,
                    blurRadius: 8,
                  ),
                ]
              : [],
        ),
        child: ClipOval(
          child: Image.asset(
            grid[r][c],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 146, 61, 75),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 123, 177),
        title: const Text('Candy Crush',style: TextStyle(
          fontSize: 28,fontFamily: "Times-BoldItalic",color: Colors.white,
        ),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                initializeGrid();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/image.png",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Score: $score',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GridView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: gridRows * gridCols,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCols,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          int r = index ~/ gridCols;
                          int c = index % gridCols;

                          bool isSelected =
                              r == selectedRow && c == selectedCol;

                          return buildCandyTile(r, c, isSelected);
                        },
                      ),
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