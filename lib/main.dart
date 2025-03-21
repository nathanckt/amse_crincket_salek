import 'package:flutter/material.dart';
import 'exo1.dart';
import 'exo2.dart';
import 'exo4.dart';
import 'exo5.dart';
import 'exo6.dart';
import 'taquin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo1()),
                );
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo2()),
                );
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 4'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayTileWidget()),
                );
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Exercice 5'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo5()),
                );
              },
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              title: Text('Exercice 6'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo6()),
                );
              },
            ),
          ),
          Card(
            elevation: 7,
            child: ListTile(
              title: Text('Projet Taquin'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exo7()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
