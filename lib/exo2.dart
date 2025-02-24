import 'package:flutter/material.dart';
import 'dart:math';

class Exo2 extends StatefulWidget {
  @override
  _Exo2State createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  double _currentRotateXValue = 0;
  double _currentRotateYValue = 0;
  double _currentScaleValue = 1.0;
  bool miroir = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exo 2 - Afficher une image et sliders')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            
            
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_currentRotateXValue * pi / 180) 
                ..rotateY(_currentRotateYValue * pi / 180) 
                ..scale(miroir ? -_currentScaleValue : _currentScaleValue), 
              child: Image.network(
                'https://picsum.photos/512/1024',
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            
            SizedBox(height: 16), 

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotate X :', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _currentRotateXValue,
                  min: 0,
                  max: 360,
                  onChanged: (double value) {
                    setState(() {
                      _currentRotateXValue = value;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotate Y :', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _currentRotateYValue,
                  min: 0,
                  max: 360,
                  onChanged: (double value) {
                    setState(() {
                      _currentRotateYValue = value;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scale :', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _currentScaleValue,
                  min: 0.5,
                  max: 2.0,
                  onChanged: (double value) {
                    setState(() {
                      _currentScaleValue = value;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            
            SwitchListTile(
              value: miroir,
              title: Text(
                "Effet Miroir",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onChanged: (bool value) {
                setState(() {
                  miroir = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


