import 'package:flutter/material.dart';
import 'dart:async';
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
  bool isAnimating = false;
  Timer? _timer;

  void startAnimation() {
    if (_timer != null && _timer!.isActive) return; 

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _currentRotateXValue = (_currentRotateXValue + 2) % 360;
        _currentRotateYValue = (_currentRotateYValue + 1) % 360;
      });
    });
  }

  void stopAnimation() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exo 2 - Animation & Transform')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            
            
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              child: Transform(
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
            ),
            
            SizedBox(height: 10), 

            // Rotate X
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotate X :', 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

            SizedBox(height: 10),

    
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotate Y :', 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

            SizedBox(height: 10),

    
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scale :', 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

        


            SwitchListTile(
              value: miroir,
              title: Text(
                "Effet Miroir",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onChanged: (bool value) {
                setState(() {
                  miroir = value;
                });
              },
            ),


            SwitchListTile(
              value: isAnimating,
              title: Text(
                "Activer Animation",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onChanged: (bool value) {
                setState(() {
                  isAnimating = value;
                  if (isAnimating) {
                    startAnimation();
                  } else {
                    stopAnimation();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
