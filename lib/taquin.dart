import 'package:flutter/material.dart';
import 'dart:math';

class Exo7 extends StatefulWidget {
  @override
  _Exo7State createState() => _Exo7State();
}

class _Exo7State extends State<Exo7> {
  static const int gridSize = 3;
  List<List<int>> grid = [];
  final String imagePath = 'https://picsum.photos/512/512';

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    List<int> numbers = List.generate(gridSize * gridSize, (index) => index);
    numbers.shuffle(Random());
    grid = List.generate(gridSize, (i) => numbers.sublist(i * gridSize, (i + 1) * gridSize));
  }

  Tuple2<int, int> _findEmptyTile() {
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) return Tuple2(i, j);
      }
    }
    throw Exception("No empty tile found!");
  }

  void _moveTile(int i, int j) {
    var emptyPos = _findEmptyTile();
    int emptyI = emptyPos.item1, emptyJ = emptyPos.item2;

    if ((i == emptyI && (j - emptyJ).abs() == 1) || (j == emptyJ && (i - emptyI).abs() == 1)) {
      setState(() {
        grid[emptyI][emptyJ] = grid[i][j];
        grid[i][j] = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taquin - Exo 7')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(gridSize, (i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gridSize, (j) {
                return GestureDetector(
                  onTap: () => _moveTile(i, j),
                  child: ClipRect(
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: grid[i][j] == 0 ? Colors.grey : Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: grid[i][j] == 0
                          ? SizedBox.shrink()
                          : FittedBox(
                              fit: BoxFit.none,
                              alignment: Alignment(
                                -1.0 + ((grid[i][j] % gridSize) * 2.0 / (gridSize - 1)),
                                -1.0 + ((grid[i][j] ~/ gridSize) * 2.0 / (gridSize - 1)),
                              ),
                              child: Image.network(
                                imagePath,
                                width: 240,
                                height: 240,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => setState(_initializeGrid),
      ),
    );
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;
  Tuple2(this.item1, this.item2);
}
