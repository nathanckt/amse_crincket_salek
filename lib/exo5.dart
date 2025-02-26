import 'package:flutter/material.dart';

class Exo5 extends StatefulWidget {
  @override
  _Exo5State createState() => _Exo5State();
}

class _Exo5State extends State<Exo5> {
  int _gridSize = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exo 5 - Afficher une grille')),
      body: Column(
        children: [
          Expanded(child: Grid(gridSize: _gridSize)),
          Slider(
            value: _gridSize.toDouble(),
            min: 2,
            max: 6,
            divisions: 4,
            label: '$_gridSize x $_gridSize',
            onChanged: (double value) {
              setState(() {
                _gridSize = value.toInt();
              });
            },
          ),
        ],
      ),
    );
  }
}

class Grid extends StatelessWidget {
  final int gridSize;
  final String imagePath = 'https://picsum.photos/512/512';

  Grid({required this.gridSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double tileSize = constraints.maxWidth / gridSize; // Taille d'une case

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            int row = index ~/ gridSize;
            int col = index % gridSize;

            return SizedBox(
              width: tileSize,
              height: tileSize,
              child: ClipRect(
                child: Align(
                  alignment: Alignment(
                    -1.0 + (col * 2.0 / (gridSize - 1)),
                    -1.0 + (row * 2.0 / (gridSize - 1)),
                  ),
                  widthFactor: 1 / gridSize,
                  heightFactor: 1 / gridSize,
                  child: Image.network(imagePath, fit: BoxFit.cover),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

