import 'package:flutter/material.dart';
import 'exo1.dart'; 
import 'exo2.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Exo2(),
    );
  }
}

