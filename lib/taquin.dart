import 'package:flutter/material.dart';
import 'dart:math';

class Exo7 extends StatefulWidget {
  @override
  _Exo7State createState() => _Exo7State();
}

class _Exo7State extends State<Exo7> {
  int gridSize = 3;
  List<List<int>> grid = [];
  int moveCount = 0;
  String imagePath = 'https://picsum.photos/512/512';
  List<int> originalOrder = [];
  List<String> assetImages = ['assets/1.png', 'assets/2.png', 'assets/3.png'];
  bool showNumbers = false;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    moveCount = 0;
    originalOrder =
        List.generate(gridSize * gridSize, (index) => index); // Commence à 0
    List<int> numbers = List.from(originalOrder);
    do {
      numbers.shuffle(Random());
    } while (!_isSolvable(numbers));
    grid = List.generate(
        gridSize, (i) => numbers.sublist(i * gridSize, (i + 1) * gridSize));
  }

  bool _isSolvable(List<int> numbers) {
    int inversions = 0;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] > numbers[j] && numbers[i] != 0 && numbers[j] != 0) {
          inversions++;
        }
      }
    }

    if (gridSize.isOdd) {
      // Pour les grilles de taille impaire, le nombre d'inversions doit être pair
      return inversions.isEven;
    } else {
      // Pour les grilles de taille paire, on ajoute la ligne de la case vide (en partant du bas)
      int emptyRow = gridSize - (numbers.indexOf(0) ~/ gridSize);
      return (inversions + emptyRow).isEven;
    }
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

    if ((i == emptyI && (j - emptyJ).abs() == 1) ||
        (j == emptyJ && (i - emptyI).abs() == 1)) {
      setState(() {
        grid[emptyI][emptyJ] = grid[i][j];
        grid[i][j] = 0;
        moveCount++;
        if (_isWin()) {
          _showWinDialog();
        }
      });
    }
  }

  bool _isWin() {
    int expectedValue = 0;
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] != expectedValue) {
          return false;
        }
        expectedValue++;
      }
    }
    return true;
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Félicitations !"),
        content: Text("Vous avez gagné en $moveCount coups !"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(_initializeGrid);
            },
            child: Text("Recommencer"),
          )
        ],
      ),
    );
  }

  void _selectImage(String path) {
    setState(() {
      imagePath = path;
      _initializeGrid();
    });
  }

  void _selectRandomImage() {
    setState(() {
      imagePath =
          'https://picsum.photos/512?random=${DateTime.now().millisecondsSinceEpoch}';
      _initializeGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 300 / gridSize;

    return Scaffold(
      appBar: AppBar(
        title: Text('Taquin - Exo 7'),
        actions: [
          IconButton(
            icon: Icon(showNumbers ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                showNumbers = !showNumbers;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Nombre de coups : $moveCount", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(gridSize, (i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(gridSize, (j) {
                      int tileNumber = grid[i][j];
                      return GestureDetector(
                        onTap: () => _moveTile(i, j),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: tileSize,
                          height: tileSize,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: tileNumber == 0 ? Colors.white : Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: tileNumber == 0
                              ? SizedBox.shrink()
                              : Stack(
                                  children: [
                                    ClipRect(
                                      child: FittedBox(
                                        fit: BoxFit.none,
                                        alignment: Alignment(
                                            -1.0 +
                                                ((tileNumber % gridSize) *
                                                    2.0 /
                                                    (gridSize - 1)),
                                            -1.0 +
                                                ((tileNumber ~/ gridSize) *
                                                    2.0 /
                                                    (gridSize - 1))),
                                        child: Image.network(
                                          imagePath,
                                          width: 300,
                                          height: 300,
                                        ),
                                      ),
                                    ),
                                    if (showNumbers)
                                      Center(
                                        child: Text(
                                          '$tileNumber',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Taille de la grille : $gridSize x $gridSize"),
                Slider(
                  value: gridSize.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 4,
                  label: '$gridSize x $gridSize',
                  onChanged: (double value) {
                    setState(() {
                      gridSize = value.toInt();
                      _initializeGrid();
                    });
                  },
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _selectRandomImage,
                      child: Text('Image aléatoire'),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectImage(assetImages[0]),
                      child: Text('Niveau 1'),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectImage(assetImages[1]),
                      child: Text('Niveau 2'),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectImage(assetImages[2]),
                      child: Text('Niveau 3'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
